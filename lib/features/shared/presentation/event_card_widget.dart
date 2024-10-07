import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/svg/svg_ui.dart';

class EventCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String? estimatePrice;
  final String desc;
  final bool isTicketUsed;
  final void Function()? onTapDetail;
  final void Function()? onTapMyTicket;
  final double? width;

  const EventCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    this.isTicketUsed = true,
    this.estimatePrice,
    this.onTapDetail,
    this.onTapMyTicket,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTapDetail,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 20.h),
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
                UINetworkImage(
                  url: image,
                  width: double.infinity,
                  height: 140.h,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(10.r),
                ),
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
                !isTicketUsed
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                          12.w,
                          4.h,
                          12.w,
                          12.h,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: UIPrimaryButton(
                            text: 'My Ticket',
                            textStyle: UITypographies.bodyLarge(context),
                            size: UIButtonSize.medium,
                            leftIcon: SvgUI(
                              IconsConst.qrCode,
                              color: UIColors.white50,
                              width: 32.w,
                              height: 32.w,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            onPressed: onTapMyTicket,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(
                          12.w,
                          4.h,
                          12.w,
                          12.h,
                        ),
                        child: Text(
                          'From $estimatePrice TRX',
                          style: UITypographies.subtitleMedium(
                            context,
                            fontSize: 15.sp,
                            color: UIColors.primary200,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
