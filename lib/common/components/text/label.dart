import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common.dart';

class UILabel extends StatelessWidget {
  const UILabel({
    super.key,
    required this.text,
    this.color = UIColors.blue500,
  }) : isOutline = false;

  const UILabel.outline({
    super.key,
    required this.text,
    this.color = UIColors.blue500,
  }) : isOutline = true;

  final String text;
  final Color color;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOutline ? null : color.withOpacity(.2),
        border: isOutline
            ? Border.all(
                color: color.withOpacity(.2),
              )
            : null,
        borderRadius: BorderRadius.circular(8).r,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      child: Text(
        text,
        style: UITypographies.labelMedium(context).copyWith(
          color: color,
        ),
      ),
    );
  }
}
