import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../utils/extensions/theme_extension.dart';

class UIButtonStyle {
  static ButtonStyle primary(BuildContext context) => ElevatedButton.styleFrom(
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: UIColors.primary500,
        overlayColor: UIColors.primary400,
        splashFactory: InkSplash.splashFactory,
      ).copyWith(
        textStyle: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return TextStyle(
                color: UIColors.grey200.withOpacity(0.3),
                fontWeight: FontWeight.bold,
              );
            }
            return null;
          },
        ),
        foregroundColor: WidgetStatePropertyAll(
          context.theme.colors.textOnPrimary,
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return UIColors.black300;
            }
            if (states.contains(WidgetState.pressed)) {
              return UIColors.primary600;
            }

            return UIColors.primary500;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return UIColors.primary300.withOpacity(.5);
            }
            return null;
          },
        ),
      );

  static ButtonStyle secondary(BuildContext context) => OutlinedButton.styleFrom(
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          color: context.theme.colors.borderBold,
        ),
        overlayColor: UIColors.primary900,
        splashFactory: InkSplash.splashFactory,
      ).copyWith(
        textStyle: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return TextStyle(
                color: UIColors.grey200.withOpacity(0.3),
                fontWeight: FontWeight.bold,
              );
            }
            return null;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return context.theme.colors.textSecondary;
            }
            return context.theme.colors.textPrimary;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return UIColors.white100;
            }
            return null;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return UIColors.primary800.withOpacity(.9);
            }
            return null;
          },
        ),
      );

  static ButtonStyle tertiary(BuildContext context) => TextButton.styleFrom(
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: UIColors.primary900,
        splashFactory: InkSplash.splashFactory,
      ).copyWith(
        textStyle: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return TextStyle(
                color: UIColors.grey200.withOpacity(0.3),
                fontWeight: FontWeight.bold,
              );
            }
            return null;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return context.theme.colors.textSecondary;
            }
            return context.theme.colors.textPrimary;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return UIColors.white100;
            }
            return null;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return UIColors.primary800.withOpacity(.9);
            }
            return null;
          },
        ),
      );
}
