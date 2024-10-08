import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/svg/svg_ui.dart';

class HomeWalletWidget extends StatelessWidget {
  final String walletBalance;
  final void Function()? onSend;
  final void Function()? onReceive;
  final void Function()? onGoToDetailWallet;
  const HomeWalletWidget({
    super.key,
    required this.walletBalance,
    this.onSend,
    this.onReceive,
    this.onGoToDetailWallet,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onGoToDetailWallet,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 10.w, 12.h),
        decoration: BoxDecoration(
          color: UIColors.black400,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'My Wallet',
                  style: UITypographies.bodyLarge(
                    context,
                    color: UIColors.white100,
                  ),
                ),
                UIGap.h4,
                Text(
                  '${walletBalance} TRX',
                  style: UITypographies.subtitleLarge(
                    context,
                    color: UIColors.green400,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                BounceTap(
                  onTap: onReceive,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: UIColors.grey200.withOpacity(0.24),
                    ),
                    child: SvgUI(
                      SvgConst.icReceive,
                      width: 20.w,
                      height: 20.w,
                      color: UIColors.white50,
                    ),
                  ),
                ),
                UIGap.w12,
                BounceTap(
                  onTap: onSend,
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
          ],
        ),
      ),
    );
  }
}
