import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/components/components.dart';
import '../../../../../common/themes/colors.dart';
import '../../../../../common/themes/typographies.dart';
import '../../../../../common/utils/extensions/theme_extension.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({
    super.key,
    required this.onTap,
    required this.logo,
    required this.name,
    this.isOwnership = false,
    this.isSelected = false,
    this.isLastChildGroup,
  });

  final void Function() onTap;
  final String logo;
  final String name;
  final bool isOwnership;
  final bool isSelected;
  final bool? isLastChildGroup;

  @override
  Widget build(BuildContext context) {
    return UIScaleButton(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colors.backgroundTertiary,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(isLastChildGroup != null ? 0 : 16.r),
            bottom: Radius.circular(
              (isLastChildGroup != false) ? 16.r : 0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            UITextImage(
              text: logo,
            ),
            UIGap.w8,
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: UITypographies.subtitleMedium(context),
                    ),
                  ),
                  if (isOwnership) ...[
                    UIGap.w8,
                    const UILabel.outline(
                      text: 'Owner',
                      color: UIColors.blue600,
                    ),
                  ],
                ],
              ),
            ),
            UIGap.w8,
            UIRadio(
              value: isSelected,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
