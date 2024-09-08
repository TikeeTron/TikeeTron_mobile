import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/font_config.dart';

enum FontFamilySource {
  googleFonts,
  assets,
}

class TextUI extends StatelessWidget {
  const TextUI(
    this.text, {
    this.weight = FontWeight.w500,
    this.fontSize,
    this.textAlign,
    this.fontFamily,
    this.color,
    this.overflow,
    this.height,
    this.overwriteStyle,
    this.maxLines,
    this.selectAble = false,
    this.letterSpacing = 0,
    this.fontFamilySource,
    Key? key,
  }) : super(key: key);

  final String text;
  final FontWeight? weight;
  final double? fontSize;
  final TextAlign? textAlign;
  final String? fontFamily;
  final Color? color;
  final TextOverflow? overflow;
  final double? height;
  final TextStyle? overwriteStyle;
  final int? maxLines;
  final bool selectAble;
  final double letterSpacing;
  final FontFamilySource? fontFamilySource;

  @override
  Widget build(BuildContext context) {
    if (selectAble) {
      return SelectableText(
        text,
        style: overwriteStyle ??
            TextStyle(
              fontSize: fontSize ?? 16,
              fontFamily: fontFamily,
              color: color,
              overflow: overflow,
              height: height ?? 1.2,
              fontWeight: weight,
              letterSpacing: letterSpacing,
            ),
        textAlign: textAlign ?? TextAlign.left,
        maxLines: maxLines,
      );
    }

    TextStyle? textStyle = overwriteStyle;

    if (textStyle == null && fontFamilySource == FontFamilySource.assets) {
      textStyle = TextStyle(
        fontSize: fontSize ?? 16,
        color: color,
        height: height ?? 1.2,
        fontWeight: weight,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
      );
    }

    textStyle ??= GoogleFonts.getFont(
      fontFamily ?? FontFamily.dmSans.name,
      fontSize: fontSize ?? 16,
      color: color,
      height: height ?? 1.2,
      fontWeight: weight,
      letterSpacing: letterSpacing,
    );

    return Text(
      text,
      style: textStyle,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
    );
  }
}
