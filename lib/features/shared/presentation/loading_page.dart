import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';

class LoadingPage extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final int opacity;
  const LoadingPage({super.key, this.title, this.subtitle, required this.opacity});

  @override
  Widget build(BuildContext context) {
    if (opacity == 0) {
      return const SizedBox.shrink();
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: UIColors.black500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 65.w,
            height: 65.h,
            child: const CupertinoActivityIndicator(
              color: UIColors.white50,
            ),
          ),
          UIGap.h24,
          Text(
            title ?? '',
            style: UITypographies.subtitleLarge(
              context,
              fontSize: 20.sp,
            ),
          ),
          UIGap.h4,
          Text(
            subtitle ?? '',
            style: UITypographies.subtitleLarge(
              context,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
