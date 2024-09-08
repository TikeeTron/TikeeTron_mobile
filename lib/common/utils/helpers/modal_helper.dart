import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../components/components.dart';
import '../../constants/assets_const.dart';
import '../../constants/durations_const.dart';
import '../../themes/themes.dart';
import '../extensions/theme_extension.dart';

class ModalHelper {
  static Future<T?> showModalBottomSheet<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    void Function()? onBackPressed,
    bool isHasCloseButton = false,
    Widget? leading,
    EdgeInsets? padding,
  }) {
    return showMaterialModalBottomSheet(
      context: context,
      bounce: true,
      duration: DurationConst.iosDefault,
      backgroundColor: Colors.transparent,
      barrierColor: UIColors.black400.withOpacity(.32),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: SafeArea(
            bottom: false,
            child: _bottomSheetWrapper(
              context,
              title: title,
              child: child,
              onBackPressed: onBackPressed,
              isHasCloseButton: isHasCloseButton,
              leading: leading,
              padding: padding,
            ),
          ),
        );
      },
    );
  }

  static Future<T?> showCupertinoModalBottomSheet<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    void Function()? onBackPressed,
    bool isHasCloseButton = false,
    Widget? leading,
  }) async {
    return CupertinoScaffold.showCupertinoModalBottomSheet(
      context: context,
      bounce: true,
      duration: DurationConst.iosDefault,
      backgroundColor: Colors.transparent,
      barrierColor: UIColors.black400.withOpacity(.32),
      shadow: const BoxShadow(
        color: UIColors.transparent,
      ),
      builder: (context) {
        return Material(
          color: UIColors.transparent,
          child: _bottomSheetWrapper(
            context,
            title: title,
            child: child,
            onBackPressed: onBackPressed,
            isHasCloseButton: isHasCloseButton,
            leading: leading,
          ),
        );
      },
    );
  }

  static Widget _bottomSheetWrapper(
    BuildContext context, {
    required Widget child,
    String? title,
    void Function()? onBackPressed,
    bool isHasCloseButton = false,
    Widget? leading,
    EdgeInsets? padding,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          ImagesConst.notchBottomSheet,
          fit: BoxFit.fitWidth,
        ),
        Flexible(
          child: Container(
            width: double.infinity,
            color: context.theme.colors.backgroundPrimary,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  _headerBottomSheet(
                    context: context,
                    title: title,
                    onBackPressed: onBackPressed,
                    isHasCloseButton: isHasCloseButton,
                    action: leading,
                  ),
                  UIGap.h20,
                ],
                Flexible(
                  child: Padding(
                    padding: padding ??
                        EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                    child: child,
                  ),
                ),
                UIGap.h20,
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _headerBottomSheet({
    required BuildContext context,
    String? title,
    Widget? action,
    void Function()? onBackPressed,
    bool isHasCloseButton = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              title ?? '',
              style: UITypographies.h6(context),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              if (onBackPressed != null)
                UIFadeButton(
                  onTap: onBackPressed,
                  child: SvgPicture.asset(
                    IconsConst.back,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.textPrimary,
                      BlendMode.srcIn,
                    ),
                    height: 20.r,
                    width: 20.r,
                  ),
                ),
              const Spacer(),
              if (action != null)
                action
              else if (isHasCloseButton)
                UIFadeButton(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    IconsConst.close,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.textPrimary,
                      BlendMode.srcIn,
                    ),
                    height: 20.r,
                    width: 20.r,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
