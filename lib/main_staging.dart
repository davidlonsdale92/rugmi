import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rugmi/app/app.dart';
import 'package:rugmi/bootstrap.dart';
import 'package:rugmi/services/hive_init.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load();
  await HiveRepo.initializeHive();

  await bootstrap(() => const App());
}
