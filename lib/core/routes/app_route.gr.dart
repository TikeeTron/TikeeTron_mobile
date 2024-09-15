// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

/// generated route for
/// [CreateWalletPage]
class CreateWalletRoute extends PageRouteInfo<void> {
  const CreateWalletRoute({List<PageRouteInfo>? children})
      : super(
          CreateWalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateWalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateWalletPage();
    },
  );
}

/// generated route for
/// [OnBoardingPage]
class OnBoardingRoute extends PageRouteInfo<void> {
  const OnBoardingRoute({List<PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnBoardingPage();
    },
  );
}

/// generated route for
/// [SuccessCreateWalletPage]
class SuccessCreateWalletRoute
    extends PageRouteInfo<SuccessCreateWalletRouteArgs> {
  SuccessCreateWalletRoute({
    Key? key,
    required SuccessCreateWalletPageParams params,
    List<PageRouteInfo>? children,
  }) : super(
          SuccessCreateWalletRoute.name,
          args: SuccessCreateWalletRouteArgs(
            key: key,
            params: params,
          ),
          initialChildren: children,
        );

  static const String name = 'SuccessCreateWalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SuccessCreateWalletRouteArgs>();
      return SuccessCreateWalletPage(
        key: args.key,
        params: args.params,
      );
    },
  );
}

class SuccessCreateWalletRouteArgs {
  const SuccessCreateWalletRouteArgs({
    this.key,
    required this.params,
  });

  final Key? key;

  final SuccessCreateWalletPageParams params;

  @override
  String toString() {
    return 'SuccessCreateWalletRouteArgs{key: $key, params: $params}';
  }
}
