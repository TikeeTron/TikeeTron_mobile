import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter_new/qr_flutter.dart';

import '../../../common/common.dart';
import '../../../common/components/container/grabber_container.dart';

class MyTicketQrBottomSheet extends StatelessWidget {
  final String ticketId;
  const MyTicketQrBottomSheet({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: UIColors.black400,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: const GrabberContainer(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 37.h),
            child: Text(
              'Scan Your Ticket',
              textAlign: TextAlign.center,
              style: UITypographies.h4(context),
            ),
          ),
          UIGap.h24,
          UIDivider(
            color: UIColors.white50.withOpacity(0.15),
          ),
          UIGap.h24,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.w),
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: UIColors.black300,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              'Show your ticket below to the event staff to scan and verify your entry.',
              textAlign: TextAlign.center,
              style: UITypographies.bodyLarge(
                context,
                fontSize: 17.sp,
              ),
            ),
          ),
          UIGap.h20,
          ClipRRect(
            borderRadius: BorderRadius.circular(40.r),
            child: QrImageView(
              data: ticketId,
              version: QrVersions.auto,
              size: 270.h,
              gapless: true,
              embeddedImage: const AssetImage(ImagesConst.appLogoRounded),
              padding: EdgeInsets.all(30.w),
              backgroundColor: UIColors.white50,
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(60.w, 60.w),
                borderRadius: 20.r,
                safeArea: true,
                safeAreaMultiplier: 1,
                embeddedImageShape: EmbeddedImageShape.circle,
              ),
              eyeStyle: const QrEyeStyle(
                color: UIColors.black500,
                eyeShape: QrEyeShape.square,
                borderRadius: 0,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                borderRadius: 0,
                roundedOutsideCorners: true,
                color: UIColors.black500,
                dataModuleShape: QrDataModuleShape.square,
              ),
              errorStateBuilder: (cxt, err) {
                return const Center(
                  child: Text(
                    "Uh oh! Something went wrong...",
                  ),
                );
              },
            ),
          ),
          UIGap.h20,
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: UIColors.black300,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              ticketId,
              style: UITypographies.bodyLarge(
                context,
                fontSize: 17.sp,
              ),
            ),
          ),
          UIGap.h40,
        ],
      ),
    );
  }
}
