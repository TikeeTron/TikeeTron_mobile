import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/container/grabber_container.dart';
import 'auth_type_widget.dart';

class AuthTypeModal extends StatelessWidget {
  final void Function()? onCreateWallet;
  final void Function()? onImportWallet;
  const AuthTypeModal({
    super.key,
    this.onCreateWallet,
    this.onImportWallet,
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
              'Create or Import Wallet',
              textAlign: TextAlign.center,
              style: UITypographies.h5(context, fontSize: 22.sp),
            ),
          ),
          UIGap.h16,
          UIDivider(
            color: UIColors.white50.withOpacity(0.15),
            thickness: 1.r,
          ),
          UIGap.size(h: 20.h),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
            child: Column(
              children: [
                AuthTypeWidget(
                  icon: SvgConst.wallet,
                  onTap: onCreateWallet,
                  title: 'Create a new wallet',
                  subtitle: 'Create a new wallet to get started',
                ),
                UIGap.h36,
                AuthTypeWidget(
                  icon: SvgConst.import,
                  onTap: onImportWallet,
                  title: 'Import an existing wallet',
                  subtitle: 'Import an existing wallet to get started',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
