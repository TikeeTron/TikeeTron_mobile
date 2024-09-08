import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizeTextWidget extends StatelessWidget {
  const AutoSizeTextWidget(
    this.text, {
    this.weight,
    this.fontSize,
    this.textAlign,
    this.fontFamily,
    this.color,
    this.overflow,
    this.height,
    this.overwriteStyle,
    this.maxLines,
    this.selectAble = false,
    this.letterSpacing = -0.4,
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

  @override
  Widget build(BuildContext context) {
    if (selectAble) {
      return SelectableText(
        text,
        style: overwriteStyle ??
            TextStyle(
              fontSize: fontSize,
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
    return AutoSizeText(
      text,
      style: overwriteStyle ??
          TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: color,
            overflow: overflow,
            height: height ?? 1.2,
            fontWeight: weight,
            letterSpacing: letterSpacing,
          ),
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
    );
  }
}
