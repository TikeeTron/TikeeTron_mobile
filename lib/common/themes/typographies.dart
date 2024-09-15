import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/extensions/theme_extension.dart';

class UITypographies {
  static TextStyle _getTextStyle(BuildContext context, TextStyle Function(BuildContext) defaultStyle, {double? fontSize, FontWeight? fontWeight, Color? color}) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final cupertinoStyle = const CupertinoThemeData().textTheme;
      return cupertinoStyle.textStyle.copyWith(
        fontSize: fontSize ?? defaultStyle(context).fontSize,
        fontWeight: fontWeight ?? defaultStyle(context).fontWeight,
        color: color ?? context.theme.colors.textPrimary,
      );
    } else {
      return defaultStyle(context).copyWith(color: color);
    }
  }

  static TextStyle h1(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 48.sp,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(56.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle h2(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 40.sp,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(48.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle h3(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 32.sp,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(40.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle h4(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 24.sp,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(32.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle h5(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 20.sp,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(28.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle h6(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(24.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  // ---- Subtitle ---- //

  static TextStyle subtitleLarge(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(24.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle subtitleMedium(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(22.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle subtitleSmall(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(20.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  // ---- Body ---- //

  static TextStyle bodyLarge(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(24.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle bodyMedium(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(22.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle bodySmall(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(20.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  // ---- Label ---- //

  static TextStyle labelMedium(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(16.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle labelSmall(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 11.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(16.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  // ---- Caption ---- //

  static TextStyle captionMedium(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(16.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle captionSmall(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 11.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(16.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  // ---- Button ---- //

  static TextStyle buttonLarge(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(24.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle buttonMedium(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(22.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle buttonSmall(BuildContext context, {double? fontSize, FontWeight? fontWeight, Color? color}) => _getTextStyle(
        context,
        (context) => GoogleFonts.inter(
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? context.theme.colors.textPrimary,
        ).withFigmaLineHeight(20.sp),
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
}
