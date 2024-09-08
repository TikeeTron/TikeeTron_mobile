import 'package:flutter/widgets.dart';

class FocusHelper {
  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
