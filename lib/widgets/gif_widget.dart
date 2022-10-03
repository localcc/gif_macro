import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gif_macro/widgets/square_widget.dart';

import 'image_progress_indicator.dart';

class GifWidget extends StatelessWidget {
  const GifWidget({required this.url, this.imageFit = BoxFit.fill, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (context, url, progress) =>
              ProgressIndicatorWidget(progress: progress.progress),
          errorWidget: (context, url, error) =>
              const SquareWidget(child: Icon(FluentIcons.error, size: 35)),
          imageBuilder: (context, imageProvider) =>
              Image(image: imageProvider, fit: imageFit),
        ));
  }

  final String url;
  final BoxFit? imageFit;
}
