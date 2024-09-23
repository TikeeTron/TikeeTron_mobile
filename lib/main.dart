import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/app/app.dart';
import 'core/env/env.dart';
import 'core/injector/locator.dart';
import 'hive_initialization.dart';

const env = Env('iYn0Z6ukaZa4kTZGdBhVkl/dMsMjucRhVsCmIdy0AGo=', 'd5toQ2T1nQvxp6JCodY7Qw==');
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await configureDependencies();
  await locator<HiveInitialization>().initHive();
  runApp(
    const App(),
  );
}
