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
    _fToast
      ..removeCustomToast()
      ..showToast(
        child: _customToast(
          ToastType.info,
          message,
        ),
        isDismissable: dismissible,
      );
  }

  void showSuccess(
    String message, {
    String? title,
    EdgeInsetsGeometry? margin,
    bool dismissible = true,
  }) {
    _fToast
      ..removeCustomToast()
      ..showToast(
        child: _customToast(
          ToastType.success,
          message,
        ),
        isDismissable: dismissible,
      );
  }

  void showError(
    String message, {
    String? title,
    VoidCallback? retry,
    EdgeInsetsGeometry? margin,
    bool dismissible = true,
  }) {
    _fToast
      ..removeCustomToast()
      ..showToast(
        child: _customToast(
          ToastType.error,
          message,
        ),
        isDismissable: dismissible,
      );
  }

  removeToast() {
    _fToast.removeCustomToast();
  }

  removeAllQueuedToasts() {
    _fToast.removeQueuedCustomToasts();
  }

  Widget _customToast(
    ToastType type,
    String message,
  ) {
    late Color backgroundColor;
    late Color textColor;
    late IconData iconData;

    switch (type) {
      case ToastType.info:
        backgroundColor = UIColors.blue500;
        textColor = UIColors.white50;
        iconData = Icons.info;
        break;
      case ToastType.success:
        backgroundColor = UIColors.green950;
        textColor = UIColors.green500;
        iconData = Icons.check;
        break;
      case ToastType.error:
        backgroundColor = UIColors.red950;
        textColor = UIColors.red500;
        iconData = Icons.error;
        break;
    }

    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
        ),
        child: Text(
          message,
          softWrap: true,
          textAlign: TextAlign.center,
          style: UITypographies.bodyMedium(context).copyWith(
            color: textColor,
          ),
        ),
      );
    });
  }
}

final toastHelper = locator<ToastHelper>();
