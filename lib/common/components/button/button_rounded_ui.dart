import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/padding_config.dart';
import '../text/text_ui.dart';
import '../../utils/extensions/theme_extension.dart';
import '../../utils/object_util.dart';
import '../cliprrect/smooth_cliprrect.dart';
import '../container/smooth_container.dart';
import '../loading/circle_loading_widget.dart';
import '../svg/svg_ui.dart';
import 'bounce_tap.dart';

enum ButtonSize { small, large, defaultSize }

enum ButtonType { defaultButton, icon, outline }

class ButtonRoundedUI extends StatelessWidget {
  const ButtonRoundedUI({
    Key? key,
    required this.onPress,
    this.type,
    this.size,
    this.text,
    this.textColor,
    this.disabled,
    this.isLoading,
    this.useInkWell,
    this.useSplash,
    this.fontSize,
    this.svgPadding,
    this.svgColor,
    this.prefixSvg,
    this.prefixSvgHeight,
    this.prefixSvgWidth,
    this.svgPath,
    this.svgHeight,
    this.svgWidth,
    this.disabledSetColorSvg,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
    this.margin,
    this.border,
    this.padding,
    this.boxShadow,
    this.useBorder,
    this.borderColor,
    this.borderWidth,
    this.cornerSmoothing,
    this.useMediumHaptic = false,
    this.useHeavyHaptic = false,
    this.useLightHaptic = false,
  }) : super(key: key);

  final void Function() onPress;

  final ButtonSize? size;
  final ButtonType? type;
  final String? text;
  final Color? textColor;
  final bool? disabled;
  final bool? isLoading;
  final bool? useInkWell;
  final bool? useSplash;
  final double? fontSize;

  final EdgeInsets? svgPadding;
  final String? prefixSvg;
  final String? svgPath;
  final Color? svgColor;
  final double? prefixSvgWidth;
  final double? prefixSvgHeight;
  final double? svgWidth;
  final double? svgHeight;
  final bool? disabledSetColorSvg;

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  final BorderSide? border;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final SmoothBorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final bool? useBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? cornerSmoothing;
  final bool useMediumHaptic;
  final bool useHeavyHaptic;
  final bool useLightHaptic;

