import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc_event.dart';
import 'package:rugmi/bloc/modal/modal_bloc.dart';
import 'package:rugmi/bloc/navigation/navigation_bloc.dart';
import 'package:rugmi/bloc/searches/searches_bloc.dart';
import 'package:rugmi/bloc/searches/searches_bloc_event.dart';
import 'package:rugmi/navigation/router.dart';
import 'package:rugmi/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchesBloc()..add(FetchGallery())),
        BlocProvider(
          create: (context) => FavouritesBloc()..add(LoadFavourites()),
        ),
        BlocProvider<ModalBloc>(
          create: (context) => ModalBloc(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp.router(
        theme: appTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: createRouter(),
      ),
    );
  }
}
