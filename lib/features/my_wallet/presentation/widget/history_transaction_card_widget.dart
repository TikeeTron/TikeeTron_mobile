import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/enum/asset_type_enum.dart';
import '../../../../common/enum/transaction_type_enum.dart';
import '../../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../shared/data/model/transaction_model.dart';

class HistoryTransactionCardWidget extends StatelessWidget {
  final TransactionModel data;
  final void Function()? onTap;
  const HistoryTransactionCardWidget({
    super.key,
    required this.data,
    this.onTap,
  });

  Widget get iconTransaction {
    switch (data.transactionType) {
      case TransactionTypeEnum.receive:
        return data.assetType == AssetTypeEnum.nft
            ? SvgUI(
                SvgConst.icTicket,
                width: 20.w,
                height: 20.h,
                color: UIColors.white50,
              )
            : Icon(
                CupertinoIcons.arrow_down,
                size: 20.w,
                color: UIColors.white50,
              );
      case TransactionTypeEnum.send:
        return data.assetType == AssetTypeEnum.nft
            ? SvgUI(
                SvgConst.icTicket,
                width: 20.w,
                height: 20.h,
                color: UIColors.white50,
              )
            : Icon(
                CupertinoIcons.arrow_up,
                size: 20.w,
                color: UIColors.white50,
              );
      case TransactionTypeEnum.purchased:
        return SvgUI(
          SvgConst.icTicket,
          width: 20.w,
          height: 20.h,
          color: UIColors.white50,
        );
      default:
        return SvgUI(
          SvgConst.icTicket,
          width: 20.w,
          height: 20.h,
          color: UIColors.white50,
        );
    }
  }

  String get title {
    switch (data.transactionType) {
      case TransactionTypeEnum.receive:
        return 'Receive';
      case TransactionTypeEnum.send:
        return 'Sent';
      case TransactionTypeEnum.purchased:
        return 'Purchased Ticket';
      default:
        return '';
    }
  }

  String get subtitle {
    switch (data.transactionType) {
      case TransactionTypeEnum.receive:
        return 'From ${DynamicParsing(data.fromAddress).shortedWalletAddress ?? ''}';
      case TransactionTypeEnum.send:
        return 'To ${DynamicParsing(data.toAddress).shortedWalletAddress ?? ''}';
      case TransactionTypeEnum.purchased:
        return data.title ?? '';
      default:
        return '';
    }
  }

  String get amountTransaction {
    switch (data.transactionType) {
      case TransactionTypeEnum.receive:
        return '+${data.amount} TRX';
      case TransactionTypeEnum.send:
        return '-${data.amount} TRX';
      default:
        return '-${data.amount} TRX';
    }
  }

  Color get transactionColor {
    switch (data.transactionType) {
      case TransactionTypeEnum.receive:
        return UIColors.green500;
      case TransactionTypeEnum.send:
        return UIColors.red500;
      default:
        return UIColors.red500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: Padding(
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
                  child: iconTransaction,
                ),
                UIGap.w12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: UITypographies.subtitleLarge(
                        context,
                        fontSize: 17.sp,
                      ),
                    ),
                    UIGap.h4,
                    Text(
                      subtitle,
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
                color: transactionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
