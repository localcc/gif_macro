import 'package:flutter/cupertino.dart';

class FocusProvider extends ChangeNotifier {
  FocusProvider() : super();

  void focus() {
    
    notifyListeners();
  }
}
