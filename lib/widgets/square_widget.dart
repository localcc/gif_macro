import 'package:flutter/cupertino.dart';

class SquareWidget extends StatelessWidget {
  const SquareWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
                height: 20,
                width: 20,
                child: FittedBox(fit: BoxFit.scaleDown, child: child))));
  }

  final Widget child;
}
