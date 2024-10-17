import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rugmi/app/app.dart';
import 'package:rugmi/services/hive_init.dart';
import 'package:rugmi/services/service_locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  setupServiceLocator();

  await dotenv.load(fileName: '.env');
  await HiveRepo.initializeHive();

  runApp(const App());
}
