import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/durations_const.dart';
import '../../themes/colors.dart';

class UIRadio extends StatelessWidget {
  const UIRadio({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        height: 20.r,
        width: 20.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? UIColors.primary500 : UIColors.white700,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            height: value ? 14 : 0,
            width: value ? 14 : 0,
            duration: DurationConst.iosFast,
            decoration: BoxDecoration(
              color: value ? UIColors.primary500 : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
