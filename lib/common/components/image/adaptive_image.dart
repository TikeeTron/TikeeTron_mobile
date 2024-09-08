import 'package:flutter/material.dart';

import '../../utils/helpers/file_helper.dart';
import 'file_image.dart';
import 'network_image.dart';

class UIAdaptiveImage extends StatelessWidget {
  const UIAdaptiveImage({
    super.key,
    required this.source,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.backgroundColor,
    this.colorFilter,
  });

  final String source;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    if (FileHelper.isFromNetwork(source)) {
      return UINetworkImage(
        url: source,
        height: height,
        width: width,
        fit: fit,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        colorFilter: colorFilter,
      );
    } else {
      return UIFileImage(
        path: source,
        height: height,
        width: width,
        fit: fit,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        colorFilter: colorFilter,
      );
    }
  }
}
