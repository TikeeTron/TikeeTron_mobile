import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:blockies/blockies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/components.dart';
import '../../../common/components/container/rounded_container.dart';
import '../../../common/components/svg/svg_ui.dart';
import '../../../common/constants/assets_const.dart';
import '../../../common/themes/themes.dart';
import '../../../common/utils/extensions/dynamic_parsing.dart';
import 'widget/ticket_widget.dart';

@RoutePage()
class SendTicketPage extends StatefulWidget {
  final String walletAddress;

  const SendTicketPage({super.key, required this.walletAddress});

  @override
  State<SendTicketPage> createState() => _SendTicketPageState();
}

class _SendTicketPageState extends State<SendTicketPage> {
  bool _showTransactionDetails = false;

  TextEditingController _amountController = TextEditingController();

  double turns = 0.0;

  int _countdown = 5;
  late Timer _timer;

  void toggleShowTransactionDetails() {
    setState(() {
      _showTransactionDetails = !_showTransactionDetails;
      turns = _showTransactionDetails ? 0.5 : 0.0;
    });
  }

  void startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _countdown = 5;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Sending To',
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
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: UIColors.white50.withOpacity(0.15),
                            ),
                            borderRadius: BorderRadius.circular(99.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RoundedContainer(
                                width: 28.w,
                                height: 28.w,
                                radius: 9999,
                                child: Blockies(
                                  seed: widget.walletAddress,
                                ),
                              ),
                              UIGap.w12,
                              Text(
                                shortedAddress,
                                style: UITypographies.bodyLarge(
                                  context,
                                ),
                              ),
                              UIGap.w12,
                              BounceTap(
                                onTap: () {
                                  log('POP BACK');
                                  context.maybePop();
                                },
                                child: SvgUI(
                                  SvgConst.icEditAddress,
                                  width: 16.w,
                                  height: 16.h,
                                  color: UIColors.white50,
                                ),
                              ),
                              UIGap.w4,
                            ],
                          ),
                        ),
                      ],
                    ),
                    UIGap.h24,
                    const TicketWidget(
                      title: '',
                      subtitle: '',
                      image: '',
                    ),
                    UIGap.h24,
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 10.h),
                            decoration: BoxDecoration(
                              color: UIColors.black400,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Final Amount (with fees) ',
                                  style: UITypographies.bodyLarge(
                                    context,
                                    color: UIColors.white50,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                UIGap.h4,
                                Text(
                                  '200.006 TRX',
                                  style: UITypographies.subtitleLarge(
                                    context,
                                    color: UIColors.primary500,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: _showTransactionDetails
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                                          child: Column(
                                            children: <Widget>[
                                              UIGap.h12,
                                              UIDivider(
                                                color: UIColors.white50.withOpacity(0.15),
                                              ),
                                              UIGap.h12,
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.all(6.w),
                                                        decoration: BoxDecoration(
                                                          color: UIColors.grey200.withOpacity(0.24),
                                                          borderRadius: BorderRadius.circular(999),
                                                        ),
                                                        child: Icon(
                                                          CupertinoIcons.smallcircle_fill_circle_fill,
                                                          size: 12.w,
                                                          color: UIColors.white50,
                                                        ),
                                                      ),
                                                      UIGap.size(w: 6.w),
                                                      Text(
                                                        'Network Fee',
                                                        style: UITypographies.bodyLarge(
                                                          context,
                                                          color: UIColors.white50,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '0.005 TRX',
                                                    style: UITypographies.subtitleLarge(
                                                      context,
                                                      color: UIColors.white50,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              UIGap.h8,
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.all(6.w),
                                                        decoration: BoxDecoration(
                                                          color: UIColors.grey200.withOpacity(0.24),
                                                          borderRadius: BorderRadius.circular(999),
                                                        ),
                                                        child: Icon(
                                                          CupertinoIcons.arrow_right_arrow_left,
                                                          size: 12.w,
                                                          color: UIColors.white50,
                                                        ),
                                                      ),
                                                      UIGap.size(w: 6.w),
                                                      Text(
                                                        'Exchange Rate',
                                                        style: UITypographies.bodyLarge(
                                                          context,
                                                          color: UIColors.white50,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '1 TRX = 0.03 USD',
                                                    style: UITypographies.subtitleLarge(
                                                      context,
                                                      color: UIColors.white50,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                UIGap.h12,
                                BounceTap(
                                  onTap: () {
                                    toggleShowTransactionDetails();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: UIColors.black300,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16.r),
                                        bottomRight: Radius.circular(16.r),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Final Amount (with fees) ',
                                          style: UITypographies.bodyLarge(
                                            context,
                                            color: UIColors.white50,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        UIGap.w4,
                                        AnimatedRotation(
                                          duration: const Duration(milliseconds: 300),
                                          turns: turns,
                                          child: Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 17.w,
                                            color: UIColors.white50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          UIGap.h8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Refreshing in',
                                style: UITypographies.bodyLarge(
                                  context,
                                  color: UIColors.grey500,
                                ),
                              ),
                              UIGap.w4,
                              Text(
                                '$_countdown',
                                style: UITypographies.subtitleLarge(
                                  context,
                                  color: UIColors.white50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SlideAction(
                  height: 50.h,
                  borderRadius: 16.r,
                  enabled: _amountController.text.isNotEmpty,
                  onSubmit: () {
                    // navigationService.push(
                    //   ReceiptRoute(
                    //     data: ReceiptModel(
                    //       'Send TRX',
                    //       TransactionTypeEnum.send,
                    //     ),
                    //   ),
                    // );
                    return null;
                  },
                  outerColor: UIColors.grey200.withOpacity(0.24),
                  text: 'Slide to Send',
                  textColor: UIColors.primary500,
                  sliderRotate: false,
                  textStyle: UITypographies.bodyLarge(
                    context,
                    fontSize: 17.sp,
                    color: UIColors.primary500,
                  ),
                  innerColor: UIColors.primary500,
                  animationDuration: const Duration(milliseconds: 300),
                  sliderButtonIcon: Icon(
                    CupertinoIcons.chevron_right_2,
                    size: 28.w,
                    color: UIColors.white50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get shortedAddress {
    if (widget.walletAddress.isNotEmpty) {
      return DynamicParsing(widget.walletAddress).shortedWalletAddress!;
    }
    return '';
  }
}
