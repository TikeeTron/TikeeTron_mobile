import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common.dart';
import 'bounce_tap.dart';

class ButtonTextUI extends StatelessWidget {
  const ButtonTextUI({
    required this.text,
    required this.onTap,
    this.fontSize,
    this.disabled,
    this.isLoading,
    this.fontWeight,
    this.textAlign,
    this.disablePadding = false,
    super.key,
  });

  final String text;
  final FontWeight? fontWeight;
  final bool disablePadding;
  final void Function() onTap;
  final bool? disabled;
  final bool? isLoading;
  final double? fontSize;
  final TextAlign? textAlign;

  void _handlePress() {
    // Now reversing the animation after the user defined duration
    if (isLoading == true) {
      return;
    }

    if (disabled == true) {
      return;
    }

    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: _handlePress,
      onLongPress: () {
        HapticFeedback.mediumImpact();
      },
      useInkWell: true,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: disablePadding ? 0 : 14),
        child: Text(
          text,
          style: UITypographies.bodyLarge(
            context,
            fontSize: fontSize,
            color: UIColors.primary500,
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
