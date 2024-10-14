import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rugmi/views/favourites_screen.dart';
import 'package:rugmi/views/home_screen.dart';

import '../views/detailed_view_screen.dart';

part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page, initial: true),
        AutoRoute(path: '/favourites', page: FavouritesRoute.page),
        AutoRoute(path: '/detailed', page: DetailedImageRoute.page),
      ];
}
