import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gif_macro/dialogs/gif_edit_dialog.dart';
import 'package:gif_macro/pages/idle.dart';
import 'package:gif_macro/pages/permission_request.dart';
import 'package:gif_macro/store/focus_store.dart';
import 'package:hid_listener/hid_listener.dart';
import 'package:isar/isar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';

import 'store/image_store.dart' as store;
import 'store/settings_store.dart' as settings_store;
import 'dialogs/gif_creator_dialog.dart';
import 'dialogs/settings_dialog.dart';
import 'widgets/clickable_gif_widget.dart';

List<int> _pressedKeys = List.empty(growable: true);
List<LogicalKeyboardKey> _toggleWindowKeybind = List.empty(growable: true);
bool _hidden = false;
bool _globalListening = true;
final FocusProvider _focusNotifier = FocusProvider();

Future<void> _loadBinds(settings_store.SettingsProvider provider) async {
  final settings = await provider.getSettings();
  final keys =
      settings.toggleWindowKeybind.map((e) => LogicalKeyboardKey(e)).toList();
  _toggleWindowKeybind = keys;
}

bool _checkBind(List<int> pressedKeys, List<LogicalKeyboardKey> bind) {
  if (bind.isEmpty) return false;
  for (var key in bind) {
    if (!pressedKeys.contains(key.keyId)) {
      return false;
    }
  }
  return true;
}

void _hideWindow() {
  windowManager.hide();
  navigatorKey.currentState?.popAndPushNamed('/idle');
  _hidden = true;
}

void _showWindow() {
  navigatorKey.currentState?.popAndPushNamed('/');
  windowManager.show();
  windowManager.setAlwaysOnTop(true).then(
        (e) => {windowManager.setAlwaysOnTop(false)},
      ); // ensure the window is brought on top
  windowManager.focus();
  _focusNotifier.focus();
  _hidden = false;
}

void _keyboardListener(RawKeyEvent event) async {
  if (event is RawKeyDownEvent) {
    if (!_pressedKeys.contains(event.logicalKey.keyId)) {
      _pressedKeys.add(event.logicalKey.keyId);
    }
  } else {
    _pressedKeys.remove(event.logicalKey.keyId);
  }

  if (!_globalListening) return;
  if (_checkBind(_pressedKeys, _toggleWindowKeybind)) {
    _pressedKeys
        .clear(); // doing this so if we stop receiving events after showing/hiding the window we don't react to any keypress as a bind
    _hidden = !_hidden;
    if (_hidden) {
      _hideWindow();
    } else {
      _showWindow();
    }
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class _WindowListener with WindowListener {
  @override
  void onWindowRestore() {
    _showWindow();
    super.onWindowRestore();
  }

  @override
  void onWindowBlur() {
    _hideWindow();
    super.onWindowBlur();
  }

  @override
  void onWindowMinimize() {
    _hideWindow();
    super.onWindowMinimize();
  }
}

void main() async {
  var initialRoute = '/';
  if (registerKeyboardListener(_keyboardListener) == null) {
    initialRoute = '/permissionRequest';
  }

  WidgetsFlutterBinding.ensureInitialized();

  final packageInfo = await PackageInfo.fromPlatform();

  LaunchAtStartup.instance.setup(
      appName: packageInfo.appName, appPath: Platform.resolvedExecutable);

  final isar =
      await Isar.open([store.ImageSchema, settings_store.SettingsSchema]);

  final settingsProvider = settings_store.SettingsProvider(isar: isar);
  await settingsProvider
      .setRunOnStartup(await LaunchAtStartup.instance.isEnabled());

  await _loadBinds(settingsProvider);

  settingsProvider.addListener(() async {
    await _loadBinds(settingsProvider);
  });

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.addListener(_WindowListener());

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => store.ImagesProvider(isar: isar)),
        ChangeNotifierProvider(create: (context) => settingsProvider),
        ChangeNotifierProvider(create: (context) => _focusNotifier)
      ],
      child: MyApp(
        initialRoute: initialRoute,
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.initialRoute, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        title: "GifMacro",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            scrollbarTheme: const ScrollbarThemeData(thickness: 5.0),
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: initialRoute,
        navigatorKey: navigatorKey,
        routes: {
          '/': (_) => const MainPage(),
          '/permissionRequest': (_) => const PermissionRequestPage(),
          '/idle': (_) => const IdlePage(),
        });
  }

  final String initialRoute;
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    context
        .watch<store.ImagesProvider>()
        .queryImages(_query)
        .then((value) => setState(() => _matchingImages = value));

    context
        .watch<FocusProvider>()
        .addListener(() => {_searchFocus.requestFocus()});

    return NavigationView(
        appBar: NavigationAppBar(
            leading: IconButton(
              icon: const Icon(FluentIcons.add),
              onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) {
                      return GifCreator(
                          onConfirmed: (image) {
                            context
                                .read<store.ImagesProvider>()
                                .addImage(image);
                            Navigator.pop(context);
                          },
                          onCancelled: () => Navigator.pop(context),
                          image: store.Image(url: ""));
                    })
              },
            ),
            actions: SizedBox(
                width: kCompactNavigationPaneWidth,
                child: Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                    child: IconButton(
                      icon: const Icon(FluentIcons.settings),
                      onPressed: () {
                        _globalListening = false;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SettingsDialog(onConfirmed: () {
                                Navigator.pop(context);
                                _globalListening = true;
                              });
                            });
                      },
                    ))),
            title: MoveWindow(
                child: const Align(
                    alignment: AlignmentDirectional.center,
                    child: Text("GifMacro")))),
        content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormBox(
                  placeholder: "Search for your gifs using a shorthand or tags",
                  onChanged: (value) => setState(() => _query = value),
                  autofocus: true,
                  focusNode: _searchFocus,
                  minHeight: 40,
                  padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 7.0),
                  textAlignVertical: TextAlignVertical.center,
                  prefix: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 8.0, end: 1.0),
                    child: Icon(FluentIcons.search),
                  ),
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: MasonryGridView.count(
                            crossAxisCount: 5,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            padding: const EdgeInsets.only(right: 14.0),
                            itemCount: _matchingImages.length,
                            itemBuilder: (context, index) {
                              return ClickableGifWidget(
                                  accentColor: SystemTheme.accentColor.accent
                                      .toAccentColor(), // todo: get from theme
                                  image: _matchingImages[index],
                                  onClick: (image) {
                                    Clipboard.setData(
                                        ClipboardData(text: image.url));
                                    _hideWindow();
                                  },
                                  onRightClick: (image) => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return GifEditDialog(
                                            image: image,
                                            onConfirmed: (image) {
                                              context
                                                  .read<store.ImagesProvider>()
                                                  .addImage(image);
                                              Navigator.pop(context);
                                            },
                                            onDeleted: (image) {
                                              context
                                                  .read<store.ImagesProvider>()
                                                  .removeImage(image);
                                              Navigator.pop(context);
                                            },
                                            onCancelled: () =>
                                                Navigator.pop(context));
                                      }));
                            }))),
              ],
            )));
  }

  String _query = "";
  List<store.Image> _matchingImages = List.empty();
  final _searchFocus = FocusNode(onKey: (node, event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey.keyLabel == "Arrow Down") {
        node.nextFocus();
      }
    }
    return KeyEventResult.ignored;
  });
}
