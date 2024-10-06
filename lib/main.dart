import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/app/app.dart';
import 'core/env/env.dart';
import 'core/injector/locator.dart';
import 'hive_initialization.dart';

const env = Env('/uYxLTZRI1YYYxSDfCd89oVukMgf5UyzDkET1aSauvY=', 'pL3i3zubqUjPsjpj5ej9Eg==');
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await configureDependencies();
  await locator<HiveInitialization>().initHive();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp(
    const App(),
  );
}
