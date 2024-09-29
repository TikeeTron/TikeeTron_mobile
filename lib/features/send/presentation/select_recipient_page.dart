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
class SelectRecipientPage extends StatefulWidget {
  final SendTypeEnum sendType;
  const SelectRecipientPage({super.key, required this.sendType});

  @override
  State<SelectRecipientPage> createState() => _SelectRecipientPageState();
}

class _SelectRecipientPageState extends State<SelectRecipientPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      child: SafeArea(
        child: Padding(
          padding: Paddings.defaultPaddingH,
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIGap.h24,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: UITextField(
                        radius: 999,
                        suffixWidth: 70.w,
                        hint: 'Search Address ...',
                        suffixIcon: Container(
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
                    UIGap.w8,
                    Container(
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
                  ],
                ),
                UIGap.h20,
                TabBar(
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
                        child: const Text('Account'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Column(
                        children: [
                          SendItemWidget(
                            icon: SvgConst.icWalletSend,
                            title: 'Account 2',
                            subtitle: '0x8f25a...5cccd',
                            iconSize: 20,
                            onTap: () {
                              if (widget.sendType == SendTypeEnum.coin) {
                                context.pushRoute(
                                  SendTokenRoute(walletAddress: '0xfadawdasffas'),
                                );
                              } else {
                                context.pushRoute(
                                  SendTicketRoute(walletAddress: '0xfadawdasffas'),
                                );
                              }
                            },
                          ),
                          UIGap.h12,
                          SendItemWidget(
                            icon: SvgConst.icWalletSend,
                            title: 'Account 3',
                            subtitle: '0x8f25a...5cccd',
                            iconSize: 20,
                            onTap: () {
                              if (widget.sendType == SendTypeEnum.coin) {
                                context.pushRoute(
                                  SendTokenRoute(walletAddress: '0xfadawdasffas'),
                                );
                              } else {
                                context.pushRoute(
                                  SendTicketRoute(walletAddress: '0xfadawdasffas'),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const Column(
                        children: [
                          SendItemWidget(
                            icon: SvgConst.icTicket,
                            title: 'Account 3',
                            subtitle: '0x8f25a...5cccd',
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
