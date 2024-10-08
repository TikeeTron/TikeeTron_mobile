import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/empty_data/empty_data_widget.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/utils/extensions/string_parsing.dart';
import '../../../../core/routes/app_route.dart';
import '../../../buy_ticket/data/model/entity/event_detail_entity.dart';
import '../../../my_wallet/presentation/widget/filter/filter_event_modal.dart';
import '../../../shared/presentation/event_card_widget.dart';
import '../../../shared/presentation/loading_page.dart';
import '../../../shared/presentation/my_ticket_qr_bottom_sheet.dart';
import '../../../wallet/data/model/wallet_model.dart';
import '../../data/model/response/get_list_event_response.dart';
import '../../data/model/response/get_list_ticket_response.dart';
import '../cubit/get_list_event_cubit.dart';
import '../cubit/get_list_user_ticket_cubit.dart';
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
  TextEditingController _searchController = TextEditingController();
  List<TicketDetails> listSearchMyEvent = [];
  List<Datum>? listSearchEvent = [];

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
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: BlocBuilder<GetListEventCubit, GetListEventState>(builder: (context, eventState) {
          if (eventState is! GetListEventLoadedState) {
            return const LoadingPage(opacity: 1);
          }
          final listEvent = eventState.listEvent?.data;

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<GetListUserTicketCubit, GetListUserTicketState>(builder: (context, ticketState) {
              if (ticketState is! GetListUserTicketLoadedState) {
                return const LoadingPage(opacity: 1);
              }
              if (_searchController.text.isEmpty) {
                listSearchMyEvent = ticketState.listTicket?.data ?? [];
              }

              return Column(
                children: <Widget>[
                  UIGap.size(h: 20.h),
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: HomeWalletWidget(
                      walletBalance: widget.walletData.totalBalance ?? '0',
                      onGoToDetailWallet: () {
                        navigationService.push(
                          MyWalletRoute(wallet: widget.walletData),
                        );
                      },
                      onReceive: () {
                        navigationService.push(
                          ReceiveRoute(
                            walletAddress: widget.walletData.addresses?[0].address ?? '',
                          ),
                        );
                      },
                      onSend: () {
                        navigationService.push(
                          const SendRoute(),
                        );
                      },
                    ),
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
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                border: Border.all(
                                  color: UIColors.white50.withOpacity(0.15),
                                ),
                              ),
                              child: Center(child: Text(e)),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  UIGap.h20,
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: UITextField(
                            textController: _searchController,
                            onChanged: (value) {
                              setState(() {
                                listSearchMyEvent = listSearchMyEvent.where(
                                  (element) {
                                    return (element.event?.name?.toLowerCase().contains(value.toLowerCase()) ?? false) ||
                                        (element.event?.location?.toLowerCase().contains(value.toLowerCase()) ?? false);
                                  },
                                ).toList();
                                listSearchEvent = listSearchEvent?.where(
                                  (element) {
                                    return (element.name?.toLowerCase().contains(value.toLowerCase()) ?? false) ||
                                        (element.location?.toLowerCase().contains(value.toLowerCase()) ?? false);
                                  },
                                ).toList();
                              });
                            },
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
                  ),
                  UIGap.h20,
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: UIDivider(
                      color: UIColors.white50.withOpacity(0.15),
                    ),
                  ),
                  UIGap.h20,
                  Expanded(
                    child: TabBarView(
                      controller: _listEventTabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // My Event View

                        RefreshIndicator(
                          color: UIColors.primary500,
                          onRefresh: () async {
                            await BlocProvider.of<GetListUserTicketCubit>(context).getListUserTicket(walletAddress: widget.walletData.addresses?[0].address ?? '');
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(
                              8.w,
                              8.h,
                              8.w,
                              50.h,
                            ),
                            child: Column(
                              children: ticketState.listTicket?.data == null || ticketState.listTicket?.data?.length == 0
                                  ? [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: const EmptyDataWidget(
                                          image: IconsConst.icEmptyEvent,
                                          title: 'No upcoming events',
                                          desc: 'You haven’t purchased any tickets yet. Browse events and book your spot!',
                                        ),
                                      ),
                                    ]
                                  : List.generate(
                                      _searchController.text.isNotEmpty ? listSearchMyEvent.length : ticketState.listTicket?.data?.length ?? 0,
                                      (index) {
                                        int? ticketId;
                                        Event? eventData;
                                        bool? isTicketUsed;
                                        String? ticketType;

                                        if (_searchController.text.isNotEmpty) {
                                          eventData = listSearchMyEvent[index].event;
                                          ticketId = listSearchMyEvent[index].ticketId;
                                          isTicketUsed = listSearchMyEvent[index].isUsed;
                                          ticketType = listSearchMyEvent[index].type;
                                        } else {
                                          eventData = ticketState.listTicket?.data?[index].event;
                                          ticketId = ticketState.listTicket?.data?[index].ticketId;
                                          isTicketUsed = ticketState.listTicket?.data?[index].isUsed;
                                          ticketType = ticketState.listTicket?.data?[index].type;
                                        }

                                        return EventCardWidget(
                                          image: eventData?.banner ?? '',
                                          isTicketUsed: isTicketUsed ?? false,
                                          ticketType: ticketType,
                                          haveTicket: true,
                                          onTapDetail: () {
                                            navigationService.push(
                                              DetailEventRoute(
                                                eventData: EventDetailEntity.fromJson(
                                                  eventData!.toJson(),
                                                ),
                                              ),
                                            );
                                          },
                                          onTapMyTicket: () async {
                                            await ModalHelper.showModalBottomSheet(
                                              context,
                                              child: MyTicketQrBottomSheet(
                                                ticketId: ticketId.toString(),
                                              ),
                                              isHasCloseButton: false,
                                              padding: EdgeInsets.zero,
                                            );
                                          },
                                          title: eventData?.name ?? '',
                                          desc: eventData?.location ?? '',
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        ...List.generate(
                          _listHomeTabs.length - 1,
                          (index) {
                            final String currentCategory = _listHomeTabs[index + 1];

                            final filteredEvents = listEvent?.where((event) => event.category == currentCategory).toList() ?? [];
                            if (_searchController.text.isEmpty) {
                              listSearchEvent = filteredEvents;
                            }
                            return RefreshIndicator(
                              color: UIColors.primary500,
                              onRefresh: () async {
                                await BlocProvider.of<GetListEventCubit>(context).getListEvent();
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    8.w,
                                    8.h,
                                    8.w,
                                    50.h,
                                  ),
                                  child: Column(
                                    children: List.generate(
                                      _searchController.text.isNotEmpty ? listSearchEvent?.length ?? 0 : filteredEvents.length,
                                      (eventIndex) {
                                        Datum? event;
                                        int? lowestPrice;
                                        if (_searchController.text.isNotEmpty) {
                                          event = listSearchEvent?[eventIndex];
                                          lowestPrice = event?.ticketTypes?.map((e) => e.price).reduce(
                                                (value, element) => (element ?? 0) < (value ?? 0) ? element : value,
                                              );
                                        } else {
                                          event = filteredEvents[eventIndex];
                                          lowestPrice = event.ticketTypes?.map((e) => e.price).reduce(
                                                (value, element) => (element ?? 0) < (value ?? 0) ? element : value,
                                              );
                                        }

                                        return EventCardWidget(
                                          image: event?.banner ?? '',
                                          title: event?.name ?? '',
                                          onTapDetail: () {
                                            navigationService.push(
                                              DetailEventRoute(
                                                eventData: EventDetailEntity.fromJson(
                                                  event?.toJson() ?? {},
                                                ),
                                              ),
                                            );
                                          },
                                          estimatePrice: lowestPrice.toString().amountInWeiToToken(
                                                decimals: 6,
                                                fractionDigits: (lowestPrice ?? 0) > 1 ? 2 : 4,
                                              ),
                                          desc: event?.location ?? '',
                                        );
                                      },
                                    ),
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
              );
            }),
          );
        }),
      ),
    );
  }
}
