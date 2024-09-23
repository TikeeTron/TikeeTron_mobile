import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common.dart';

class EmptyDataWidget extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  const EmptyDataWidget({super.key, required this.image, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            image,
            width: 60.w,
            height: 60.h,
            color: UIColors.primary500,
          ),
          UIGap.size(h: 20.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: UITypographies.subtitleLarge(
              context,
              fontSize: 20.sp,
            ),
          ),
          UIGap.h4,
          Text(
            desc,
            textAlign: TextAlign.center,
            style: UITypographies.bodyLarge(
              context,
              color: UIColors.grey500,
            ),
          ),
        ],
      ),
    );
  }
}
