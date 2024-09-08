import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/animation_const.dart';
import '../../constants/durations_const.dart';
import '../../themes/themes.dart';

enum UICheckboxSize {
  small,
  medium;

  Size get size => switch (this) {
        UICheckboxSize.small => Size(20.r, 20.r),
        UICheckboxSize.medium => Size(24.r, 24.r),
      };
}

class UICheckbox extends StatelessWidget {
  const UICheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = UICheckboxSize.small,
  });

  final bool value;
  final void Function(bool value) onChanged;
  final UICheckboxSize size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        height: size.size.height,
        width: size.size.width,
        duration: DurationConst.iosDefault,
        curve: AnimationsConst.curveComponent,
        decoration: BoxDecoration(
          color: value ? UIColors.primary500 : Colors.transparent,
          border: value
              ? null
              : Border.all(
                  color: UIColors.white700,
                ),
          borderRadius: BorderRadius.circular(4).r,
        ),
        child: value
            ? Icon(
                Icons.check_rounded,
                color: UIColors.black900,
                size: 18.r,
              )
            : null,
      ),
    );
  }
}
