import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common.dart';
import '../container/grabber_container.dart';

class ConfirmationAlertWidget extends StatelessWidget {
  final void Function()? onClose;
  final void Function()? onConfirm;

  const ConfirmationAlertWidget({
    super.key,
    this.onClose,
    this.onConfirm,
  });

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
              'Remove Account',
              textAlign: TextAlign.center,
              style: UITypographies.h5(context, fontSize: 22.sp),
            ),
          ),
          UIGap.h16,
          UIDivider(
            color: UIColors.white50.withOpacity(0.15),
            thickness: 1.r,
          ),
          UIGap.h20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.trash,
                  color: UIColors.red600,
                  size: 56.w,
                ),
                UIGap.h20,
                Text(
                  'Removing this account.',
                  style: UITypographies.subtitleLarge(
                    context,
                    fontSize: 20.sp,
                  ),
                ),
                UIGap.h4,
                Text(
                  'You can still recover it later using your secret recovery phrase with this app or another wallet.',
                  textAlign: TextAlign.center,
                  style: UITypographies.bodyLarge(
                    context,
                    color: UIColors.grey500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: UIPrimaryButton(
                    text: 'Cancel',
                    textStyle: UITypographies.bodyLarge(context),
                    size: UIButtonSize.large,
                    borderRadius: BorderRadius.circular(12.r),
                    onPressed: onClose,
                    backgroundColor: UIColors.grey200.withOpacity(0.24),
                  ),
                ),
                UIGap.w12,
                Expanded(
                  child: UIPrimaryButton(
                    text: 'Remove',
                    textStyle: UITypographies.bodyLarge(context),
                    size: UIButtonSize.large,
                    borderRadius: BorderRadius.circular(12.r),
                    onPressed: onConfirm,
                    backgroundColor: UIColors.red500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
