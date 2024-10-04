import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/image/asset_image_ui.dart';
import '../../../common/components/svg/svg_ui.dart';

class EventCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String? estimatePrice;
  final String desc;
  final bool haveTicket;
  const EventCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    this.haveTicket = true,
    this.estimatePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285.w,
      margin: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: UIColors.black400,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AssetImageUI(
                path: IllustrationsConst.onBoarding2,
                height: 140.h,
                borderRadius: BorderRadius.circular(18.r),
                boxFit: BoxFit.cover,
              ),
              // UINetworkImage(
              //   url: '',
              //   width: double.infinity,
              //   height: 140.h,
              //   borderRadius: BorderRadius.circular(10.r),
              // ),
              UIGap.h12,
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 2,
                      style: UITypographies.h5(
                        context,
                        color: UIColors.white50,
                      ),
                    ),
                    UIGap.h4,
                    Text(
                      desc,
                      maxLines: 2,
                      style: UITypographies.bodyLarge(
                        context,
                        color: UIColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          haveTicket
              ? Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: <Widget>[
                      UIPrimaryButton(
                        text: 'My Ticket',
                        textStyle: UITypographies.bodyLarge(context),
                        size: UIButtonSize.medium,
                        borderRadius: BorderRadius.circular(40.r),
                        onPressed: () {},
                      ),
                      UIGap.size(w: 10.w),
                      UISecondaryButton(
                        text: 'Get Direction',
                        size: UIButtonSize.medium,
                        onPressed: () {},
                        color: UIColors.black400,
                        textStyle: UITypographies.bodyLarge(context),
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    'From 1,200 TRX',
                    style: UITypographies.subtitleMedium(
                      context,
                      fontSize: 15.sp,
                      color: UIColors.primary200,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
