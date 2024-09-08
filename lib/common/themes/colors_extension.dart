import 'package:flutter/material.dart';

class UIColorsExtension extends ThemeExtension<UIColorsExtension> {
  const UIColorsExtension({
    required this.primary,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.textPrimary,
    required this.textOnPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.borderBold,
    required this.borderSoft,
  });

  final Color primary;

  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;

  final Color textPrimary;
  final Color textOnPrimary;
  final Color textSecondary;
  final Color textTertiary;

  final Color borderBold;
  final Color borderSoft;

  @override
  ThemeExtension<UIColorsExtension> copyWith({
    Color? primary,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? textPrimary,
    Color? textOnPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? borderBold,
    Color? borderSoft,
  }) {
    return UIColorsExtension(
      primary: primary ?? this.primary,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      textPrimary: textPrimary ?? this.textPrimary,
      textOnPrimary: textOnPrimary ?? this.textOnPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      borderBold: borderBold ?? this.borderBold,
      borderSoft: borderSoft ?? this.borderSoft,
    );
  }

  @override
  ThemeExtension<UIColorsExtension> lerp(
    covariant ThemeExtension<UIColorsExtension>? other,
    double t,
  ) {
    if (other == null || other is! UIColorsExtension) {
      return this;
    }

    return UIColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      backgroundPrimary:
          Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundSecondary:
          Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundTertiary:
          Color.lerp(backgroundTertiary, other.backgroundTertiary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textOnPrimary: Color.lerp(textOnPrimary, other.textOnPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      borderBold: Color.lerp(borderBold, other.borderBold, t)!,
      borderSoft: Color.lerp(borderSoft, other.borderSoft, t)!,
    );
  }
}
