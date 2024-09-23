import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/svg/svg_ui.dart';
import '../../../common/config/padding_config.dart';
import '../../../core/core.dart';
import '../../shared/presentation/cubit/cubit.dart';
import '../../shared/presentation/event_card_widget.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chatController = TextEditingController();

  final List<String> _listHomeTabs = [
    'My Event',
    'For You',
    'Concert',
    'Festival',
    'Sports',
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 5);
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
    return BlocBuilder<ActiveWalletCubit, ActiveWalletState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          backgroundColor: UIColors.black500,
          navigationBar: ScaffoldAppBar.cupertino(
            context,
            middle: BounceTap(
              onTap: () => context.pushRoute(
                MyWalletRoute(
                  wallet: state.wallet!,
                ),
              ),
              child: Container(
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
                    UIGap.h4,
                    Text(
                      '2.000 TRX',
                      style: UITypographies.bodyLarge(
                        context,
                        fontWeight: FontWeight.w600,
                        color: UIColors.green400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            trailing: Icon(
              CupertinoIcons.bell_solid,
              color: UIColors.white50,
              size: 22.w,
            ),
            leading: BounceTap(
              onTap: () {
                context.read<DashboardCubit>().showDrawer();
              },
              child: SvgUI(
                SvgConst.drawer,
                color: UIColors.white50,
                width: 16.w,
                height: 16.w,
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          UIGap.size(h: 20.h),
                          Text(
                            'Welcome, Dani',
                            style: UITypographies.h2(
                              context,
                              fontSize: 28.sp,
                            ),
                          ),
                          UIGap.size(h: 30.h),
                          SvgUI(
                            SvgConst.icAiHome,
                            width: 54.w,
                            height: 54.h,
                          ),
                          UIGap.size(h: 30.h),
                          Text(
                            'Get started with tikeetron',
                            style: UITypographies.h4(
                              context,
                            ),
                          ),
                          UIGap.size(h: 4.h),
                          Text(
                            'Ask anything about events, tickets, or more.',
                            style: UITypographies.bodyLarge(
                              context,
                              color: UIColors.grey500,
                            ),
                          ),
                          UIGap.size(h: 32.h),
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
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 20.w),
                                            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 7.h),
                                            decoration: BoxDecoration(
                                              color: UIColors.black400,
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              'IN 2D',
                                              style: UITypographies.bodySmall(
                                                context,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const EventCardWidget(
                                            image: '',
                                            title: 'Ed Sheeran Live at Madison Square Garden',
                                            desc: 'Madison Square Garden, New York 24th September 2024, 8:00 PM',
                                          ),
                                        ],
                                      ),
                                    ],
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
                ),
                Positioned(
                  bottom: 0,
                  child: _BottomNavigationWidget(controller: _chatController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BottomNavigationWidget extends StatelessWidget {
  const _BottomNavigationWidget({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 96.h,
      color: UIColors.black500,
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 30.h,
        left: 16.w,
        right: 16.w,
      ),
      child: UITextField(
        textController: controller,
        radius: 99.r,
        hint: 'Chat with Tibot...',
        suffixIcon: const Icon(Icons.mic),
        hintColor: UIColors.white50.withOpacity(0.4),
        fillColor: UIColors.black400,
        borderColor: UIColors.white50.withOpacity(0.15),
      ),
    );
  }
}

class _DashboardMenu extends Equatable {
  final String title;

  final PageRouteInfo<dynamic> route;

  const _DashboardMenu({
    required this.title,
    required this.route,
  });

  @override
  List<Object?> get props => [title, route];
}
