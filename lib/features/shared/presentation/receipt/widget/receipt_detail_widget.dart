import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../common/common.dart';
import '../../../../../common/components/button/bounce_tap.dart';

class ReceiptDetailWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool isTxId;
  final String? txId;
  const ReceiptDetailWidget({super.key, required this.title, required this.value, this.isTxId = false, this.txId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: UITypographies.bodyLarge(
            context,
            color: UIColors.grey500,
          ),
        ),
        isTxId
            ? BounceTap(
                onTap: () async {
                  await launchUrlString('https://shasta-tronscan.on.btfs.io/#/transaction/${txId}');
                },
                child: Row(
                  children: [
                    Text(
                      value,
                      style: UITypographies.subtitleLarge(context),
                    ),
                    UIGap.w4,
                    Icon(
                      CupertinoIcons.square_arrow_right,
                      size: 16.r,
                      color: UIColors.white50,
                    ),
                  ],
                ),
              )
            : Text(
                value,
                style: UITypographies.subtitleLarge(context),
              ),
      ],
    );
  }
}
