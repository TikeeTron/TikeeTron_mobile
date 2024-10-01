import 'package:flutter/cupertino.dart';

class AssetImageUI extends StatelessWidget {
  const AssetImageUI({
    Key? key,
    required this.path,
    this.width,
    this.height,
    this.boxFit,
    this.borderRadius,
    this.borderColor,
    this.shape,
    this.backgroundColor,
  }) : super(key: key);

  final String path;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final BoxShape? shape;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        shape: shape ?? BoxShape.rectangle,
        color: backgroundColor,
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
              )
            : null,
        image: DecorationImage(
          image: AssetImage(path),
          fit: boxFit ?? BoxFit.cover,
        ),
      ),
    );
  }

  BorderRadius? get _borderRadius {
    if (borderRadius != null) {
      return borderRadius;
    }

    if (shape == BoxShape.circle) {
      return null;
    }

    return null;
  }
}
