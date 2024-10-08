import 'package:blockies/blockies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/container/rounded_container.dart';

class ListAccountCardWidget extends StatelessWidget {
  final bool isActive;
  final void Function()? onChangeAccount;
  final void Function()? onLogOut;

  final String walletAddress;
  final String walletName;
  const ListAccountCardWidget({
    super.key,
    required this.isActive,
    this.onChangeAccount,
    required this.walletAddress,
    required this.walletName,
    this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onChangeAccount,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? UIColors.primary500 : UIColors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: !isActive
              ? Border.all(
                  color: UIColors.white50.withOpacity(0.15),
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                RoundedContainer(
                  width: 46.w,
                  height: 46.w,
                  radius: 9999,
                  child: Blockies(
                    seed: walletAddress,
                  ),
                ),
                UIGap.w16,
                Text(
                  walletName,
                  style: UITypographies.subtitleLarge(
                    context,
                  ),
                ),
              ],
            ),
            BounceTap(
              onTap: onLogOut,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: UIColors.red900,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Center(
                  child: Icon(
                    Icons.logout,
                    size: 18.w,
                    color: UIColors.red500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
