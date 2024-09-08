import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/typographies.dart';
import '../../utils/extensions/theme_extension.dart';

enum UIButtonType {
  primary,
  secondary,
  tertiary;
}

enum UIButtonVariant {
  main,
  iconOnly;
}

enum UIButtonSize {
  small,
  medium,
  large;

  EdgeInsets get padding => switch (this) {
        UIButtonSize.small => EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
        UIButtonSize.medium => EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
        UIButtonSize.large => EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
      };

  Size size({
    required bool isIconOnly,
  }) =>
      switch (this) {
        UIButtonSize.small => Size(
            isIconOnly ? 30.h : double.infinity,
            30.h,
          ),
        UIButtonSize.medium => Size(
            isIconOnly ? 36.h : double.infinity,
            36.h,
          ),
        UIButtonSize.large => Size(
            isIconOnly ? 44.h : double.infinity,
            44.h,
          ),
      };

  Size get iconSize => switch (this) {
        UIButtonSize.small => Size(16.r, 16.r),
        UIButtonSize.medium => Size(20.r, 20.r),
        UIButtonSize.large => Size(20.r, 20.r),
      };

  BorderRadius get radius => switch (this) {
        UIButtonSize.small => BorderRadius.circular(8).r,
        UIButtonSize.medium => BorderRadius.circular(10).r,
        UIButtonSize.large => BorderRadius.circular(12).r,
      };

  TextStyle textStyle(BuildContext context) => switch (this) {
        UIButtonSize.small =>
          UITypographies.buttonSmall(context).withFigmaLineHeight(
            12.sp,
          ),
        UIButtonSize.medium =>
          UITypographies.buttonMedium(context).withFigmaLineHeight(
            14.sp,
          ),
        UIButtonSize.large =>
          UITypographies.buttonLarge(context).withCompactHeight,
      };
}
