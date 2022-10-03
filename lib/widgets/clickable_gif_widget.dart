import 'package:fluent_ui/fluent_ui.dart';
import 'package:gif_macro/widgets/gif_widget.dart';
import '../store/image_store.dart' as store;

class ClickableGifWidget extends StatefulWidget {
  const ClickableGifWidget(
      {Key? key,
      required this.image,
      required this.accentColor,
      this.onClick,
      this.onRightClick})
      : super(key: key);

  @override
  State<ClickableGifWidget> createState() => _ClickableGifWidgetState();

  final store.Image image;
  final Color accentColor;
  final void Function(store.Image)? onClick;
  final void Function(store.Image)? onRightClick;
}

class _ClickableGifWidgetState extends State<ClickableGifWidget> {
  @override
  Widget build(BuildContext context) {
    final color =
        hovered ? widget.accentColor : const Color.fromARGB(0, 0, 0, 0);
    final radius =
        hovered ? BorderRadius.circular(16.0) : BorderRadius.circular(0);
    return MouseRegion(
        onEnter: (event) => {setState(() => hovered = true)},
        onExit: (event) => {setState(() => hovered = false)},
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
                color: const Color.fromARGB(0, 0, 0, 0),
                border: Border.all(color: color, width: 2.0),
                borderRadius: radius),
            child: GestureDetector(
                onSecondaryTap: () => widget.onRightClick?.call(widget.image),
                child: TextButton(
                    onPressed: () => widget.onClick?.call(widget.image),
                    child: GifWidget(
                      url: widget.image.url,
                    )))));
  }

  bool hovered = false;
}
