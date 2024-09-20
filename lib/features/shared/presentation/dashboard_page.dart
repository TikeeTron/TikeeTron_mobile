import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/components/components.dart';
import '../../../../common/constants/animation_const.dart';
import '../../../../common/constants/assets_const.dart';
import '../../../../common/constants/durations_const.dart';
import '../../../../common/themes/colors.dart';
import '../../../../common/themes/typographies.dart';
import '../../../../common/utils/extensions/theme_extension.dart';
import '../../home/presentation/home_page.dart';
import 'cubit/dashboard_cubit.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Column(
              children: [
                const Expanded(
                  child: HomePage(),
                ),
                _BottomNavigationWidget(
                  controller: _chatController,
                ),
              ],
            ),
          ),
          const Positioned.fill(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIGap.size(
              h: ScreenUtil().statusBarHeight,
            ),
            SvgPicture.asset(
              IconsConst.logoFull,
              height: 45.h,
              width: 112.w,
            ),
            UIGap.h20,
            _itemMenu(
              context,
              title: 'Wallet',
              icon: IconsConst.menuWallet,
              onTap: () {
                context.read<DashboardCubit>().hideDrawer();
                // navigationService.push(
                //   const ManageWalletRoute(),
                // );
              },
            ),
            UIGap.h8,
            _itemMenu(
              context,
              title: 'Recipients',
              icon: IconsConst.menuRecipients,
              onTap: () {},
            ),
            UIGap.h8,
            _itemMenu(
              context,
              title: 'Business',
              icon: IconsConst.menuBusiness,
              onTap: () {
                context.read<DashboardCubit>().hideDrawer();
                // navigationService.push(
                //   const BusinessUpgradeRoute(),
                // );
              },
            ),
            UIGap.h8,
            _itemMenu(
              context,
              title: 'Check Wallet',
              icon: IconsConst.menuCheck,
              onTap: () {},
            ),
            UIGap.h8,
            _itemMenu(
              context,
              title: 'Settings',
              icon: IconsConst.menuSetting,
              onTap: () {
                context.read<DashboardCubit>().hideDrawer();
                // navigationService.push(
                //   const SettingRoute(),
                // );
              },
            ),
            const Spacer(),
            UIScaleButton(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: context.theme.colors.backgroundTertiary,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(12.r),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.network(
                        'https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109?s=100',
                        width: 40.r,
                        height: 40.r,
                      ),
                    ),
                    UIGap.w8,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'John Doe',
                            style: UITypographies.subtitleLarge(context),
                          ),
                          UIGap.h4,
                          Text(
                            'john.doe@gmail.com',
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
        ),
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

class _BottomNavigationWidget extends StatelessWidget {
  const _BottomNavigationWidget({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIColors.black500,
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 40.h,
        left: 16.w,
        right: 16.w,
      ),
      child: UITextField(
        textController: controller,
        fillColor: UIColors.black400,
        borderColor: UIColors.white50.withOpacity(0.15),
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
