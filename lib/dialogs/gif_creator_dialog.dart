import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gif_macro/utils.dart';
import 'package:gif_macro/widgets/gif_widget.dart';

import '../store/image_store.dart' as store;

class GifCreator extends StatefulWidget {
  const GifCreator({
    required this.image,
    required this.onConfirmed,
    required this.onCancelled,
    Key? key,
  }) : super(key: key);

  @override
  State<GifCreator> createState() => _GifCreatorState();

  final store.Image image;
  final void Function(store.Image image) onConfirmed;
  final void Function() onCancelled;
}

class _GifCreatorState extends State<GifCreator> {
  @override
  void initState() {
    _image = widget.image;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
        title: const Align(child: Text("Adding a gif")),
        actions: [
          Button(
            child: const Text("Cancel"),
            onPressed: () => widget.onCancelled(),
          ),
          Button(
            child: const Text("Confirm"),
            onPressed: () => widget.onConfirmed(_image),
          )
        ],
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_image.url.isNotEmpty)
                Expanded(
                    child:
                        GifWidget(url: _image.url, imageFit: BoxFit.scaleDown)),
              const SizedBox(height: 25),
              InfoLabel(
                  label: "GIF URL",
                  child: TextFormBox(
                    placeholder: "URL",
                    autofocus: true,
                    onChanged: (value) => processUrl(value).then(
                      (url) => {
                        setState(() => {_image.url = url})
                      },
                    ),
                  )),
              const SizedBox(height: 10),
              InfoLabel(
                  label: "GIF Shorthand",
                  child: TextFormBox(
                    placeholder: "Shorthand",
                    onChanged: (value) => {
                      setState(() => {_image.shorthand = value})
                    },
                  )),
              const SizedBox(height: 10),
              InfoLabel(
                  label: "GIF Tags",
                  child: TextFormBox(
                    placeholder:
                        "Comma separated list of tags, e.g: amogus, moyai, crab",
                    onChanged: (value) => {
                      setState(() => {_image.tags = value.split(", ")})
                    },
                  ))
            ]));
  }

  late store.Image _image;
}
