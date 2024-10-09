import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/app/app.dart';
import 'core/env/env.dart';
import 'core/injector/locator.dart';
import 'hive_initialization.dart';

const env = Env('4CN6zRuapCetHaoAHQaZw/Axfpbbaeia9BJSa9FPb/4=', '23sqhgd9buup6IjUSjhGWA==');
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
