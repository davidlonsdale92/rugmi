import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../api/imgur_api.dart';

void setupServiceLocator() {
  GetIt.I.registerSingleton<http.Client>(http.Client());
  GetIt.I.registerSingleton<ImgurAPI>(ImgurAPI(GetIt.I<http.Client>()));
}
