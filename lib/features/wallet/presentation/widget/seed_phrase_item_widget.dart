import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/container/rounded_container.dart';
import '../../../../common/components/text/auto_size_text_widget.dart';

class SeedPhraseItemWidget extends StatelessWidget {
  final String text;
  final bool? isConfirmed;
  final Function()? onTap;
  final int? index;
  final CrossAxisAlignment? textAlignment;

  const SeedPhraseItemWidget({
    super.key,
    required this.text,
    this.isConfirmed,
    this.onTap,
    this.index,
    this.textAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: RoundedContainer(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF34373E),
        ),
        useBorder: true,
        color: (isConfirmed == true) ? UIColors.black300 : UIColors.black400,
        child: Column(
          crossAxisAlignment: textAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (index != null && isConfirmed == true) ...[
                  Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      color: UIColors.primary500,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${(index ?? 0) + 1}',
                        style: UITypographies.bodySmall(
                          context,
                          color: UIColors.white50,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.r),
                ],
                AutoSizeTextWidget(
                  text,
                  color: UIColors.white50,
                  fontSize: 14,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
