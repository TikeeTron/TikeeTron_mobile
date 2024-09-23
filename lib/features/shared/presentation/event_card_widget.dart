import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
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
    return SizedBox(
      width: 285.w,
      height: 300.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UINetworkImage(
                    url: '',
                    width: double.infinity,
                    height: 140.h,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  UIGap.h16,
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
          ),
          haveTicket
              ? Row(
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
                )
              : UIPrimaryButton(
                  text: estimatePrice ?? 'from 1,200 TRX',
                  size: UIButtonSize.medium,
                  borderRadius: BorderRadius.circular(40.r),
                  leftIcon: SvgUI(
                    SvgConst.wallet,
                    color: UIColors.white50,
                    size: 25.sp,
                  ),
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}
