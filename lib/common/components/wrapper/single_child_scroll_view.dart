import 'package:flutter/material.dart';

import '../../utils/helpers/focus_helper.dart';

class UISingleChildScrollView extends StatelessWidget {
  const UISingleChildScrollView({
    super.key,
    required this.children,
    this.padding,
    this.onTap,
    this.disableGestureDetector = false,
    this.physics = const BouncingScrollPhysics(),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.bodyWrapper,
  });

  final List<Widget> children;
  final Widget Function(Widget child)? bodyWrapper;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final Function? onTap;
  final bool disableGestureDetector;
  final ScrollPhysics physics;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disableGestureDetector
          ? null
          : () {
              FocusHelper.unfocus();
              onTap?.call();
            },
      child: SingleChildScrollView(
        controller: controller,
        padding: padding,
        physics: physics,
        scrollDirection: scrollDirection,
        child: bodyWrapper != null ? bodyWrapper!(child()) : child(),
      ),
    );
  }

  Widget child() {
    if (scrollDirection == Axis.vertical) {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    } else {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    }
  }
}
