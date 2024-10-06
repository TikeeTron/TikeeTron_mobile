import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../core/routes/app_route.dart';
import '../../../my_wallet/presentation/widget/filter/filter_event_modal.dart';
import '../../../shared/presentation/event_card_widget.dart';
import '../../../shared/presentation/loading_page.dart';
import '../../../shared/presentation/my_ticket_qr_bottom_sheet.dart';
import '../../../wallet/data/model/wallet_model.dart';
import '../cubit/get_list_event_cubit.dart';
import '../widget/home_wallet_widget.dart';

class HomeExploreTabBarView extends StatefulWidget {
  final WalletModel walletData;
  final GetListEventCubit listEventCubit;
  const HomeExploreTabBarView({super.key, required this.walletData, required this.listEventCubit});

  @override
  State<HomeExploreTabBarView> createState() => _HomeExploreTabBarViewState();
}

class _HomeExploreTabBarViewState extends State<HomeExploreTabBarView> with TickerProviderStateMixin {
  late TabController _listEventTabController;
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
  final List<String> _listHomeTabs = [
    'My Event',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});

    _listEventTabController = TabController(vsync: this, length: 1 + widget.listEventCubit.tabLenght);
    _listHomeTabs.addAll(widget.listEventCubit.listCategory);
    super.initState();
  }

  @override
  void dispose() {
    _listEventTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GetListEventCubit, GetListEventState>(builder: (context, state) {
        if (state is! GetListEventLoadedState) {
          return const LoadingPage(opacity: 1);
        }
        final listEvent = state.listEvent?.data;
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                UIGap.size(h: 20.h),
                HomeWalletWidget(
                  walletBalance: widget.walletData.totalBalance ?? '0',
                  onGoToDetailWallet: () {
                    context.pushRoute(
                      MyWalletRoute(wallet: widget.walletData),
                    );
                  },
                  onReceive: () {
                    context.pushRoute(
                      ReceiveRoute(
                        walletAddress: widget.walletData.addresses?[0].address ?? '',
                      ),
                    );
                  },
                  onSend: () {
                    context.pushRoute(
                      const SendRoute(),
                    );
                  },
                ),
                UIGap.size(h: 20.h),
                TabBar(
                  tabAlignment: TabAlignment.start,
                  labelColor: Colors.black,
                  unselectedLabelColor: UIColors.grey500,
                  controller: _listEventTabController,
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
                  tabs: _listHomeTabs
                      .map(
                        (e) => Tab(
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
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
                UIGap.h20,
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
                UIGap.h20,
                UIDivider(
                  color: UIColors.white50.withOpacity(0.15),
                ),
                UIGap.h20,
                Expanded(
                  child: TabBarView(
                    controller: _listEventTabController,
                    children: [
                      // My Event View
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            0.w,
                            8.h,
                            0,
                            50.h,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                EventCardWidget(
                                  image: '',
                                  haveTicket: true,
                                  onTapMyTicket: () async {
                                    await ModalHelper.showModalBottomSheet(
                                      context,
                                      child: const MyTicketQrBottomSheet(ticketId: 'EVT20241025987'),
                                      isHasCloseButton: false,
                                      padding: EdgeInsets.zero,
                                    );
                                  },
                                  title: 'Ed Sheeran Live at Madison Square Garden',
                                  desc: 'Madison Square Garden, New York',
                                ),
                                EventCardWidget(
                                  image: '',
                                  haveTicket: true,
                                  onTapMyTicket: () {},
                                  title: 'Ed Sheeran Live at Madison Square Garden',
                                  desc: 'Madison Square Garden, New York',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                        _listHomeTabs.length - 1,
                        (index) {
                          final String currentCategory = _listHomeTabs[index + 1];

                          final filteredEvents = listEvent?.where((event) => event.category == currentCategory).toList() ?? [];

                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                0.w,
                                8.h,
                                0,
                                50.h,
                              ),
                              child: Column(
                                children: List.generate(
                                  filteredEvents.length,
                                  (eventIndex) {
                                    final event = filteredEvents[eventIndex];

                                    return EventCardWidget(
                                      image: event.banner ?? '',
                                      title: event.name ?? '',
                                      desc: event.location ?? '',
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                UIGap.size(h: 100.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
