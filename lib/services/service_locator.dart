import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rugmi/api/imgur_api.dart';
import 'package:rugmi/services/hive_init.dart';

void setupServiceLocator() {
  GetIt.I.registerSingleton<http.Client>(http.Client());
  GetIt.I.registerSingleton<ImgurAPI>(ImgurAPI(GetIt.I<http.Client>()));
  GetIt.I.registerSingleton<HiveRepo>(HiveRepo());
}
