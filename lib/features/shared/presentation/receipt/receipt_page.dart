import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/enum/transaction_type_enum.dart';
import '../../data/model/receipt_model.dart';
import 'widget/receipt_detail_widget.dart';

@RoutePage()
class ReceiptPage extends StatelessWidget {
  final ReceiptModel data;
  const ReceiptPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Sending TRX',
          style: UITypographies.h4(
            context,
            color: UIColors.white50,
          ),
        ),
        leading: BounceTap(
          onTap: () {
            context.maybePop();
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
                child: Icon(
                  data.transactionType == TransactionTypeEnum.send ? CupertinoIcons.arrow_up : CupertinoIcons.arrow_down,
                  size: 20.w,
                  color: UIColors.white50,
                ),
              ),
              UIGap.h12,
              Text(
                '${data.transactionType == TransactionTypeEnum.send ? 'Sending To: ' : 'Receive From: '}0z8f2...cccd',
                style: UITypographies.bodyLarge(
                  context,
                  color: UIColors.grey500,
                ),
              ),
              UIGap.h4,
              Text(
                '200 TRX',
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
                      color: UIColors.orange950,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.hourglass,
                          color: UIColors.orange400,
                          size: 18.w,
                        ),
                        UIGap.w12,
                        Text(
                          'Transaction in progress',
                          style: UITypographies.bodyLarge(
                            context,
                            color: UIColors.orange400,
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
              const ReceiptDetailWidget(
                title: 'Transaction ID',
                value: 'tx1234567890abcd',
              ),
              UIGap.h20,
              const ReceiptDetailWidget(
                title: 'Date & Time',
                value: '24th Sept 2024, 2:30 PM',
              ),
              UIGap.h20,
              const ReceiptDetailWidget(
                title: 'From',
                value: '0x9876...wxyz',
              ),
              UIGap.h20,
              const ReceiptDetailWidget(
                title: 'To',
                value: '0x9876...wxyz',
              ),
              UIGap.h20,
              const ReceiptDetailWidget(
                title: 'Network Fee',
                value: '0.005 TRX',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
