import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/assets_const.dart';
import '../../themes/colors.dart';

class UIFileImage extends StatelessWidget {
  const UIFileImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.backgroundColor,
    this.colorFilter,
  });

  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          color: UIColors.black300,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: (height ?? 64.r) * .5,
            maxWidth: (width ?? 64.r) * .5,
          ),
          child: Image.asset(
            ImagesConst.placeholderPhoto,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      if (colorFilter != null) {
        return ColorFiltered(
          colorFilter: colorFilter!,
          child: _image(),
        );
      } else {
        return _image();
      }
    }
  }

  Widget _image() {
    if (borderRadius == null) return _child();

    return ClipRRect(
      borderRadius: borderRadius!,
      child: _child(),
    );
  }

  Widget _child() {
    return Image.file(
      File(path),
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => Container(
        padding: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          color: UIColors.black300,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: (height ?? 64) * .6,
            maxWidth: (width ?? 64) * .6,
          ),
          child: Image.asset(
            ImagesConst.placeholderPhoto,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
