import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../themes/typographies.dart';
import '../../utils/extensions/theme_extension.dart';

class UICupertinoTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? suffix;
  final Color? fillColor;
  final Color? borderColor;

  const UICupertinoTextField({
    Key? key,
    this.controller,
    this.placeholder,
    this.label,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.obscureText = false,
    this.suffix,
    this.fillColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label!,
              style: UITypographies.bodyMedium(context).copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
        CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
          enabled: enabled,
          readOnly: readOnly,
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onTap: onTap,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          suffix: suffix,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.left,
          style: UITypographies.bodyLarge(context).copyWith(
            color: context.theme.colors.textPrimary,
          ),
          placeholderStyle: UITypographies.bodyLarge(context),
          decoration: BoxDecoration(
            color: fillColor ?? context.theme.colors.backgroundSecondary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor ?? context.theme.colors.borderSoft,
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ],
    );
  }
}
