import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../core/routes/app_route.dart';
import '../../../shared/presentation/event_card_widget.dart';
import '../../../wallet/data/model/wallet_model.dart';
import '../widget/home_wallet_widget.dart';

class HomeExploreTabBarView extends StatefulWidget {
  final WalletModel walletData;
  const HomeExploreTabBarView({super.key, required this.walletData});

  @override
  State<HomeExploreTabBarView> createState() => _HomeExploreTabBarViewState();
}

class _HomeExploreTabBarViewState extends State<HomeExploreTabBarView> with TickerProviderStateMixin {
  late TabController _listEventTabController;

  final List<String> _listHomeTabs = [
    'My Event',
    'For You',
    'Concert',
    'Festival',
    'Sports',
  ];

  @override
  void initState() {
    _listEventTabController = TabController(vsync: this, length: 5);

    _listEventTabController.addListener(() {});

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
      bottom: false,
      child: SingleChildScrollView(
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
                padding: Paddings.defaultPaddingH,
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
              UIGap.size(h: 12.h),
              Expanded(
                child: TabBarView(
                  controller: _listEventTabController,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          26.w,
                          8.h,
                          17.w,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Concerts You Might Like',
                              style: UITypographies.subtitleLarge(
                                context,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: const SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      EventCardWidget(
                                        image: '',
                                        haveTicket: false,
                                        title: 'Ed Sheeran Live at Madison Square Garden',
                                        desc: 'Madison Square Garden, New York',
                                      ),
                                      EventCardWidget(
                                        image: '',
                                        haveTicket: false,
                                        title: 'Ed Sheeran Live at Madison Square Garden',
                                        desc: 'Madison Square Garden, New York',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            UIGap.h20,
                            Text(
                              'Concerts You Might Like',
                              style: UITypographies.subtitleLarge(
                                context,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: const SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      EventCardWidget(
                                        image: '',
                                        haveTicket: false,
                                        title: 'Ed Sheeran Live at Madison Square Garden',
                                        desc: 'Madison Square Garden, New York',
                                      ),
                                      EventCardWidget(
                                        image: '',
                                        haveTicket: false,
                                        title: 'Ed Sheeran Live at Madison Square Garden',
                                        desc: 'Madison Square Garden, New York',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          26.w,
                          8.h,
                          17.w,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Concerts You Might Like',
                              style: UITypographies.subtitleLarge(
                                context,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: const SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      EventCardWidget(
                                        image: '',
                                        title: 'Ed Sheeran Live at Madison Square Garden',
                                        desc: 'Madison Square Garden, New York',
                                      ),
                                      EventCardWidget(
                                        image: '',
                                        title: 'Ed Sheeran Live at Madison Square Garden',
                                        desc: 'Madison Square Garden, New York',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const EventCardWidget(
                      image: '',
                      title: 'Ed Sheeran Live at Madison Square Garden',
                      desc: 'Madison Square Garden, New York',
                    ),
                    const EventCardWidget(
                      image: '',
                      title: 'Ed Sheeran Live at Madison Square Garden',
                      desc: 'Madison Square Garden, New York',
                    ),
                    const EventCardWidget(
                      image: '',
                      title: 'Ed Sheeran Live at Madison Square Garden',
                      desc: 'Madison Square Garden, New York',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
