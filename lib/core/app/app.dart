import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/themes/cubit/theme_cubit.dart';
import '../../common/utils/extensions/object_parsing.dart';
import '../../common/utils/helpers/logger_helper.dart';
import '../../features/buy_ticket/presentation/cubit/buy_ticket_quoting_cubit.dart';
import '../../features/buy_ticket/presentation/cubit/confirm_buy_ticket_cubit.dart';
import '../../features/buy_ticket/presentation/cubit/get_list_event_ticket_cubit.dart';
import '../../features/home/presentation/cubit/ask_ai_cubit.dart';
import '../../features/home/presentation/cubit/get_list_event_cubit.dart';
import '../../features/home/presentation/cubit/get_list_user_ticket_cubit.dart';
import '../../features/send/presentation/cubit/send_token_cubit.dart';
import '../../features/send/presentation/cubit/send_token_quoting_cubit.dart';
import '../../features/send/presentation/cubit/ticket/send_ticket_cubit.dart';
import '../../features/send/presentation/cubit/ticket/send_ticket_quoting_cubit.dart';
import '../../features/shared/presentation/cubit/dashboard_cubit.dart';
import '../../features/shared/presentation/cubit/loading/fullscreen_loading_cubit.dart';
import '../../features/shared/presentation/cubit/pin/pin_cubit.dart';
import '../../features/shared/presentation/loading_page.dart';
import '../../features/shared/presentation/pin_page.dart';
import '../../features/wallet/data/repositories/source/local/wallet_local_repository.dart';
import '../../features/wallet/presentation/create_wallet/cubit/create_wallet_cubit.dart';
import '../../features/wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import '../../features/wallet/presentation/cubit/token_list/token_list_cubit.dart';
import '../../features/wallet/presentation/cubit/wallets/wallets_cubit.dart';
import '../../features/wallet/presentation/import_wallet/cubit/import_wallet_cubit.dart';
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
        BlocProvider(
          create: (_) => locator<FullScreenLoadingCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<ImportWalletCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<SendTokenQuotingCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<SendTokenCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<GetListEventCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<AskAiCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<GetListUserTicketCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<GetListEventTicketCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<ConfirmBuyTicketCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<BuyTicketQuotingCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<SendTicketCubit>(),
        ),
        BlocProvider(
          create: (_) => locator<SendTicketQuotingCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<PinCubit>(),
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
                debugShowCheckedModeBanner: false,
                title: 'TikeeTron',
                localizationsDelegates: const [
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                ],
                theme: state.cupertinoThemeData,
                routerConfig: _appRouter.config(),
                builder: (context, child) {
                  return Stack(
                    children: <Widget>[
                      if (child != null) ...[
                        child,
                      ],
                      BlocBuilder<FullScreenLoadingCubit, FullscreenLoadingState>(
                        builder: (context, state) {
                          if (state is ShowFullScreenLoading) {
                            return LoadingPage(
                              opacity: 1,
                              title: state.title,
                              subtitle: state.subtitle,
                            );
                          }

                          return const LoadingPage(
                            opacity: 0,
                          );
                        },
                      ),
                      BlocBuilder<PinCubit, PinState>(
                        builder: (context, state) {
                          if (state is ShowPin) {
                            return PinPage(
                              passedData: state.passedData,
                              noCancel: state.noCancel,
                              isSetBiometric: state.isSetBiometric,
                              initShowBiometric: state.initShowBiometric,
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
