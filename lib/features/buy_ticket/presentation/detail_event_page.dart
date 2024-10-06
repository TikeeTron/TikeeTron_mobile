import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/image/asset_image_ui.dart';
import '../../../common/components/svg/svg_ui.dart';
import '../../../common/config/padding_config.dart';
import '../../../core/routes/app_route.dart';

@RoutePage()
class DetailEventPage extends StatefulWidget {
  const DetailEventPage({super.key});

  @override
  State<DetailEventPage> createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                AssetImageUI(
                  path: IllustrationsConst.onBoarding2,
                  width: MediaQuery.of(context).size.width,
                  height: 225.h,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          UIColors.black500.withOpacity(0.8),
                          UIColors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16.w,
                  top: kToolbarHeight,
                  child: BounceTap(
                    onTap: () {
                      context.maybePop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: UIColors.black500,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: UIColors.white50,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UIGap.h20,
            Padding(
              padding: Paddings.defaultPaddingH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ed Sheeran Live at Madison Square Garden',
                                style: UITypographies.h4(context),
                              ),
                              UIGap.h4,
                              Text(
                                'Madison Square Garden, New York 24 Sep 2024 - 26 Sep 2024',
                                style: UITypographies.bodyLarge(
                                  context,
                                  fontSize: 17.sp,
                                  color: UIColors.grey500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      UIGap.w12,
                      BounceTap(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: UIColors.grey200.withOpacity(0.24),
                          ),
                          child: SvgUI(
                            SvgConst.icSend,
                            width: 20.w,
                            height: 20.w,
                            color: UIColors.white50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIGap.h16,
                  UIDivider(
                    color: UIColors.white50.withOpacity(0.15),
                  ),
                  UIGap.h16,

                  Text(
                    "Event Description",
                    style: UITypographies.bodyLarge(
                      context,
                      fontSize: 17.sp,
                      color: UIColors.grey500,
                    ),
                  ),
                  UIGap.h8,
                  Text(
                    "Enjoy an unforgettable night with Ed Sheeran as he performs live at Madison Square Garden! Experience a mix of new songs and old favorites in an energetic concert filled with music, lights, and great vibes.",
                    style: UITypographies.bodyLarge(
                      context,
                      fontSize: 17.sp,
                    ),
                  ),
                  UIGap.h20,

                  // Terms & Conditions Section
                  Text(
                    "Terms & Conditions",
                    style: UITypographies.bodyLarge(
                      context,
                      fontSize: 17.sp,
                      color: UIColors.grey500,
                    ),
                  ),
                  UIGap.h8,
                  _buildBulletPoint("Admission Rules: This ticket is valid for one person only."),
                  _buildBulletPoint(
                      "Refund Policy: No refunds will be provided once the ticket has been purchased, except under extraordinary circumstances at the discretion of the organizer."),
                  _buildBulletPoint("Identification Required: Please bring a valid photo ID for verification at the entrance."),
                  UIGap.h20,

                  // FAQ Section
                  Text(
                    "Frequently Asked Questions (FAQ)",
                    style: UITypographies.bodyLarge(
                      context,
                      fontSize: 17.sp,
                      color: UIColors.grey500,
                    ),
                  ),
                  UIGap.h8,

                  _buildFAQ(
                    "Can I get a refund if I can't attend the concert?",
                    "Unfortunately, no refunds will be provided unless the event is canceled by the organizer.",
                  ),
                  _buildFAQ(
                    "Is there a parking facility available at the venue?",
                    "Yes, there is paid parking available at Madison Square Garden.",
                  ),
                  _buildFAQ(
                    "Can I bring my camera?",
                    "Professional cameras and video recording are not allowed without permission.",
                  ),
                  UIGap.h16,
                  UIDivider(
                    color: UIColors.white50.withOpacity(0.15),
                  ),
                  UIGap.h16,
                  Text(
                    "Organizer Name",
                    style: UITypographies.bodyLarge(
                      context,
                      fontSize: 17.sp,
                      color: UIColors.grey500,
                    ),
                  ),
                  UIGap.h4,
                  Text(
                    "Live Nation Entertainment",
                    style: UITypographies.bodyLarge(
                      context,
                      fontSize: 17.sp,
                    ),
                  ),
                  UIGap.h28,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: UIPrimaryButton(
                      text: 'Buy Ticket',
                      textStyle: UITypographies.bodyLarge(context),
                      size: UIButtonSize.large,
                      borderRadius: BorderRadius.circular(12.r),
                      onPressed: () {
                        context.pushRoute(const SelectTicketRoute());
                      },
                    ),
                  ),
                  UIGap.h48,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: UITypographies.bodyLarge(
              context,
              fontSize: 17.sp,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: UITypographies.bodyLarge(
                context,
                fontSize: 17.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q: $question",
            style: UITypographies.bodyLarge(
              context,
              fontSize: 17.sp,
            ),
          ),
          UIGap.w4,
          Text(
            "A: $answer",
            style: UITypographies.bodyLarge(
              context,
              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}
