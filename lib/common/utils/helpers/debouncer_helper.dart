import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class Debouncer {
  Timer? _timer;

  // Direct property for milliseconds

  void run(int milliseconds, VoidCallback action) {
    _timer?.cancel();

    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }

  void close() {
    _timer?.cancel();
  }
}
