import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';

class GrabberContainer extends StatelessWidget {
  const GrabberContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.r),
        color: UIColors.grey200.withOpacity(0.3),
      ),
    );
  }
}
