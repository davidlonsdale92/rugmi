import 'package:hive_flutter/hive_flutter.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();
  await Hive.openBox('searchesBox');
  await Hive.openBox('favouritesBox');
}
