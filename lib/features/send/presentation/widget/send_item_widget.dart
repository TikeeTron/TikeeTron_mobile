import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/components.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/themes/themes.dart';

class SendItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double? iconSize;
  final Function()? onTap;
  const SendItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: UIColors.grey200.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Center(
                    child: SvgUI(
                      icon,
                      width: iconSize?.w,
                      height: iconSize?.w,
                      fit: BoxFit.cover,
                      color: UIColors.white50,
                    ),
                  ),
                ),
                UIGap.w16,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: UITypographies.subtitleLarge(
                            context,
                            fontSize: 17.sp,
                          ),
                        ),
                        UIGap.h2,
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: UITypographies.bodyMedium(
                            context,
                            fontSize: 15.sp,
                            color: UIColors.grey500,
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
            CupertinoIcons.chevron_forward,
            size: 34.w,
            color: UIColors.white50,
          ),
        ],
      ),
    );
  }
}
