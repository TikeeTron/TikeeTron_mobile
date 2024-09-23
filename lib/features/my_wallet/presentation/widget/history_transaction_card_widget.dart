import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';

enum HistoryTransactionType { send, receive }

class HistoryTransactionCardWidget extends StatelessWidget {
  final HistoryTransactionType type;
  final String address;
  final String amount;

  const HistoryTransactionCardWidget({
    super.key,
    required this.type,
    required this.address,
    required this.amount,
  });

  IconData get iconTransaction {
    switch (type) {
      case HistoryTransactionType.receive:
        return CupertinoIcons.arrow_down;
      case HistoryTransactionType.send:
        return CupertinoIcons.arrow_up;
      default:
        return CupertinoIcons.arrow_down;
    }
  }

  String get title {
    switch (type) {
      case HistoryTransactionType.receive:
        return 'Receive';
      case HistoryTransactionType.send:
        return 'Sent';
      default:
        return '';
    }
  }

  String get subtitle {
    switch (type) {
      case HistoryTransactionType.receive:
        return 'From';
      case HistoryTransactionType.send:
        return 'To';
      default:
        return '';
    }
  }

  String get amountTransaction {
    switch (type) {
      case HistoryTransactionType.receive:
        return '+$amount';
      case HistoryTransactionType.send:
        return '-$amount';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: UIColors.grey200.withOpacity(0.24),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Icon(
                  iconTransaction,
                  size: 20.w,
                  color: UIColors.white50,
                ),
              ),
              UIGap.w12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$title TRX',
                    style: UITypographies.subtitleLarge(
                      context,
                      fontSize: 17.sp,
                    ),
                  ),
                  UIGap.h4,
                  Text(
                    '$subtitle $address',
                    style: UITypographies.bodyMedium(
                      context,
                      fontSize: 15.sp,
                      color: UIColors.grey500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            amountTransaction,
            style: UITypographies.subtitleLarge(
              context,
              fontSize: 17.sp,
              color: type == HistoryTransactionType.receive ? UIColors.green500 : UIColors.white50,
            ),
          ),
        ],
      ),
    );
  }
}
