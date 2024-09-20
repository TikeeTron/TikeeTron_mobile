import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/svg/svg_ui.dart';
import '../../../common/config/padding_config.dart';
import '../../shared/presentation/cubit/cubit.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: CupertinoPageScaffold(
        backgroundColor: UIColors.black500,
        navigationBar: ScaffoldAppBar.cupertino(
          context,
          middle: Container(
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
        child: BlocBuilder<ActiveWalletCubit, ActiveWalletState>(builder: (context, state) {
          log('${state.wallet?.addresses.toString()}');
          return SafeArea(
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
                    width: 64.w,
                    height: 64.h,
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
                    dividerColor: Colors.transparent,
                    // labelStyle: GoogleFonts.poppins(
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    padding: Paddings.defaultPaddingH,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                        child: Tab(
                          //text: "Crypto",
                          height: 22,
                          child: Text('Crypto'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        child: Tab(
                          height: 22,
                          child: Text('NFT'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        child: Tab(
                          height: 22,
                          child: Text('Transactions'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomNavigationWidget extends StatelessWidget {
  const _BottomNavigationWidget({
    required this.menus,
    required this.controller,
  });

  final List<_DashboardMenu> menus;
  final TabController controller;

  int get activeIndex => controller.index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colors.backgroundSecondary,
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 24.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: menus
            .asMap()
            .map(
              (index, menu) {
                bool isActive = activeIndex == index;

                return MapEntry(
                  index,
                  Expanded(
                    child: Text(
                      menu.title,
                      style: UITypographies.h2(
                        context,
                        fontSize: 28.sp,
                      ),
                    ),
                  ),
                );
              },
            )
            .values
            .toList(),
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
