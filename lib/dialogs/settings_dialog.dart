import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:gif_macro/utils.dart';
import 'package:gif_macro/widgets/keybind_widget.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:provider/provider.dart';

import '../store/settings_store.dart' as settings_store;
import '../store/image_store.dart' as image_store;

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({required this.onConfirmed, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsDialogState();

  final void Function() onConfirmed;
}

class _SettingsDialogState extends State<SettingsDialog> {
  Future<List<image_store.Image>?> _importJson() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["json"]);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final string = await file.readAsString();
      List<dynamic> decoded = jsonDecode(string);
      var images = await Future.wait(
        decoded
            .map((e) => image_store.Image.fromJson(e as Map<String, dynamic>))
            .map(
              (e) => processUrl(e.url).then(
                (value) {
                  e.url = value;
                  return e;
                },
              ),
            ),
      );
      return images;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    context
        .watch<settings_store.SettingsProvider>()
        .getSettings()
        .then((value) => setState(() => _settings = value));

    return ContentDialog(
      title: const Align(child: Text("Settings")),
      actions: [
        Button(
          child: const Text("Ok"),
          onPressed: () => widget.onConfirmed(),
        )
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text("Show/Hide window keybind"),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: KeybindWidget(
                    keys: _settings?.toggleWindowKeybind
                        .map((e) => LogicalKeyboardKey(e))
                        .toList(),
                    onBound: (e) => context
                        .read<settings_store.SettingsProvider>()
                        .setToggleWindowKeybind(
                          e.map((e) => e.keyId).toList(),
                        ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text("Run on startup"),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Checkbox(
                    checked: _settings?.runOnStartup ?? false,
                    style: const CheckboxThemeData(
                        margin: EdgeInsets.symmetric(horizontal: 1)),
                    onChanged: (value) {
                      if (value ?? false) {
                        launchAtStartup.enable();
                      } else {
                        launchAtStartup.disable();
                      }
                      context
                          .read<settings_store.SettingsProvider>()
                          .setRunOnStartup(value ?? false);
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(children: [
            Button(
              child: const Text("Import JSON"),
              onPressed: () {
                _importJson().then((images) {
                  if (images != null) {
                    context
                        .read<image_store.ImagesProvider>()
                        .addImages(images);
                  }
                });
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Button(
                  child: const Text("Export JSON"),
                  onPressed: () {
                    FilePicker.platform.saveFile(
                        fileName: "gifs.json",
                        type: FileType.custom,
                        allowedExtensions: ["json"]).then(
                      (result) async {
                        if (result != null) {
                          final images = await context
                              .read<image_store.ImagesProvider>()
                              .getImages();

                          final json = jsonEncode(images);
                          final file = File(result);
                          await file.writeAsString(json);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  settings_store.Settings? _settings;
}
