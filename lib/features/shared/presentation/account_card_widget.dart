import 'package:blockies/blockies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/container/rounded_container.dart';
import '../../../common/utils/extensions/dynamic_parsing.dart';

class AccountCardWidget extends StatelessWidget {
  final String address;
  final void Function()? onTap;
  const AccountCardWidget({super.key, required this.address, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                RoundedContainer(
                  width: 46.w,
                  height: 46.w,
                  radius: 9999,
                  child: Blockies(
                    seed: address,
                  ),
                ),
                UIGap.w16,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          address,
                          style: UITypographies.subtitleLarge(
                            context,
                            fontSize: 17.sp,
                          ),
                        ),
                        UIGap.h2,
                        Text(
                          shortedAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: UITypographies.bodyMedium(
                            context,
                            fontSize: 15.sp,
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
          Icon(
            CupertinoIcons.chevron_forward,
            size: 24.w,
            color: UIColors.white50,
          ),
        ],
      ),
    );
  }

  String get shortedAddress {
    if (address.isNotEmpty) {
      return DynamicParsing(address).shortedWalletAddress!;
    }
    return '';
  }
}
