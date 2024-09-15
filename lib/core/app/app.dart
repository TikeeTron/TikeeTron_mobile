import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/themes/cubit/theme_cubit.dart';
import '../../features/create_wallet/presentation/cubit/create_wallet_cubit.dart';
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

    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
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
