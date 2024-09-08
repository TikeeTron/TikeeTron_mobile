import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import '../../utils/extensions/theme_extension.dart';

class SmoothContainer extends StatelessWidget {
  const SmoothContainer({
    Key? key,
    this.color,
    this.height,
    this.width,
    this.radius,
    this.borderRadius,
    this.margin,
    this.border,
    this.padding,
    this.boxShadow,
    this.useBorder,
    this.borderColor,
    this.borderWidth,
    this.image,
    this.cornerSmoothing,
    this.child,
  }) : super(key: key);

  final double? radius;
  final BorderSide? border;
  final Color? color;
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final SmoothBorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final bool? useBorder;
  final Color? borderColor;
  final double? borderWidth;
  final DecorationImage? image;
  final double? cornerSmoothing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: ShapeDecoration(
        color: color ?? Colors.white,
        shape: SmoothRectangleBorder(
          side: getBorderSide(context),
          borderRadius: borderRadius ??
              SmoothBorderRadius(
                cornerRadius: radius ?? 20,
                cornerSmoothing: cornerSmoothing ?? 0.5,
              ),
        ),
        shadows: boxShadow,
        image: image,
      ),
      child: child,
    );
  }

  BorderSide getBorderSide(BuildContext context) {
    if (useBorder == false) {
      return BorderSide.none;
    }

    if (useBorder == true) {
      if (border != null) {
        return border!;
      }

      return BorderSide(
        color: borderColor ?? context.theme.colors.borderSoft,
        width: borderWidth ?? 0.5,
      );
    }

    return BorderSide(
      color: Colors.transparent,
      width: borderWidth ?? 0.5,
    );
  }
}
