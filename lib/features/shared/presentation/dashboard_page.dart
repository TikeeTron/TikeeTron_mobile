import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:blockies/blockies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/common.dart';
import '../../../common/components/container/rounded_container.dart';
import '../../../common/components/dialogs/confirmation_alert_widget.dart';
import '../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../core/adapters/blockchain_network_adapter.dart';
import '../../../core/core.dart';
import '../../../core/injector/locator.dart';
import '../../home/presentation/home_page.dart';
import '../../wallet/domain/repository/wallet_core_repository.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import 'cubit/dashboard_cubit.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: HomePage(),
          ),
          Positioned.fill(
            child: _SideMenuWidget(),
          ),
        ],
      ),
    );
  }
}

class _SideMenuWidget extends StatelessWidget {
  const _SideMenuWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, bool>(
      builder: (context, state) {
        return Stack(
          children: [
            _blurBackground(context, state),
            _drawer(context, state),
          ],
        );
      },
    );
  }

  Widget _drawer(BuildContext context, bool _isVisible) {
    return AnimatedPositioned(
      duration: DurationConst.iosFast,
      curve: AnimationsConst.curveComponent,
      top: 0.0,
      bottom: 0.0,
      left: _isVisible ? 0.0 : -(ScreenUtil().screenWidth / 4) * 3,
      child: Container(
        width: (ScreenUtil().screenWidth / 4) * 3,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        color: context.theme.colors.backgroundPrimary,
        child: BlocBuilder<ActiveWalletCubit, ActiveWalletState>(builder: (context, state) {
          String? address;
          String? shortedAddress;
          if (state.wallet != null) {
            address = locator<WalletCoreRepository>().getWalletAddress(
              wallet: state.wallet!,
            );
            if (address.isNotEmpty) {
              shortedAddress = DynamicParsing(address).shortedWalletAddress!;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIGap.size(
                h: ScreenUtil().statusBarHeight,
              ),
              UIGap.h20,
              _itemMenu(
                context,
                title: 'Wallet',
                icon: IconsConst.menuWallet,
                onTap: () {
                  context.read<DashboardCubit>().hideDrawer();
                },
              ),
              UIGap.h8,
              _itemMenu(
                context,
                title: 'Contacts',
                icon: IconsConst.menuRecipients,
                onTap: () {},
              ),
              UIGap.h8,
              _itemMenu(
                context,
                title: 'Settings',
                icon: IconsConst.menuSetting,
                onTap: () {
                  context.read<DashboardCubit>().hideDrawer();
                },
              ),
              const Spacer(),
              UIScaleButton(
                onTap: () async {
                  if (state.wallet != null) {
                    final confirm = await ModalHelper.showModalBottomSheet(
                      context,
                      padding: EdgeInsets.zero,
                      child: const ConfirmationAlertWidget(
                        title: "Are you sure?",
                        description: "Your current Wallet will be deleted from this device.",
                      ),
                    );
                    if (confirm) {
                      // get wallet address
                      final walletAddress = locator<WalletCoreRepository>().getWalletAddress(
                        wallet: state.wallet!,
                        blockchain: BlockchainNetwork.tron,
                      );

                      // delete wallet
                      await locator<WalletCoreRepository>().deleteWallet(
                        walletIndex: state.walletIndex ?? 0,
                        walletAddress: walletAddress,
                      );
                      context.read<DashboardCubit>().hideDrawer();
                      navigationService.pushAndPopUntil(
                        const OnBoardingRoute(),
                        predicate: (p0) => false,
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.colors.backgroundTertiary,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.all(12.r),
                  child: Row(
                    children: [
                      RoundedContainer(
                        width: 40.w,
                        height: 40.w,
                        radius: 9999,
                        child: Blockies(
                          seed: address ?? '0xff',
                        ),
                      ),
                      UIGap.w8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              state.wallet?.name ?? '',
                              style: UITypographies.subtitleLarge(context),
                            ),
                            UIGap.h4,
                            Text(
                              shortedAddress ?? '',
                              style: UITypographies.bodySmall(context),
                            ),
                          ],
                        ),
                      ),
                      UIGap.w8,
                      SvgPicture.asset(
                        IconsConst.logout,
                        height: 20.r,
                        width: 20.r,
                      ),
                    ],
                  ),
                ),
              ),
              UIGap.h8,
            ],
          );
        }),
      ),
    );
  }

  UIScaleButton _itemMenu(
    BuildContext context, {
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return UIScaleButton(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 20.r,
              width: 20.r,
              colorFilter: ColorFilter.mode(
                context.theme.colors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            UIGap.w8,
            Expanded(
              child: Text(
                title,
                style: UITypographies.subtitleMedium(context).copyWith(
                  color: context.theme.colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blurBackground(BuildContext context, bool isVisible) {
    return Visibility(
      visible: isVisible,
      maintainAnimation: true,
      maintainState: true,
      child: InkWell(
        onTap: () {
          context.read<DashboardCubit>().hideDrawer();
        },
        child: AnimatedOpacity(
          duration: DurationConst.iosFast,
          curve: AnimationsConst.curveComponent,
          opacity: isVisible ? 1 : 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: UIColors.black400.withOpacity(.32),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardMenu extends Equatable {
  final String title;
  final String icon;
  final PageRouteInfo<dynamic> route;

  const _DashboardMenu({
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  List<Object?> get props => [title, icon, route];
}
