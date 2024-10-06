import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';

class DetailTicketCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;

  final void Function()? onTap;
  const DetailTicketCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 210.h,
          decoration: BoxDecoration(
            color: UIColors.black400,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: UITypographies.subtitleLarge(
                          context,
                          fontSize: 20.sp,
                        ),
                      ),
                      UIGap.h8,
                      Text(
                        subtitle,
                        style: UITypographies.bodyLarge(
                          context,
                          color: UIColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              UIGap.h8,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 36.w,
                ),
                child: UIDivider(
                  color: UIColors.white50.withOpacity(0.15),
                  variant: UIDividerVariant.dash,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price TRX',
                        textAlign: TextAlign.center,
                        style: UITypographies.subtitleLarge(
                          context,
                          fontSize: 20.sp,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: UIColors.green900,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: Text(
                          'Available',
                          textAlign: TextAlign.center,
                          style: UITypographies.bodyLarge(
                            context,
                            color: UIColors.green400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double radius = 20.0;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    path.lineTo(size.width, size.height / 1.8 - 15);
    path.arcToPoint(
      Offset(size.width, size.height / 1.8 + 15),
      radius: Radius.circular(10.r),
      clockwise: false,
    );
    path.lineTo(size.width, size.height - radius);

    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.lineTo(0, size.height / 1.8 + 15);
    path.arcToPoint(
      Offset(0, size.height / 1.8 - 15),
      radius: Radius.circular(10.r),
      clockwise: false,
    );
    path.lineTo(0, radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
