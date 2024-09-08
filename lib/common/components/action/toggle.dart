import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/extensions/theme_extension.dart';
import '../spacing/gap.dart';

class UIToggle extends StatelessWidget {
  const UIToggle({
    super.key,
    required this.value,
    required this.primaryTitle,
    required this.secondaryTitle,
    required this.onChanged,
  });

  final bool value;
  final String primaryTitle;
  final String secondaryTitle;
  final void Function(bool value) onChanged;

  TextStyle _textStyle(BuildContext context) => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: value
            ? context.theme.colors.textOnPrimary
            : context.theme.colors.textPrimary,
      ).withFigmaLineHeight(14.sp);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.backgroundPrimary,
        borderRadius: BorderRadius.circular(8).r,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 4.w,
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            left: value ? 0 : 44.w,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: 40.w,
              height: 22.h,
              decoration: BoxDecoration(
                color: context.theme.colors.primary,
                borderRadius: BorderRadius.circular(4).r,
              ),
            ),
          ),
          Row(
            children: [
              _optionWidget(
                context,
                title: primaryTitle,
                value: true,
              ),
              UIGap.w4,
              _optionWidget(
                context,
                title: secondaryTitle,
                value: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _optionWidget(
    BuildContext context, {
    required String title,
    required bool value,
  }) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: SizedBox(
        width: 40.w,
        height: 22.h,
        child: Center(
          child: Text(
            title,
            style: _textStyle(context),
          ),
        ),
      ),
    );
  }
}
