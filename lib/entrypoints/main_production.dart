import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rugmi/app/app.dart';
import 'package:rugmi/utils/hive_init.dart';
import 'package:rugmi/utils/service_locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeHive();
  await dotenv.load(fileName: '.env');

  setupServiceLocator();

  runApp(const App());
}
