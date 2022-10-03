import 'package:fluent_ui/fluent_ui.dart';
import 'package:gif_macro/widgets/square_widget.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({this.progress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SquareWidget(
        child:
            ProgressRing(value: progress != null ? progress! * 100 : progress));
  }

  final double? progress;
}
