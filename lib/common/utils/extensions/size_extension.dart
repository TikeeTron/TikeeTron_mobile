import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../../core/injector/locator.dart';

enum DialogType {
  bottomSheetCupertino,
  bottomSheetMaterial,
}

extension ContextParsing on BuildContext? {
  BuildContext? get context {
    if (this != null) {
      return this;
    }

    if (locator<NavigationService>().currentContext != null) {
      return locator<NavigationService>().currentContext;
    }

    return null;
  }

  MediaQueryData? get mediaQueryData {
    if (context == null) {
      return null;
    }

    return MediaQuery.of(context!);
  }

  Size? get size {
    if (mediaQueryData == null) {
      return null;
    }

    return mediaQueryData!.size;
  }

  double? get height {
    if (size == null) {
      return null;
    }

    return size!.height;
  }

  double? get width {
    return size?.width;
  }

  bool? get isFirstRoute {
    bool? result;

    if (this != null) {
      result = ModalRoute.of(this!)?.isFirst;
    }

    return result;
  }

  double? get paddingTop {
    return mediaQueryData?.padding.top;
  }

  double? get paddingBottom {
    return mediaQueryData?.padding.bottom;
  }

  double? get phoneHeightWihtoutSafeArea {
    if (height == null || paddingTop == null || paddingBottom == null) {
      return null;
    }

    return height! - paddingTop! - paddingBottom!;
  }

  void get closeKeyboard {
    if (context == null) {
      return;
    }

    FocusScope.of(context!).unfocus();
  }
}
