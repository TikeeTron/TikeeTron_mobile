import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/svg/svg_ui.dart';

class MenuButton extends StatelessWidget {
  final String icon;
  final String title;
  final void Function()? onTap;
  const MenuButton({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: UIColors.primary500,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgUI(
              icon,
              width: 22.w,
              height: 22.w,
              color: UIColors.white50,
            ),
            UIGap.w8,
            Text(
              title,
              style: UITypographies.bodyLarge(
                context,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
