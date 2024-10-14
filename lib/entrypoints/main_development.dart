import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rugmi/app/view/app.dart';
import 'package:rugmi/bootstrap.dart';
import 'package:rugmi/utils/hive_init.dart';
import 'package:rugmi/utils/service_locator.dart';
import 'package:rugmi/views/home_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeHive();
  await dotenv.load();

  setupServiceLocator();

  // await bootstrap(() => App());
  runApp(App());
}
