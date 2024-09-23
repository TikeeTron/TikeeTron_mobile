import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/themes/cubit/theme_cubit.dart';
import '../../common/utils/extensions/object_parsing.dart';
import '../../common/utils/helpers/logger_helper.dart';
import '../../features/shared/presentation/cubit/dashboard_cubit.dart';
import '../../features/wallet/data/repositories/source/local/wallet_local_repository.dart';
import '../../features/wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import '../../features/wallet/presentation/cubit/create_wallet_cubit.dart';
import '../../features/wallet/presentation/cubit/token_list/token_list_cubit.dart';
import '../../features/wallet/presentation/cubit/wallets/wallets_cubit.dart';
import '../injector/locator.dart';
import '../routes/app_route.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  Widget get _view {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<CreateWalletCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<ActiveWalletCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<WalletsCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<TokenListCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<DashboardCubit>(),
        ),
      ],
      child: _AppView(
        key: key,
      ),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({
    super.key,
  });

  @override
  State<_AppView> createState() => __AppViewState();
}

class __AppViewState extends State<_AppView> {
  final _appRouter = locator<AppRouter>();

  @override
  void initState() {
    super.initState();

    context.read<ThemeCubit>().initBrightnessSystem();

    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      final brightness = PlatformDispatcher.instance.platformBrightness;

      context.read<ThemeCubit>().setBrightness(brightness);
    };
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _init();
      },
    );
  }

  Future<void> _onGoToPage({
    required dynamic route,
  }) async {
    // go to [pagePath] page
    navigationService.pushAndPopUntil(
      route,
      predicate: (route) => false,
    );
  }

  Future<void> _init() async {
    try {
      // check wallets is empty
      final wallets = locator<WalletLocalRepository>().getAll();
      if (wallets == null || wallets.isEmpty) {
        // go to onboarding page
        await _onGoToPage(
          route: const OnBoardingRoute(),
        );
        await Future.delayed(const Duration(seconds: 2), () {
          FlutterNativeSplash.remove();
        });
        return;
      }

      // set & get active wallet
      BlocProvider.of<ActiveWalletCubit>(context).getActiveWallet();
      final walletIndex = BlocProvider.of<ActiveWalletCubit>(context).state.walletIndex;
      if (walletIndex == null) {
        // go to onboarding page
        await _onGoToPage(
          route: const OnBoardingRoute(),
        );
        await Future.delayed(const Duration(seconds: 2), () {
          FlutterNativeSplash.remove();
        });
        return;
      }

      // get tokens price
      // BlocProvider.of<TokenListCubit>(context).getTokenBalances(
      //   walletIndex: walletIndex,
      // );
      await Future.delayed(const Duration(seconds: 2), () {
        FlutterNativeSplash.remove();
      });
      // go to main page
      await _onGoToPage(
        route: const DashboardRoute(),
      );
    } catch (error) {
      Logger.error(error.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Theme(
              data: state.materialThemeData,
              child: CupertinoApp.router(
                builder: FToastBuilder(),
                debugShowCheckedModeBanner: false,
                title: 'TikeeTron',
                localizationsDelegates: const [
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                ],
                theme: state.cupertinoThemeData,
                routerConfig: _appRouter.config(),
              ),
            );
          },
        );
      },
    );
  }
}
