import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/app/app.dart';
import 'core/env/env.dart';
import 'core/injector/locator.dart';
import 'hive_initialization.dart';

const env = Env('N0P4rfBKIKeeeyQU/XMcMTs4pdz/45ESuYnDMUzMI5Q=', 'fqA6PJF/ma/6mttlTT/pOA==');
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await configureDependencies();
  await locator<HiveInitialization>().initHive();
  runApp(
    const App(),
  );
}
