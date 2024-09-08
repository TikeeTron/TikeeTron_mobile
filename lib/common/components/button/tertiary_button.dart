import 'package:flutter/material.dart';

import '../../styles/button_style.dart';
import '../../themes/colors.dart';
import '../indicator/loading_indicator.dart';
import '../spacing/gap.dart';
import 'button_enum.dart';

class UITertiaryButton extends StatelessWidget {
  const UITertiaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = UIButtonSize.medium,
    this.leftIcon,
    this.rightIcon,
    this.color,
    this.isLoading = false,
  })  : variant = UIButtonVariant.main,
        icon = null;

  const UITertiaryButton.icon({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = UIButtonSize.medium,
    this.color,
    this.isLoading = false,
  })  : variant = UIButtonVariant.iconOnly,
        text = null,
        leftIcon = null,
        rightIcon = null;

  final UIButtonVariant variant;
  final UIButtonSize size;
  final void Function()? onPressed;
  final String? text;
  final Widget? icon;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Color? color;
  final bool isLoading;

  bool get isIconOnly => variant == UIButtonVariant.iconOnly;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: UIButtonStyle.tertiary(context).copyWith(
        fixedSize: WidgetStateProperty.all(
          size.size(isIconOnly: variant == UIButtonVariant.iconOnly),
        ),
        padding: WidgetStatePropertyAll(
          variant == UIButtonVariant.iconOnly ? EdgeInsets.zero : size.padding,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: size.radius,
          ),
        ),
        textStyle: WidgetStatePropertyAll(size.textStyle(context)),
        foregroundColor: color != null ? WidgetStatePropertyAll(color!) : null,
      ),
      child: isLoading ? _loadingWidget : _child,
    );
  }

  final _loadingWidget = const UILoadingIndicator(
    color: UIColors.primary500,
    radius: 7,
  );

  Widget get _child {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: isIconOnly ? _iconChildren : _children,
    );
  }

  List<Widget> get _iconChildren {
    return [
      SizedBox(
        width: size.iconSize.width,
        height: size.iconSize.height,
        child: Center(child: icon),
      ),
    ];
  }

  List<Widget> get _children {
    final bool isSmall = size == UIButtonSize.small;

    return [
      if (leftIcon != null) ...[
        SizedBox(
          width: size.iconSize.width,
          height: size.iconSize.height,
          child: Center(child: leftIcon),
        ),
        isSmall ? UIGap.w4 : UIGap.w8,
      ],
      if (text != null)
        Flexible(
          child: Text(
            text!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      if (rightIcon != null) ...[
        isSmall ? UIGap.w4 : UIGap.w8,
        SizedBox(
          width: size.iconSize.width,
          height: size.iconSize.height,
          child: Center(child: rightIcon),
        ),
      ],
    ];
  }
}
