import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../features/home/presentation/home_page.dart';
import '../../features/my_wallet/presentation/my_wallet_page.dart';
import '../../features/on_boarding/on_boarding_page.dart';
import '../../features/shared/presentation/dashboard_page.dart';
import '../../features/wallet/data/model/wallet_model.dart';
import '../../features/wallet/presentation/create_wallet/create_wallet_page.dart';
import '../../features/wallet/presentation/create_wallet/success_create_wallet_page.dart';
import '../../features/wallet/presentation/import_wallet/import_wallet_page.dart';
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
        ),
        CupertinoRoute(
          page: CreateWalletRoute.page,
        ),
        CupertinoRoute(
          page: SuccessCreateWalletRoute.page,
        ),
        CupertinoRoute(
          page: ImportWalletRoute.page,
        ),
        CupertinoRoute(
          page: HomeRoute.page,
        ),
        CupertinoRoute(
          page: MyWalletRoute.page,
        ),
        CupertinoRoute(
          page: DashboardRoute.page,
          initial: true,
          children: [
            CupertinoRoute(page: HomeRoute.page),
            CupertinoRoute(page: HomeRoute.page),
            CupertinoRoute(page: HomeRoute.page),
            CupertinoRoute(page: HomeRoute.page),
            CupertinoRoute(page: HomeRoute.page),
          ],
        ),
      ];
}

final NavigationService navigationService = locator<NavigationService>();

final BuildContext globalContext = navigationService.currentContext!;
