import 'package:flutter/material.dart';

import '../../utils/extensions/theme_extension.dart';
import 'button_rounded_ui.dart';

class SliverButtonBottomWidget extends StatelessWidget {
  final bool? isLoading;
  final bool? isDisabled;
  final String? title;
  final Function() onTap;
  final double? paddingLeft;
  final double? paddingRight;

  const SliverButtonBottomWidget({
    super.key,
    this.isLoading,
    this.isDisabled,
    this.title,
    required this.onTap,
    this.paddingLeft,
    this.paddingRight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: paddingLeft ?? 24,
            right: paddingRight ?? 24,
            bottom: 5,
            top: 10,
          ),
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            top: false,
            child: ButtonRoundedUI(
              text: title,
              useInkWell: true,
              useHeavyHaptic: true,
              color: context.theme.secondaryHeaderColor,
              isLoading: isLoading,
              disabled: isDisabled,
              onPress: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
