import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../features/shared/presentation/cubit/loading/fullscreen_loading_cubit.dart';

extension ContextParsing on BuildContext? {
  BuildContext? get context {
    if (this != null) {
      return this;
    }

    if (navigationService.currentContext != null) {
      return navigationService.currentContext;
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

  void showFullScreenLoadingWithMessage(String title, String subtitle) {
    if (context == null) {
      return;
    }

    final currentState = BlocProvider.of<FullScreenLoadingCubit>(context!).state;

    if (currentState is ShowFullScreenLoading) {
      return;
    }

    BlocProvider.of<FullScreenLoadingCubit>(context!).showFullScreenLoading(title: title, subtitle: subtitle);
  }

  void get hideFullScreenLoading {
    if (context == null) {
      return;
    }

    if (BlocProvider.of<FullScreenLoadingCubit>(context!).state is HideFullScreenLoading) {
      return;
    }

    BlocProvider.of<FullScreenLoadingCubit>(context!).hideFullScreenLoading();
  }
}
