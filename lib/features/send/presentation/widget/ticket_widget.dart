import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';

class TicketWidget extends StatelessWidget {
  final String name;
  final String location;
  final String eventDate;
  final String image;
  const TicketWidget({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.eventDate,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        width: 300,
        height: 300,
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
          children: [
            UINetworkImage(
              url: image,
              width: double.infinity,
              height: 130.h,
              fit: BoxFit.cover,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: UITypographies.h4(context),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      eventDate,
                      style: UITypographies.bodyLarge(
                        context,
                        color: UIColors.grey500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      location,
                      style: UITypographies.bodyLarge(
                        context,
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

    path.lineTo(size.width, size.height / 2.2 - 15);
    path.arcToPoint(
      Offset(size.width, size.height / 2.2 + 15),
      radius: Radius.circular(10.r),
      clockwise: false,
    );
    path.lineTo(size.width, size.height - radius);

    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.lineTo(0, size.height / 2.2 + 15);
    path.arcToPoint(
      Offset(0, size.height / 2.2 - 15),
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
