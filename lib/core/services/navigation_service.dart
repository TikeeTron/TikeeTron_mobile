import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../injector/locator.dart';
import '../routes/app_route.dart';

@singleton
class NavigationService {
  StackRouter get _router => locator<AppRouter>();

  GlobalKey<NavigatorState> get navigationKey => _router.navigatorKey;
  BuildContext? get currentContext => navigationKey.currentState!.context;

  // void pop({Object? argument}) {
  //   return navigationKey.currentState?.pop(argument);
  // }

  // void popUntil() {
  //   int count = 0;
  //   return navigationKey.currentState?.popUntil((_) => count++ >= 2);
  // }

  // Future<dynamic> popAndPushNamed(String routeName, {Object? arguments}) {
  //   return navigationKey.currentState!.popAndPushNamed(
  //     routeName,
  //     arguments: arguments,
  //   );
  // }

  // Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
  //   return navigationKey.currentState!.pushNamed(
  //     routeName,
  //     arguments: arguments,
  //   );
  // }

  // Future<dynamic> pushReplacementNamed(
  //   String routeName, {
  //   Object? arguments,
  //   Object? result,
  // }) {
  //   return navigationKey.currentState!.pushReplacementNamed(
  //     routeName,
  //     arguments: arguments,
  //     result: result,
  //   );
  // }

  // Future<dynamic> pushNamedAndRemoveUntil(
  //   String routeName, {
  //   Object? arguments,
  // }) {
  //   return navigationKey.currentState!.pushNamedAndRemoveUntil(
  //     routeName,
  //     (route) => false,
  //     arguments: arguments,
  //   );
  // }
  Future<T?> push<T extends Object?>(PageRouteInfo<dynamic> route, {void Function(NavigationFailure)? onFailure}) => _router.push(
        route,
        onFailure: onFailure,
      );

  Future<T?> pushAndPopUntil<T extends Object?>(
    PageRouteInfo<dynamic> route, {
    required bool Function(Route<dynamic>) predicate,
    bool scopedPopUntil = true,
    void Function(NavigationFailure)? onFailure,
  }) =>
      _router.pushAndPopUntil(
        route,
        predicate: predicate,
        scopedPopUntil: scopedPopUntil,
        onFailure: onFailure,
      );

  void popUntil(
    bool Function(Route<dynamic>) predicate, {
    bool scoped = true,
  }) {
    _router.popUntil(
      predicate,
      scoped: scoped,
    );
  }

  Future<bool> maybePop<T extends Object?>([T? result]) => _router.maybePop(result);
}
