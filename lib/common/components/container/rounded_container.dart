import 'package:flutter/material.dart';
import '../../utils/extensions/theme_extension.dart';

class RoundedContainer extends StatefulWidget {
  const RoundedContainer({
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
    this.child,
    this.constraints,
    this.strokeAlign,
    this.gradient,
    this.shape,
  }) : super(key: key);

  final double? radius;
  final Border? border;
  final Color? color;
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final bool? useBorder;
  final Color? borderColor;
  final double? borderWidth;
  final DecorationImage? image;
  final BoxConstraints? constraints;
  final BorderSide? strokeAlign;
  final Gradient? gradient;
  final BoxShape? shape;

  @override
  State<RoundedContainer> createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: widget.constraints,
      padding: widget.padding,
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: widget.color,
        border: widget.useBorder == true ? borderSide : null,
        boxShadow: widget.boxShadow,
        image: widget.image,
        gradient: widget.gradient,
        shape: widget.shape ?? BoxShape.rectangle,
      ),
      child: widget.child,
    );
  }

  BorderRadius? get borderRadius {
    if (widget.borderRadius != null) {
      return widget.borderRadius;
    }

    if (widget.radius != null) {
      return BorderRadius.circular(widget.radius!);
    }

    if (widget.shape == BoxShape.circle) {
      return null;
    }

    return BorderRadius.circular(19);
  }

  Border get borderSide {
    if (widget.border != null) {
      return widget.border!;
    }

    return Border.all(
      color: widget.borderColor ?? context.theme.dividerColor,
      width: widget.borderWidth ?? 1,
    );
  }
}
