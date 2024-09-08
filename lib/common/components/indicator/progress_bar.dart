import 'package:flutter/material.dart';

import '../../constants/animation_const.dart';
import '../../themes/colors.dart';
import '../../utils/extensions/theme_extension.dart';

class UIProgressBar extends StatelessWidget {
  const UIProgressBar({
    super.key,
    required this.value,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 1,
            color: context.theme.colors.borderBold,
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: AnimationsConst.curveComponent,
          decoration: BoxDecoration(
            color: UIColors.primary500,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 2,
          width: MediaQuery.of(context).size.width * value,
        ),
      ],
    );
  }
}
