import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../../../core/injector/locator.dart';
import '../../themes/themes.dart';

enum ToastType {
  info,
  success,
  error,
}

@lazySingleton
class ToastHelper {
  late FToast _fToast;

  ToastHelper() {
    _fToast = FToast()
      ..init(
        navigationService.currentContext!,
      );
  }

  void showInformation(
    String message, {
    String? title,
    EdgeInsetsGeometry? margin,
    bool dismissible = true,
  }) {
    Fluttertoast.showToast(
      msg: message,
      textColor: UIColors.white50,
      backgroundColor: UIColors.blue500,
    );
    // _fToast
    //   ..removeCustomToast()
    //   ..showToast(
    //     child: _customToast(
    //       ToastType.info,
    //       message,
    //     ),
    //     isDismissable: dismissible,
    //   );
  }

  void showSuccess(
    String message, {
    String? title,
    EdgeInsetsGeometry? margin,
    bool dismissible = true,
  }) {
    Fluttertoast.showToast(
      msg: message,
      textColor: UIColors.white50,
      backgroundColor: UIColors.green500,
    );

    // _fToast
    //   ..removeCustomToast()
    //   ..showToast(
    //     child: _customToast(
    //       ToastType.success,
    //       message,
    //     ),
    //     isDismissable: dismissible,
    //   );
  }

  void showError(
    String message, {
    String? title,
    VoidCallback? retry,
    EdgeInsetsGeometry? margin,
    bool dismissible = true,
  }) {
    Fluttertoast.showToast(
      msg: message,
      textColor: UIColors.red500,
      backgroundColor: UIColors.red950,
    );
    // _fToast
    //   ..removeCustomToast()
    //   ..showToast(
    //     child: _customToast(
    //       ToastType.error,
    //       message,
    //     ),
    //     isDismissable: dismissible,
    //   );
  }

  removeToast() {
    _fToast.removeCustomToast();
  }

  removeAllQueuedToasts() {
    _fToast.removeQueuedCustomToasts();
  }
}

final toastHelper = locator<ToastHelper>();
