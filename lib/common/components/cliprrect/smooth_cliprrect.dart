import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class SmoothClipRRect extends StatelessWidget {
  const SmoothClipRRect({
    Key? key,
    this.borderRadius,
    this.radius,
    this.child,
  }) : super(key: key);

  final SmoothBorderRadius? borderRadius;
  final double? radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ??
          SmoothBorderRadius(
            cornerRadius: radius ?? 20,
            cornerSmoothing: 0.5,
          ),
      child: child,
    );
  }
}
