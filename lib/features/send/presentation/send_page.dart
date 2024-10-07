import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/config/padding_config.dart';
import '../../../common/enum/send_type_enum.dart';
import '../../../core/core.dart';
import 'widget/send_item_widget.dart';

@RoutePage()
class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Select to Send',
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
          padding: Paddings.defaultPaddingH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UIGap.h24,
              Text(
                'Send TRON',
                style: UITypographies.subtitleLarge(context),
              ),
              UIGap.h16,
              SendItemWidget(
                icon: SvgConst.icWalletSend,
                title: 'TRX',
                onTap: () {
                  navigationService.push(
                    SelectRecipientRoute(
                      sendType: SendTypeEnum.coin,
                    ),
                  );
                },
                subtitle: 'send trx to another account',
                iconSize: 20,
              ),
              UIGap.h24,
              Text(
                'Send Ticket',
                style: UITypographies.subtitleLarge(context),
              ),
              UIGap.h16,
              SendItemWidget(
                icon: SvgConst.icTicket,
                title: '2 Ticket Available',
                subtitle: 'Ed Sheeran Live at Madison Square Garden',
                onTap: () {
                  navigationService.push(
                    SelectRecipientRoute(
                      sendType: SendTypeEnum.ticket,
                    ),
                  );
                },
                iconSize: 20,
              ),
              UIGap.h12,
              SendItemWidget(
                icon: SvgConst.icTicket,
                title: '2 Ticket Available',
                subtitle: 'Ed Sheeran Live at Madison Square Garden',
                onTap: () {
                  navigationService.push(
                    SelectRecipientRoute(
                      sendType: SendTypeEnum.ticket,
                    ),
                  );
                },
                iconSize: 20,
              ),
              UIGap.h12,
              SendItemWidget(
                icon: SvgConst.icTicket,
                title: '2 Ticket Available',
                subtitle: 'Ed Sheeran Live at Madison Square Garden',
                onTap: () {
                  navigationService.push(
                    SelectRecipientRoute(
                      sendType: SendTypeEnum.ticket,
                    ),
                  );
                },
                iconSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
