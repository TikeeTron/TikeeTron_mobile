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
import '../../../core/core.dart';
import '../../../core/injector/injector.dart';
import '../../shared/presentation/loading_page.dart';
import '../../wallet/domain/repository/wallet_core_repository.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import '../../wallet/presentation/cubit/wallets/wallets_cubit.dart';
import 'cubit/get_list_event_cubit.dart';
import 'cubit/get_list_user_ticket_cubit.dart';
import 'view/home_chat_tab_bar_view.dart';
import 'view/home_explore_tab_bar_view.dart';
import 'widget/account_modal.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _appBarTabController;
  late GetListEventCubit getListEventCubit;
  late GetListUserTicketCubit getListTicketCubit;

  @override
  void initState() {
    _appBarTabController = TabController(vsync: this, length: 2);
    getListEventCubit = BlocProvider.of<GetListEventCubit>(context);
    getListTicketCubit = BlocProvider.of<GetListUserTicketCubit>(context);
    final activeWalletCubit = BlocProvider.of<ActiveWalletCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final activeWallet = activeWalletCubit.getActiveWallet();
      if (activeWallet != null) {
        final walletAddress = locator<WalletCoreRepository>().getWalletAddress(
          wallet: activeWallet,
        );
        activeWalletCubit.getWalletBalance(
          walletAddress: walletAddress,
          walletIndex: activeWalletCubit.state.walletIndex ?? 0,
        );
        await getListEventCubit.getListEvent();
        await getListTicketCubit.getListUserTicket(walletAddress: walletAddress);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _appBarTabController.dispose();
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
            middle: Material(
              color: Colors.transparent,
              child: Container(
                width: 170.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UIColors.white50.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Center(
                  child: TabBar(
                    controller: _appBarTabController,
                    dividerColor: Colors.transparent,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: UIColors.primary400,
                    unselectedLabelColor: UIColors.white50,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: UIColors.primary900,
                    ),
                    labelStyle: UITypographies.subtitleLarge(
                      context,
                    ),
                    unselectedLabelStyle: UITypographies.bodyLarge(
                      context,
                    ),
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      const Tab(
                        text: 'Chat',
                      ),
                      const Tab(
                        text: 'Explore',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            trailing: BounceTap(
              onTap: () => navigationService.push(const NotificationRoute()),
              child: Icon(
                CupertinoIcons.bell_solid,
                color: UIColors.white50,
                size: 22.w,
              ),
            ),
            leading: BounceTap(
              onTap: () {
                final walletsCubit = BlocProvider.of<WalletsCubit>(context);
                final listWallet = walletsCubit.getWallets();
                ModalHelper.showModalBottomSheet(
                  context,
                  child: AccountModal(
                    onAddWallet: () {
                      navigationService.push(const AddMoreWalletRoute());
                    },
                    listWallet: listWallet,
                    activeWallet: state.wallet!,
                  ),
                  isHasCloseButton: false,
                  padding: EdgeInsets.zero,
                );
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UIColors.white50.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RoundedContainer(
                      width: 35.w,
                      height: 40.h,
                      radius: 9999,
                      child: Blockies(
                        seed: state.wallet?.addresses?[0].address ?? '0xf',
                      ),
                    ),
                    UIGap.w4,
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 20.w,
                      color: UIColors.white50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: TabBarView(
              controller: _appBarTabController,
              children: [
                const HomeChatTabBarView(),
                state.wallet != null
                    ? HomeExploreTabBarView(
                        walletData: state.wallet!,
                        listEventCubit: getListEventCubit,
                      )
                    : const LoadingPage(
                        opacity: 1,
                        title: 'Loading Event Data',
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
