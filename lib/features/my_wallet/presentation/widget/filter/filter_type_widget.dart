import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/common.dart';

class FilterTypeWidget extends StatelessWidget {
  final bool isSelected;
  final String value;
  const FilterTypeWidget({super.key, required this.isSelected, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: isSelected ? UIColors.white50 : null,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: UIColors.white50.withOpacity(0.15),
        ),
      ),
      child: Text(
        value,
        style: UITypographies.subtitleLarge(
          context,
          color: isSelected ? UIColors.black500 : UIColors.grey500,
        ),
      ),
    );
  }
}
