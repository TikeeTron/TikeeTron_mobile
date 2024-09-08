import 'package:flutter/material.dart';

import '../../styles/button_style.dart';
import '../indicator/loading_indicator.dart';
import '../spacing/gap.dart';
import 'button_enum.dart';

class UIPrimaryButton extends StatelessWidget {
  const UIPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = UIButtonSize.medium,
    this.leftIcon,
    this.rightIcon,
    this.isLoading = false,
  })  : variant = UIButtonVariant.main,
        icon = null;

  const UIPrimaryButton.icon({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = UIButtonSize.medium,
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
  final bool isLoading;

  bool get isIconOnly => variant == UIButtonVariant.iconOnly;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: UIButtonStyle.primary(context).copyWith(
        fixedSize: WidgetStateProperty.all(
          size.size(isIconOnly: isIconOnly),
        ),
        padding: WidgetStatePropertyAll(
          isIconOnly ? EdgeInsets.zero : size.padding,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: size.radius,
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          size.textStyle(context),
        ),
      ),
      child: isLoading ? const UILoadingIndicator() : _child,
    );
  }

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
