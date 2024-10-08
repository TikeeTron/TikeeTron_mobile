import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/config/padding_config.dart';
import '../../../common/enum/send_type_enum.dart';
import '../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../core/core.dart';
import '../../shared/presentation/account_card_widget.dart';
import '../../shared/presentation/scan_qr_bottom_sheet.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import '../../wallet/presentation/cubit/wallets/wallets_cubit.dart';
import 'cubit/send_token_cubit.dart';
import 'cubit/ticket/send_ticket_cubit.dart';
import 'widget/send_item_widget.dart';

@RoutePage()
class SelectRecipientPage extends StatefulWidget {
  final SendTypeEnum sendType;
  const SelectRecipientPage({super.key, required this.sendType});

  @override
  State<SelectRecipientPage> createState() => _SelectRecipientPageState();
}

class _SelectRecipientPageState extends State<SelectRecipientPage> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  String senderAddress = '';
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {});
    final activeWallet = BlocProvider.of<ActiveWalletCubit>(context).getActiveWallet();
    senderAddress = activeWallet?.addresses?[0].address ?? '';
    _searchController.addListener(
      () {},
    );
    BlocProvider.of<WalletsCubit>(context).getWallets();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<SendTokenCubit>(context).resetSendState();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Select Recipient',
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
      child: BlocBuilder<WalletsCubit, WalletsState>(builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: Paddings.defaultPaddingH,
            child: Material(
              color: Colors.transparent,
              child: BlocBuilder<SendTokenCubit, SendTokenState>(builder: (context, sendTokenState) {
                return BlocBuilder<SendTicketCubit, SendTicketState>(builder: (context, sendTicketState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UIGap.h24,
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: UITextField(
                              radius: 999,
                              suffixWidth: 70.w,
                              textController: _searchController,
                              onChanged: (value) {
                                if (_searchController.text.isNotEmpty) {
                                  if (widget.sendType == SendTypeEnum.coin) {
                                    BlocProvider.of<SendTokenCubit>(context).setTargetAndSenderAddress(
                                      senderAddress: senderAddress,
                                      targetAddress: value,
                                    );
                                  } else {
                                    BlocProvider.of<SendTicketCubit>(context).setTargetAndSenderAddress(
                                      senderAddress: senderAddress,
                                      targetAddress: value,
                                    );
                                  }
                                } else {
                                  BlocProvider.of<SendTokenCubit>(context).resetSendState();
                                  BlocProvider.of<SendTicketCubit>(context).setTargetAndSenderAddress(
                                    senderAddress: senderAddress,
                                    targetAddress: null,
                                  );
                                }
                              },
                              hint: 'Search Address ...',
                              suffixIcon: sendTokenState is SendToken || (sendTicketState is SendTicket && sendTicketState.targetAddress != null)
                                  ? null
                                  : BounceTap(
                                      onTap: () async {
                                        ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);

                                        if (data != null) {
                                          _searchController.text = data.text ?? '';

                                          if (_searchController.text.isNotEmpty) {
                                            if (widget.sendType == SendTypeEnum.coin) {
                                              BlocProvider.of<SendTokenCubit>(context).setTargetAndSenderAddress(
                                                senderAddress: senderAddress,
                                                targetAddress: data.text ?? '',
                                              );
                                            } else {
                                              BlocProvider.of<SendTicketCubit>(context).setTargetAndSenderAddress(
                                                senderAddress: senderAddress,
                                                targetAddress: data.text ?? '',
                                              );
                                            }
                                          } else {
                                            BlocProvider.of<SendTokenCubit>(context).resetSendState();
                                            BlocProvider.of<SendTicketCubit>(context).setTargetAndSenderAddress(
                                              senderAddress: senderAddress,
                                              targetAddress: null,
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
                                        decoration: BoxDecoration(
                                          color: UIColors.primary500,
                                          borderRadius: BorderRadius.circular(40.r),
                                        ),
                                        child: Text(
                                          'Paste',
                                          style: UITypographies.bodyLarge(
                                            context,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          UIGap.w8,
                          BounceTap(
                            onTap: () async {
                              final scanQrResult = await ModalHelper.showModalBottomSheet(
                                context,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 1.1,
                                  decoration: BoxDecoration(
                                    color: UIColors.black400,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.r),
                                      topLeft: Radius.circular(16.r),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16.h),
                                        child: Text(
                                          'Scan QR',
                                          style: UITypographies.h4(context),
                                        ),
                                      ),
                                      const ScanQrBottomSheet(),
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                              );
                              if (widget.sendType == SendTypeEnum.coin) {
                                BlocProvider.of<SendTokenCubit>(context).setTargetAndSenderAddress(
                                  senderAddress: senderAddress,
                                  targetAddress: scanQrResult.toString(),
                                );
                              } else {
                                BlocProvider.of<SendTicketCubit>(context).setTargetAndSenderAddress(
                                  senderAddress: senderAddress,
                                  targetAddress: scanQrResult.toString(),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                color: UIColors.grey200.withOpacity(0.24),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Icon(
                                CupertinoIcons.qrcode_viewfinder,
                                size: 20.w,
                                color: UIColors.white50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      UIGap.h24,
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
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
                        child: sendTokenState is SendToken || (sendTicketState is SendTicket && sendTicketState.targetAddress != null)
                            ? AccountCardWidget(
                                address: _searchController.text,
                                onTap: () {
                                  if (sendTokenState is SendToken) {
                                    if (sendTokenState.senderAddress != sendTokenState.targetAddress) {
                                      if (widget.sendType == SendTypeEnum.coin) {
                                        navigationService.push(
                                          const SendTokenRoute(),
                                        );
                                      }
                                      return;
                                    }
                                    toastHelper.showError('Could not transfer to your self');
                                  } else {
                                    if (sendTicketState is SendTicket) {
                                      if (sendTicketState.senderAddress != sendTicketState.targetAddress) {
                                        navigationService.push(
                                          const SendTicketRoute(),
                                        );
                                        return;
                                      }
                                      toastHelper.showError('Could not transfer to your self');
                                    }
                                  }
                                },
                              )
                            : TabBar(
                                tabAlignment: TabAlignment.start,
                                labelColor: UIColors.white50,
                                unselectedLabelColor: UIColors.grey500,
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: UIColors.black400,
                                ),
                                isScrollable: true,
                                indicatorWeight: 1,
                                indicatorPadding: EdgeInsets.symmetric(vertical: 2.h),
                                labelPadding: EdgeInsets.only(right: 10.w),
                                dividerColor: Colors.transparent,
                                labelStyle: UITypographies.subtitleLarge(
                                  context,
                                  color: UIColors.black500,
                                  fontWeight: FontWeight.w600,
                                ),
                                unselectedLabelStyle: UITypographies.bodyLarge(
                                  context,
                                  color: UIColors.grey500,
                                ),
                                padding: EdgeInsets.zero,
                                tabs: [
                                  Tab(
                                    height: 42.h,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(99),
                                        border: _tabController.index != 0
                                            ? Border.all(
                                                color: UIColors.white50.withOpacity(0.15),
                                              )
                                            : null,
                                      ),
                                      child: const Text('My Account'),
                                    ),
                                  ),
                                  Tab(
                                    height: 42.h,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(99),
                                        border: _tabController.index != 1
                                            ? Border.all(
                                                color: UIColors.white50.withOpacity(0.15),
                                              )
                                            : null,
                                      ),
                                      child: const Text('Contacts'),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      if (state is WalletsLoadedState && _searchController.text.isEmpty) ...[
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              SingleChildScrollView(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Column(
                                    children: List.generate(
                                  state.wallets.length,
                                  (index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: SendItemWidget(
                                        icon: SvgConst.icWalletSend,
                                        title: 'Account ${index + 1}',
                                        subtitle: DynamicParsing(state.wallets[index].addresses?[0].address).shortedWalletAddress ?? '',
                                        iconSize: 20,
                                        onTap: () {
                                          if (widget.sendType == SendTypeEnum.coin) {
                                            if (senderAddress != state.wallets[index].addresses?[0].address) {
                                              BlocProvider.of<SendTokenCubit>(context).setTargetAndSenderAddress(
                                                senderAddress: senderAddress,
                                                targetAddress: state.wallets[index].addresses?[0].address ?? '',
                                              );
                                              navigationService.push(
                                                const SendTokenRoute(),
                                              );
                                            } else {
                                              toastHelper.showError('Could not transfer to same address');
                                            }
                                          } else {
                                            if (senderAddress != state.wallets[index].addresses?[0].address) {
                                              BlocProvider.of<SendTicketCubit>(context).setTargetAndSenderAddress(
                                                senderAddress: senderAddress,
                                                targetAddress: state.wallets[index].addresses?[0].address ?? '',
                                              );
                                              navigationService.push(
                                                const SendTicketRoute(),
                                              );
                                            } else {
                                              toastHelper.showError('Could not transfer to same address');
                                            }
                                          }
                                        },
                                      ),
                                    );
                                  },
                                )),
                              ),
                              SingleChildScrollView(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: const Column(
                                  children: [
                                    // SendItemWidget(
                                    //   icon: SvgConst.icTicket,
                                    //   title: 'Account 3',
                                    //   subtitle: '0x8f25a...5cccd',
                                    //   iconSize: 20,
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  );
                });
              }),
            ),
          ),
        );
      }),
    );
  }
}
