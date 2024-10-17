import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rugmi/views/home_screen.dart';
import 'package:rugmi/views/favourites_screen.dart';
import 'package:rugmi/widgets/primary_scaffold.dart';
import 'package:rugmi/views/detailed_view_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return PrimaryScaffold(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: HomeScreen(),
              );
            },
          ),
          GoRoute(
            path: '/favourites',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: FavouritesScreen(),
              );
            },
          ),
          GoRoute(
            path: '/details',
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, dynamic> extra =
                  state.extra as Map<String, dynamic>;

              if (!extra.containsKey('imageUrl')) {
                return const Scaffold(
                  body: Center(
                    child: Text('No image data provided'),
                  ),
                );
              }

              return DetailedImageScreen(
                imageUrl: extra['imageUrl'] as String,
                title: extra['title'] as String,
                points: extra['points'] as int,
              );
            },
          ),
        ],
      ),
    ],
  );
}
