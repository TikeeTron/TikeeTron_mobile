import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'themes.dart';

abstract class UITheme {
  static final material = _UIThemeMaterial();

  static final cupertino = _UIThemeCupertino();
}

class _UIThemeMaterial {
  final light = () {
    final defaultTheme = ThemeData.light();
    // .copyWith(
    //   textTheme: GoogleFonts.poppinsTextTheme(),
    // );

    return defaultTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(),
      inputDecorationTheme: _inputDecorationTheme(defaultTheme),
      radioTheme: _radioTheme(defaultTheme),
      extensions: [
        _lightColor,
      ],
    );
  }();

  final dark = () {
    final defaultTheme = ThemeData.dark();
    // .copyWith(
    //   textTheme: GoogleFonts.poppinsTextTheme(),
    // );

    return defaultTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(),
      inputDecorationTheme: _inputDecorationTheme(defaultTheme),
      radioTheme: _radioTheme(defaultTheme),
      extensions: [
        _darkColor,
      ],
    );
  }();

  static const _lightColor = UIColorsExtension(
    primary: UIColors.primary500,
    backgroundPrimary: UIColors.white50,
    backgroundSecondary: UIColors.white100,
    backgroundTertiary: UIColors.white200,
    textPrimary: UIColors.white50,
    textOnPrimary: UIColors.white50,
    textSecondary: UIColors.black700,
    textTertiary: UIColors.black500,
    borderBold: UIColors.black400,
    borderSoft: UIColors.black600,
  );

  static const _darkColor = UIColorsExtension(
    primary: UIColors.primary500,
    backgroundPrimary: UIColors.black900,
    backgroundSecondary: UIColors.black800,
    backgroundTertiary: UIColors.black700,
    textPrimary: UIColors.white50,
    textOnPrimary: UIColors.white50,
    textSecondary: UIColors.grey500,
    textTertiary: UIColors.black400,
    borderBold: UIColors.black400,
    borderSoft: UIColors.black600,
  );

  static _inputDecorationTheme(ThemeData theme) => theme.inputDecorationTheme.copyWith(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        errorStyle: const TextStyle(
          height: 0,
          fontSize: 0,
          color: Colors.transparent,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: UIColors.black400,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: UIColors.white50,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: UIColors.red500,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: UIColors.red500,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      );

  static _radioTheme(ThemeData theme) => theme.radioTheme.copyWith(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? UIColors.primary500 : UIColors.white50,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      );
}

class _UIThemeCupertino {
  final light = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: UIColors.primary500,
    barBackgroundColor: UIColors.white50,
    scaffoldBackgroundColor: UIColors.white50,
    textTheme: _textTheme(UIColors.black900),
  );

  final dark = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: UIColors.primary500,
    barBackgroundColor: UIColors.black900,
    scaffoldBackgroundColor: UIColors.black900,
    textTheme: _textTheme(UIColors.white50),
  );

  static CupertinoTextThemeData _textTheme(
    Color primaryColor,
  ) =>
      CupertinoTextThemeData(
        primaryColor: primaryColor,
        textStyle: GoogleFonts.plusJakartaSans(),
        actionTextStyle: GoogleFonts.plusJakartaSans(),
        tabLabelTextStyle: GoogleFonts.plusJakartaSans(),
        navTitleTextStyle: GoogleFonts.plusJakartaSans(),
        navLargeTitleTextStyle: GoogleFonts.plusJakartaSans(),
        navActionTextStyle: GoogleFonts.plusJakartaSans(),
        pickerTextStyle: GoogleFonts.plusJakartaSans(),
        dateTimePickerTextStyle: GoogleFonts.plusJakartaSans(),
      );
}
