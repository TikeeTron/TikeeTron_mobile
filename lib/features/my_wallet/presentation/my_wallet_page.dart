import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:blockies/blockies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/container/rounded_container.dart';
import '../../../common/components/empty_data/empty_data_widget.dart';
import '../../../common/components/svg/svg_ui.dart';
import '../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../core/injector/locator.dart';
import '../../wallet/data/model/wallet_model.dart';
import '../../wallet/domain/repository/wallet_core_repository.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import 'widget/filter/filter_event_modal.dart';
import 'widget/history_transaction_card_widget.dart';
import 'widget/menu_button.dart';

@RoutePage()
class MyWalletPage extends StatefulWidget {
  final WalletModel wallet;

  const MyWalletPage({super.key, required this.wallet});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _listEventType = [
    'Concerts',
    'Sports',
    'Theater',
    'Festivals',
    'Other',
  ];

  final List<String> _listEventDate = [
    'Today',
    'Last 7 Days',
    'Last 30 Days',
  ];

  final List<String> _listEventTime = [
    'Upcoming Events',
    'Past Events',
  ];

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
          'My Wallet',
          style: UITypographies.h4(
            context,
            color: UIColors.white50,
          ),
        ),
        trailing: BounceTap(
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
              CupertinoIcons.info_circle_fill,
              color: UIColors.white50,
              size: 20.w,
            ),
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
      child: BlocBuilder<ActiveWalletCubit, ActiveWalletState>(builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    UIGap.size(h: 20.h),
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
                            children: <Widget>[
                              RoundedContainer(
                                width: 28.w,
                                height: 28.w,
                                radius: 9999,
                                child: Blockies(
                                  seed: walletAddress,
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
                              Icon(
                                CupertinoIcons.chevron_down,
                                color: UIColors.white50,
                                size: 16.w,
                              ),
                              UIGap.w4,
                            ],
                          ),
                        ),
                      ],
                    ),
                    UIGap.size(h: 20.h),
                    Image.asset(
                      ImagesConst.networkTron,
                      width: 72.w,
                      height: 72.h,
                    ),
                    UIGap.size(h: 10.h),
                    Text(
                      '2.242,34 TRX',
                      style: UITypographies.h2(
                        context,
                      ),
                    ),
                    UIGap.size(h: 22.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MenuButton(
                            icon: SvgConst.icReceive,
                            title: 'Receive',
                            onTap: () {},
                          ),
                        ),
                        UIGap.w12,
                        Expanded(
                          child: MenuButton(
                            icon: SvgConst.icSend,
                            title: 'Send',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    UIGap.size(h: 22.h),
                    UIDivider(
                      color: UIColors.white50.withOpacity(0.15),
                    ),
                    UIGap.size(h: 22.h),
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      labelColor: Colors.black,
                      unselectedLabelColor: UIColors.grey500,
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        color: Colors.white,
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
                              border: Border.all(
                                color: UIColors.white50.withOpacity(0.15),
                              ),
                            ),
                            child: const Text('My Event'),
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
                              border: Border.all(
                                color: UIColors.white50.withOpacity(0.15),
                              ),
                            ),
                            child: const Text('Wallet Activity'),
                          ),
                        ),
                      ],
                    ),
                    UIGap.size(h: 20.h),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: UITextField(
                            preffixIcon: Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: const Icon(
                                CupertinoIcons.search,
                                color: UIColors.white50,
                              ),
                            ),
                            radius: 999,
                            hint: 'Search Event ...',
                          ),
                        ),
                        UIGap.w8,
                        BounceTap(
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
                              CupertinoIcons.arrow_up_to_line,
                              color: UIColors.white50,
                              size: 20.w,
                            ),
                          ),
                        ),
                        UIGap.w8,
                        BounceTap(
                          onTap: () async {
                            await ModalHelper.showModalBottomSheet(
                              context,
                              child: FilterEventModal(
                                listEventDate: _listEventDate,
                                listEventTime: _listEventTime,
                                listEventType: _listEventType,
                                onApplyFilter: () {},
                                onResetFilter: () {},
                                onSelectedEventType: (value) {},
                              ),
                              isHasCloseButton: false,
                              padding: EdgeInsets.zero,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: UIColors.grey200.withOpacity(0.24),
                            ),
                            child: SvgUI(
                              SvgConst.icFilter,
                              size: 20.w,
                              color: UIColors.white50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          const EmptyDataWidget(
                            image: IconsConst.icEmptyEvent,
                            title: 'No upcoming events',
                            desc: 'You haven’t purchased any tickets yet. Browse events and book your spot!',
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                UIDivider(
                                  color: UIColors.white50.withOpacity(0.15),
                                ),
                                UIGap.size(h: 20.h),
                                Text(
                                  'Today',
                                  style: UITypographies.bodyLarge(context),
                                ),
                                UIGap.size(h: 18.h),
                                HistoryTransactionCardWidget(
                                  type: HistoryTransactionType.send,
                                  address: shortedAddress,
                                  amount: '300',
                                ),
                                HistoryTransactionCardWidget(
                                  type: HistoryTransactionType.receive,
                                  address: shortedAddress,
                                  amount: '200',
                                ),
                              ],
                            ),
                          ),
                          // const EmptyDataWidget(
                          //   image: IconsConst.icEmptyActivity,
                          //   title: 'No upcoming events',
                          //   desc: 'You haven’t purchased any tickets yet. Browse events and book your spot!',
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  String get walletAddress {
    final address = locator<WalletCoreRepository>().getWalletAddress(
      wallet: widget.wallet,
    );

    return address;
  }

  String get shortedAddress {
    if (walletAddress.isNotEmpty) {
      return DynamicParsing(walletAddress).shortedWalletAddress!;
    }
    return '';
  }
}
