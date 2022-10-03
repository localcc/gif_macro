import 'package:fluent_ui/fluent_ui.dart';
import 'package:gif_macro/widgets/gif_widget.dart';

import '../store/image_store.dart' as store;

class GifEditDialog extends StatefulWidget {
  const GifEditDialog({
    required this.image,
    required this.onConfirmed,
    required this.onDeleted,
    required this.onCancelled,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GifEditDialogState();

  final store.Image image;

  final void Function(store.Image) onConfirmed;
  final void Function(store.Image) onDeleted;
  final void Function() onCancelled;
}

class _GifEditDialogState extends State<GifEditDialog> {
  @override
  void initState() {
    _image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
        title: const Align(child: Text("Editing a gif")),
        actions: [
          Button(
            child: const Text("Cancel"),
            onPressed: () => widget.onCancelled(),
          ),
          Button(
            child: const Text("Delete"),
            onPressed: () => widget.onDeleted(_image),
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
              Expanded(
                  child:
                      GifWidget(url: _image.url, imageFit: BoxFit.scaleDown)),
              const SizedBox(height: 25),
              InfoLabel(
                  label: "GIF Shorthand",
                  child: TextFormBox(
                    placeholder: "Shorthand",
                    initialValue: _image.shorthand,
                    onChanged: (value) =>
                        setState(() => _image.shorthand = value),
                  )),
              const SizedBox(height: 10),
              InfoLabel(
                  label: "GIF Tags",
                  child: TextFormBox(
                    placeholder:
                        "Comma separated list of tags, e.g: amogus, moyai, crab",
                    initialValue: _image.tags.join(", "),
                    onChanged: (value) =>
                        setState(() => _image.tags = value.split(", ")),
                  ))
            ]));
  }

  late store.Image _image;
}
