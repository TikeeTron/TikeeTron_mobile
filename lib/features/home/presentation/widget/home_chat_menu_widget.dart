import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/image/asset_image_ui.dart';

class HomeChatMenuWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  const HomeChatMenuWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: UIColors.primary900,
        ),
        color: UIColors.primary950,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: UIColors.primary900,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: AssetImageUI(
              path: icon,
              width: 36.w,
              height: 36.w,
              boxFit: BoxFit.cover,
            ),
          ),
          UIGap.w12,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: UITypographies.subtitleLarge(context),
              ),
              UIGap.h2,
              Text(
                subtitle,
                style: UITypographies.bodyLarge(
                  context,
                  color: UIColors.grey500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
