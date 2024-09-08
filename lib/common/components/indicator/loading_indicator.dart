import 'package:flutter/cupertino.dart';

import '../../utils/extensions/theme_extension.dart';

class UILoadingIndicator extends StatelessWidget {
  const UILoadingIndicator({
    super.key,
    this.color,
    this.radius = 10,
  });

  final Color? color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: context.theme.colors.textOnPrimary,
      radius: radius,
    );
  }
}
