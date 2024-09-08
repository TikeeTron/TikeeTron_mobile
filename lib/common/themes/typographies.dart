import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/extensions/theme_extension.dart';

class UITypographies {
  // ---- Display ---- //

  // static TextStyle displayLarge(BuildContext context) =>
  //     GoogleFonts.plusJakartaSans(
  //       fontSize: 80.sp,
  //       fontWeight: FontWeight.w700,
  //       height: 1.4,
  //       color: context.theme.colors.textPrimary,
  //     );

  // static TextStyle displayMedium(BuildContext context) =>
  //     GoogleFonts.plusJakartaSans(
  //       fontSize: 64.sp,
  //       fontWeight: FontWeight.w700,
  //       height: 1.4062,
  //       color: context.theme.colors.textPrimary,
  //     );

  // static TextStyle displaySmall(BuildContext context) =>
  //     GoogleFonts.plusJakartaSans(
  //       fontSize: 56.sp,
  //       fontWeight: FontWeight.w700,
  //       height: 1.3928,
  //       color: context.theme.colors.textPrimary,
  //     );

  // ---- Heading ---- //

  static TextStyle h1(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: 48.sp,
        fontWeight: FontWeight.w700,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(56.sp);

  static TextStyle h2(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(48.sp);

  static TextStyle h3(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(40.sp);

  static TextStyle h4(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(32.sp);

  static TextStyle h5(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(28.sp);

  static TextStyle h6(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(24.sp);

  // ---- Subtitle ---- //

  static TextStyle subtitleLarge(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(24.sp);

  static TextStyle subtitleMedium(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(22.sp);

  static TextStyle subtitleSmall(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(20.sp);

  // ---- Body ---- //

  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: context.theme.colors.textSecondary,
      ).withFigmaLineHeight(24.sp);

  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: context.theme.colors.textSecondary,
      ).withFigmaLineHeight(22.sp);

  static TextStyle bodySmall(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: context.theme.colors.textSecondary,
      ).withFigmaLineHeight(20.sp);

  // ---- Label ---- //

  static TextStyle labelMedium(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(16.sp);

  static TextStyle labelSmall(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(16.sp);

  // ---- Caption ---- //

  static TextStyle captionMedium(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(16.sp);

  static TextStyle captionSmall(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(16.sp);

  // ---- Button ---- //

  static TextStyle buttonLarge(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(24.sp);

  static TextStyle buttonMedium(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(22.sp);

  static TextStyle buttonSmall(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: context.theme.colors.textPrimary,
      ).withFigmaLineHeight(20.sp);
}
