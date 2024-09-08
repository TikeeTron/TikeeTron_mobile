import 'package:flutter/material.dart';

import '../../../common/themes/colors_extension.dart';

extension XTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension XThemeData on ThemeData {
  UIColorsExtension get colors => extension<UIColorsExtension>()!;
}

extension XTextStyle on TextStyle {
  TextStyle withFigmaLineHeight(double lineHeight) => copyWith(
        height: lineHeight / (this.fontSize ?? lineHeight),
      );

  TextStyle get withCompactHeight => copyWith(
        height: 1,
      );
}