  @override
  Widget build(BuildContext context) {
    return SmoothClipRRect(
      borderRadius: getBorderRadius,
      child: BounceTap(
        onTap: handlePress,
        onLongPress: () {
          HapticFeedback.heavyImpact();
        },
        useInkWell: useInkWell,
        useSplash: useSplash,
        child: SmoothContainer(
          width: getWidth,
          height: getHeight,
          margin: margin,
          padding: getPadding,
          color: getColor(context),
          borderRadius: getBorderRadius,
          useBorder: getUseBorder,
          borderColor: getBorderColor ?? getColor(context),
          boxShadow: boxShadow,
          borderWidth: getBorderWidth,
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: [
              if (prefixSvg != null)
                Padding(
                  padding: text != null ? (svgPadding ?? Paddings.r12) : Paddings.r0,
                  child: SvgUI(
                    prefixSvg,
                    color: svgColor ?? textColor,
                    width: prefixSvgWidth ?? 20,
                    height: prefixSvgHeight ?? 20,
                    disabledSetColor: disabledSetColorSvg,
                  ),
                ),
              if (svgPath != null)
                Padding(
                  padding: svgPadding ?? Paddings.p8,
                  child: SvgUI(
                    svgPath,
                    color: svgColor ?? textColor,
                    width: getSvgWidth,
                    height: getSvgHeight,
                    disabledSetColor: disabledSetColorSvg,
                  ),
                ),
              if (text != null)
                isLoading == true
                    ? Transform.scale(
                        scale: size == ButtonSize.small ? 0.5 : 1,
                        child: const CircleLoadingWidget(
                          boxSize: 17,
                        ),
                      )
                    : Expanded(
                        child: TextUI(
                          text ?? '',
                          fontSize: getFontSize,
                          color: getTextColor(context),
                          weight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }

  handlePress() {
    // Now reversing the animation after the user defined duration
    if (isLoading == true) {
      return;
    }

    if (disabled == true) {
      return;
    }
    if (useLightHaptic) {
      HapticFeedback.lightImpact();
    } else if (useMediumHaptic) {
      HapticFeedback.mediumImpact();
    } else if (useHeavyHaptic) {
      HapticFeedback.heavyImpact();
    }
    onPress();
  }

  Color? getColor(BuildContext context) {
    Color? bgColor = color ?? context.theme.cardColor;

    if (type == ButtonType.icon) {
      bgColor = color ?? Colors.transparent;
    }

    if (type == ButtonType.outline) {
      bgColor = color ?? Colors.transparent;
    }

    return disabled == true ? context.theme.primaryColor : bgColor;
  }

  Color? getTextColor(BuildContext context) {
    Color txColor = textColor ?? Colors.white;

    if (isLoading == true) {
      return context.theme.dividerColor;
    }

    if (type == ButtonType.outline) {
      return textColor ?? borderColor ?? context.theme.dividerColor;
    }

    return disabled == true || isLoading == true ? context.theme.primaryColor.withOpacity(0.4) : txColor;
  }

  EdgeInsets get getPadding {
    EdgeInsets btnPadding = Paddings.p0;

    if (size == ButtonSize.small) {
      btnPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
    }

    if (ObjectUtil.notNullAndEmptyString(text)) {
      btnPadding = Paddings.p16;

      if (size == ButtonSize.small) {
        btnPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16);
      }
    }

    if (type == ButtonType.icon) {
      btnPadding = Paddings.p0;
    }

    return padding ?? btnPadding;
  }

  double? get getWidth {
    double? btnWidth = width;

    if (type == ButtonType.icon) {
      btnWidth = width ?? 36;
    }

    return width ?? btnWidth;
  }

  double? get getHeight {
    double? btnHeight = height;

    if (type == ButtonType.icon) {
      btnHeight = height ?? 36;
    }

    return btnHeight;
  }

  double? get getFontSize {
    double? btnFontSize = fontSize;

    if (size == ButtonSize.small) {
      btnFontSize = 16;
    }
    return btnFontSize ?? 16;
  }

  double? get getSvgWidth {
    double? sWidth = svgWidth;

    if (type == ButtonType.icon) {
      sWidth = 18;

      if (size == ButtonSize.large) {
        sWidth = 28;
      }

      if (size == ButtonSize.small) {
        sWidth = 12;
      }
    }

    return sWidth ?? svgWidth;
  }

  double? get getSvgHeight {
    double? sHeight = svgHeight;

    if (type == ButtonType.icon) {
      sHeight = 18;

      if (size == ButtonSize.large) {
        sHeight = 28;
      }

      if (size == ButtonSize.small) {
        sHeight = 12;
      }
    }

    return svgHeight ?? sHeight;
  }

  SmoothBorderRadius? get getBorderRadius {
    if (borderRadius != null) {
      return borderRadius;
    }

    SmoothBorderRadius? bRadius = SmoothBorderRadius(
      cornerRadius: 9999,
      cornerSmoothing: 0,
    );

    if (size == ButtonSize.small) {
      bRadius = SmoothBorderRadius(cornerRadius: 14, cornerSmoothing: 0.5);
    }

    if (type == ButtonType.icon) {
      bRadius = SmoothBorderRadius(cornerRadius: 9999, cornerSmoothing: 0);
    }

    return bRadius;
  }

  bool? get getUseBorder {
    bool? xUseBorder = useBorder;

    if (type == ButtonType.outline || type == ButtonType.defaultButton) {
      xUseBorder = true;
    }

    return xUseBorder ?? useBorder;
  }

  Color? get getBorderColor {
    Color? xBorderColor = borderColor;

    if (type == ButtonType.outline && borderColor == null) {
      xBorderColor = Colors.black;
    }

    return xBorderColor ?? borderColor;
  }

  double? get getBorderWidth {
    double? xBorderWidth = borderWidth;

    //if (type == ButtonType.outline) {
    xBorderWidth = 3;
    // }

    return xBorderWidth;
  }
}
