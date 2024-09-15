import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/spacing/gap.dart';
import '../../../common/components/svg/svg_ui.dart';
import '../../../common/themes/colors.dart';
import '../../../common/themes/typographies.dart';

class AuthTypeWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  const AuthTypeWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgUI(
                  icon,
                  width: 36.w,
                  height: 36.w,
                  color: UIColors.white50,
                ),
                UIGap.w16,
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: UITypographies.h6(
                            context,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        UIGap.size(h: 6.h),
                        Text(
                          subtitle,
                          style: UITypographies.bodyMedium(
                            context,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            size: 24.w,
            color: UIColors.white50,
          ),
        ],
      ),
    );
  }
}
