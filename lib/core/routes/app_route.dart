import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import '../../features/create_wallet/presentation/create_wallet_page.dart';
import '../../features/create_wallet/presentation/success_create_wallet_page.dart';
import '../../features/on_boarding/on_boarding_page.dart';
import '../injector/locator.dart';
import '../services/navigation_service.dart';

part 'app_route.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<CupertinoRoute> get routes => [
        CupertinoRoute(
          page: OnBoardingRoute.page,
          initial: true,
        ),
        CupertinoRoute(
          page: CreateWalletRoute.page,
        ),
        CupertinoRoute(
          page: SuccessCreateWalletRoute.page,
        ),
        // CupertinoRoute(page: LoginRoute.page),
        // CupertinoRoute(page: ForgotPasswordRoute.page),
        // CupertinoRoute(page: RegisterRoute.page),
        // CupertinoRoute(
        //   page: DashboardRoute.page,
        //   initial: true,
        //   children: [
        //     CupertinoRoute(page: HomeRoute.page),
        //     CupertinoRoute(page: TransactionRoute.page),
        //     CupertinoRoute(page: HomeRoute.page),
        //     CupertinoRoute(page: HomeRoute.page),
        //     CupertinoRoute(page: HomeRoute.page),
        //   ],
        // ),
      ];
}

final NavigationService navigationService = locator<NavigationService>();

final BuildContext globalContext = navigationService.currentContext!;
