import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/assets_const.dart';
import '../../themes/colors.dart';
import '../../themes/typographies.dart';
import '../../utils/extensions/theme_extension.dart';
import '../spacing/gap.dart';

class UITextField extends StatefulWidget {
  const UITextField({
    super.key,
    this.textController,
    this.hint,
    this.label,
    this.information,
    this.initialValue,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.suffixIcon,
    this.iconColor,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.validator,
    this.inputFormatters,
    this.fillColor,
    this.borderColor,
    this.radius,
    this.hintColor,
    this.preffixIcon,
  });

  final TextEditingController? textController;
  final String? hint;
  final String? label;
  final String? information;
  final String? initialValue;
  final bool isEnabled;
  final bool isReadOnly;
  final Color? borderColor;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double? radius;
  final bool expands;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final Color? iconColor;
  final Color? fillColor;
  final Color? hintColor;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<UITextField> createState() => _UITextFieldState();
}

class _UITextFieldState extends State<UITextField> {
  String? _error;
  bool _isObscureText = false;

  late TextEditingController _defaultController;

  @override
  void initState() {
    _isObscureText = widget.isPassword;

    if (widget.textController == null) {
      _defaultController = TextEditingController();
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.textController == null) {
      _defaultController.dispose();
    }
    super.dispose();
  }

  bool get _isHasError =>
      widget.validator?.call(
        (widget.textController ?? _defaultController).text,
      ) !=
      null;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ..._label(context),
            TextFormField(
              enabled: widget.isEnabled,
              readOnly: widget.isReadOnly,
              controller: widget.textController ?? _defaultController,
              focusNode: widget.focusNode,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              expands: widget.expands,
              initialValue: widget.initialValue,
              scrollPadding: EdgeInsets.zero,
              textAlignVertical: TextAlignVertical.center,
              style: UITypographies.bodyLarge(context).copyWith(
                color: context.theme.colors.textPrimary,
                inherit: true,
              ),
              cursorColor: context.theme.colors.textPrimary,
              cursorErrorColor: UIColors.red500,
              decoration: InputDecoration(
                hintText: widget.hint,
                errorText: _error,
                prefixIcon: widget.preffixIcon != null
                    ? SizedBox(
                        height: 20.r,
                        width: 20.r,
                        child: Center(
                          child: widget.preffixIcon,
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? context.theme.colors.borderSoft,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? context.theme.colors.borderSoft,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? context.theme.colors.primary,
                  ),
                ),
                filled: true,
                fillColor: widget.fillColor ?? UIColors.grey200.withOpacity(0.24),
                hintStyle: UITypographies.bodyLarge(context).copyWith(
                  inherit: true,
                  color: widget.hintColor ?? UIColors.white50.withOpacity(0.4),
                ),
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _isObscureText = !_isObscureText;
                          });
                        },
                        child: SizedBox(
                          height: 20.r,
                          width: 20.r,
                          child: Center(
                            child: SvgPicture.asset(
                              _isObscureText ? IconsConst.visible : IconsConst.invisible,
                              colorFilter: ColorFilter.mode(
                                context.theme.colors.textPrimary,
                                BlendMode.srcIn,
                              ),
                              height: 20.r,
                              width: 20.r,
                            ),
                          ),
                        ),
                      )
                    : widget.suffixIcon != null
                        ? SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: Center(
                              child: widget.suffixIcon,
                            ),
                          )
                        : null,
              ),
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onFieldSubmitted,
              onEditingComplete: _isHasError ? () {} : widget.onEditingComplete,
              obscureText: _isObscureText,
              keyboardType: widget.keyboardType,
              validator: (value) {
                // Note : https://pub.dev/packages/form_validator (documentations)
                _error = widget.validator?.call(value);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {});
                  }
                });

                return _error;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.maxLength),
                ...?widget.inputFormatters,
              ],
            ),
            if (_error != null || widget.information != null) ..._information(context),
          ],
        );
      },
    );
  }

  List<Widget> _label(BuildContext context) {
    return [
      Text(
        widget.label!,
        style: UITypographies.subtitleMedium(context),
      ),
      UIGap.h4,
    ];
  }

  List<Widget> _information(BuildContext context) {
    return [
      if (_error == null) UIGap.h4,
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_isHasError) ...[
            Icon(
              Icons.info_outline_rounded,
              size: 16.r,
              color: UIColors.red500,
            ),
            UIGap.w4,
          ],
          Text(
            _error ?? widget.information ?? '',
            style: UITypographies.captionMedium(context).copyWith(
              color: _error != null ? UIColors.red500 : context.theme.colors.textSecondary,
            ),
          ),
        ],
      ),
    ];
  }
}
