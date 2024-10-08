import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/svg/svg_ui.dart';

import '../../../common/config/padding_config.dart';
import '../../../common/utils/extensions/context_parsing.dart';
import '../../../common/utils/extensions/string_parsing.dart';
import '../../../core/injector/injector.dart';
import '../../../core/routes/app_route.dart';
import '../../home/data/model/response/get_detail_event_response.dart';
import '../../shared/presentation/loading_page.dart';
import '../../wallet/domain/repository/wallet_core_repository.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import 'cubit/buy_ticket_quoting_cubit.dart';
import 'cubit/confirm_buy_ticket_cubit.dart';
import 'widget/detail_ticket_card_widget.dart';

@RoutePage()
class ConfirmBuyTicketPage extends StatefulWidget {
  final TicketType selectedTicket;
  final int eventId;
  const ConfirmBuyTicketPage({super.key, required this.selectedTicket, required this.eventId});

  @override
  State<ConfirmBuyTicketPage> createState() => _ConfirmBuyTicketPageState();
}

class _ConfirmBuyTicketPageState extends State<ConfirmBuyTicketPage> {
  bool _showTransactionDetails = false;

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

  String walletAddress = '';
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final activeWalletCubit = BlocProvider.of<ActiveWalletCubit>(context);
      final quotingCubit = BlocProvider.of<BuyTicketQuotingCubit>(context);

      final activeWallet = activeWalletCubit.getActiveWallet();
      if (activeWallet != null) {
        walletAddress = locator<WalletCoreRepository>().getWalletAddress(
          wallet: activeWallet,
        );
        activeWalletCubit.getWalletBalance(
          walletAddress: walletAddress,
          walletIndex: activeWalletCubit.state.walletIndex ?? 0,
        );
        quotingCubit.quotingBuyTicket(
          walletAddress: walletAddress,
          targetAddress: 'TJBhWTLc8fKLJz5PdsQSQAaB2Hs93koXBJ',
        );
      }
    });
    startCountdownTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Payment Summary',
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
      child: BlocBuilder<ActiveWalletCubit, ActiveWalletState>(builder: (context, activeWalletState) {
        return Material(
          color: Colors.transparent,
          child: BlocBuilder<BuyTicketQuotingCubit, BuyTicketQuotingState>(builder: (context, quotingState) {
            if (quotingState is! BuyTicketQuotingSuccessState) {
              return const LoadingPage(
                opacity: 1,
                title: 'Loading...',
              );
            }
            return SafeArea(
              bottom: false,
              child: Padding(
                padding: Paddings.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: UIColors.green950,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SvgUI(
                                SvgConst.wallet,
                                color: UIColors.green400,
                              ),
                              UIGap.w4,
                              Text(
                                '${activeWalletState.wallet?.totalBalance ?? 0} TRX',
                                style: UITypographies.bodyLarge(
                                  context,
                                  fontWeight: FontWeight.w600,
                                  color: UIColors.green400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        UIGap.h24,
                        DetailTicketCardWidget(
                          title: widget.selectedTicket.name ?? '',
                          capacity: widget.selectedTicket.capacity ?? 0,
                          subtitle: widget.selectedTicket.description ?? '',
                          onTap: () {},
                          price: widget.selectedTicket.price?.toString().amountInWeiToToken(
                                    decimals: 6,
                                    fractionDigits: 2,
                                  ) ??
                              '',
                        ),
                        UIGap.h24,
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
                                '${(double.tryParse(widget.selectedTicket.price.toString().amountInWeiToToken(
                                      decimals: 6,
                                      fractionDigits: 2,
                                    )) ?? 0) + (double.tryParse(quotingState.networkFee?.toString().amountInWeiToToken(
                                      decimals: 3,
                                      fractionDigits: 3,
                                    ) ?? '0') ?? 0)} TRX',
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
                                                  '${quotingState.networkFee?.toString().amountInWeiToToken(
                                                        decimals: 3,
                                                        fractionDigits: 3,
                                                      )} TRX',
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
                                                  '1 TRX = ${quotingState.exchangeRate?.toStringAsFixed(3)} USD',
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
                    BlocBuilder<ConfirmBuyTicketCubit, ConfirmBuyTicketState>(builder: (context, buyTicketState) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: SlideAction(
                          height: 50.h,
                          borderRadius: 16.r,
                          enabled: true,
                          onSubmit: () async {
                            context.showFullScreenLoadingWithMessage('Loading...', 'please wait, your transaction is in progress');
                            final resultBuyTicket = await BlocProvider.of<ConfirmBuyTicketCubit>(context).confirmBuyTicket(
                              ticketPrice: widget.selectedTicket.price ?? 0,
                              ticketType: widget.selectedTicket.name ?? '',
                              buyerAddress: walletAddress,
                              wallet: activeWalletState.wallet!,
                              eventId: widget.eventId,
                              networkFee: quotingState.networkFee ?? 0,
                            );
                            context.hideFullScreenLoading;
                            if (resultBuyTicket != null) {
                              navigationService.push(ReceiptRoute(data: resultBuyTicket));
                            } else {
                              if (buyTicketState is ConfirmBuyTicketErrorState) {
                                toastHelper.showError(buyTicketState.message ?? '');
                              }
                            }
                          },
                          outerColor: UIColors.grey200.withOpacity(0.24),
                          text: 'Confirm and Pay',
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
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
