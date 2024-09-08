import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/colors.dart';
import '../../themes/typographies.dart';
import '../../utils/extensions/theme_extension.dart';

enum UITextImageSize {
  small,
  medium,
  semiLarge,
  large;

  Size get size => switch (this) {
        UITextImageSize.small => Size(16.r, 16.r),
        UITextImageSize.medium => Size(32.r, 32.r),
        UITextImageSize.semiLarge => Size(40.r, 40.r),
        UITextImageSize.large => Size(80.r, 80.r),
      };

  BorderRadius get borderRadius => BorderRadius.circular(100.r);

  TextStyle textStyle(BuildContext context) => switch (this) {
        UITextImageSize.small => GoogleFonts.plusJakartaSans(
            fontSize: 7.sp,
            fontWeight: FontWeight.w600,
            color: context.theme.colors.textPrimary,
          ).withFigmaLineHeight(9.sp),
        UITextImageSize.medium => UITypographies.subtitleSmall(context),
        UITextImageSize.semiLarge => UITypographies.subtitleSmall(context),
        UITextImageSize.large => UITypographies.h3(context),
      };
}

class UITextImage extends StatelessWidget {
  const UITextImage({
    super.key,
    required this.text,
    this.size = UITextImageSize.medium,
    this.backgroundColor = UIColors.orange500,
  });

  final String text;
  final UITextImageSize size;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.size.height,
      width: size.size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: size.borderRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: size.textStyle(context),
      ),
    );
  }
}
