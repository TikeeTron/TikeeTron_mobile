import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/enum/asset_type_enum.dart';
import '../../../../common/enum/transaction_state_enum.dart';
import '../../../../common/enum/transaction_type_enum.dart';
import '../../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../../common/utils/extensions/string_parsing.dart';
import '../../../../core/routes/app_route.dart';
import '../../data/model/transaction_model.dart';
import 'widget/receipt_detail_widget.dart';

@RoutePage()
class ReceiptPage extends StatelessWidget {
  final TransactionModel data;
  const ReceiptPage({super.key, required this.data});
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

  String get subtitle {
    switch (data.transactionType) {
      case TransactionTypeEnum.receive:
        return 'Receive From ${DynamicParsing(data.fromAddress).shortedWalletAddress ?? ''}';
      case TransactionTypeEnum.send:
        return 'Sending To ${DynamicParsing(data.toAddress).shortedWalletAddress ?? ''}';
      case TransactionTypeEnum.purchased:
        return data.title ?? '';
      default:
        return '';
    }
  }

  String get title {
    switch (data.transactionType) {
      case TransactionTypeEnum.receive:
        return data.assetType == AssetTypeEnum.nft ? 'Received Ticket' : 'Received TRX';
      case TransactionTypeEnum.send:
        return data.assetType == AssetTypeEnum.nft ? 'Sending Ticket' : 'Sending TRX';
      case TransactionTypeEnum.purchased:
        return 'Purchased Ticket';
      default:
        return '';
    }
  }

  IconData get transactionStatusIcon {
    switch (data.transactionStatus) {
      case TransactionStateEnum.failed:
        return CupertinoIcons.clear;
      case TransactionStateEnum.success:
        return CupertinoIcons.check_mark;
      case TransactionStateEnum.pending:
        return CupertinoIcons.hourglass;
      default:
        return CupertinoIcons.hourglass;
    }
  }

  Color get transactionStatusColor {
    switch (data.transactionStatus) {
      case TransactionStateEnum.failed:
        return UIColors.red400;
      case TransactionStateEnum.success:
        return UIColors.green400;
      case TransactionStateEnum.pending:
        return UIColors.orange400;
      default:
        return UIColors.orange400;
    }
  }

  Color get transactionStatusBackgroundColor {
    switch (data.transactionStatus) {
      case TransactionStateEnum.failed:
        return UIColors.red950;
      case TransactionStateEnum.success:
        return UIColors.green950;
      case TransactionStateEnum.pending:
        return UIColors.orange950;
      default:
        return UIColors.orange950;
    }
  }

  String get transactionStatusText {
    switch (data.transactionStatus) {
      case TransactionStateEnum.failed:
        return 'Transaction Failed';
      case TransactionStateEnum.success:
        return 'Transaction Success';
      case TransactionStateEnum.pending:
        return 'Transaction in Progress';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          navigationService.pushAndPopUntil(
            const DashboardRoute(),
            predicate: (p0) => true,
          );
        }
      },
      child: CupertinoPageScaffold(
        backgroundColor: UIColors.black500,
        navigationBar: ScaffoldAppBar.cupertino(
          context,
          middle: Text(
            title,
            style: UITypographies.h4(
              context,
              color: UIColors.white50,
            ),
          ),
          leading: BounceTap(
            onTap: () {
              navigationService.pushAndPopUntil(
                const DashboardRoute(),
                predicate: (p0) => true,
              );
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: UIColors.grey200.withOpacity(0.24),
              ),
              child: Icon(
                Icons.arrow_back,
                color: UIColors.white50,
                size: 20.w,
              ),
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: UIColors.grey200.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: iconTransaction,
                ),
                UIGap.h12,
                Text(
                  subtitle,
                  style: UITypographies.bodyLarge(
                    context,
                    color: UIColors.grey500,
                  ),
                ),
                UIGap.h8,
                Text(
                  '${data.amount} TRX',
                  style: UITypographies.h2(
                    context,
                    color: UIColors.white50,
                  ),
                ),
                UIGap.h20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: transactionStatusBackgroundColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            transactionStatusIcon,
                            color: transactionStatusColor,
                            size: 18.w,
                          ),
                          UIGap.w12,
                          Text(
                            transactionStatusText,
                            style: UITypographies.bodyLarge(
                              context,
                              color: transactionStatusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                UIGap.h24,
                UIDivider(
                  color: UIColors.white50.withOpacity(0.15),
                ),
                UIGap.h24,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Transaction Details',
                    style: UITypographies.subtitleLarge(
                      context,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
                UIGap.h20,
                ReceiptDetailWidget(
                  title: 'Transaction ID',
                  value: DynamicParsing(data.txId ?? '').shortedWalletAddress ?? '',
                  isTxId: true,
                  txId: data.txId,
                ),
                UIGap.h20,
                ReceiptDetailWidget(
                  title: 'Date & Time',
                  value: data.date ?? '',
                ),
                UIGap.h20,
                ReceiptDetailWidget(
                  title: 'From',
                  value: DynamicParsing(data.fromAddress ?? '').shortedWalletAddress ?? '',
                ),
                UIGap.h20,
                ReceiptDetailWidget(
                  title: 'To',
                  value: DynamicParsing(data.toAddress ?? '').shortedWalletAddress ?? '',
                ),
                UIGap.h20,
                ReceiptDetailWidget(
                  title: 'Network Fee',
                  value: '${data.resourcesConsumed.toString().amountInWeiToToken(
                        decimals: 3,
                        fractionDigits: 3,
                      )} TRX',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
