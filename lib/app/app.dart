import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rugmi/views/detailed_view_screen.dart';
import 'package:rugmi/views/favourites_screen.dart';
import 'package:rugmi/views/home_screen.dart';
import 'package:rugmi/widgets/settings_modal.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var favouritesBox = Hive.box('favouritesBox');

  int _getIndexForRoute(String location) {
    switch (location) {
      case '/':
        return 0;
      case '/favourites':
        return 1;
      default:
        return 0;
    }
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/favourites');
        break;
      case 2:
        _showSettingsModal(context);
        break;
      case 3:
        context.go('/details');
        break;
    }
  }

  void _showSettingsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: SettingsScreen(
            onFavouritesCleared: _refreshFavourites,
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      backgroundColor: AppColors.cardColor,
    );
  }

  void _refreshFavourites() {
    setState(() {
      favouritesBox = Hive.box('favouritesBox');
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.backgroundColor,
                title: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                centerTitle: true,
              ),
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.backgroundColor,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: '',
                  ),
                ],
                currentIndex: _getIndexForRoute(state.uri.toString()),
                iconSize: 28,
                selectedIconTheme: const IconThemeData(size: 35),
                showUnselectedLabels: false,
                showSelectedLabels: false,
                enableFeedback: true,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.unselectedColor,
                onTap: (index) => _onTabTapped(context, index),
              ),
            );
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
                return NoTransitionPage(
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

    return MaterialApp.router(
      theme: appTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
