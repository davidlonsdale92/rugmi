import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugmi/navigation/navigation.dart';
import 'package:rugmi/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rugmi/views/home_screen.dart';

class App extends StatelessWidget {
  App({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: const [
    //     BlocProvider(
    //       create: (context) => BasketBloc(),
    //     ),
    //   ],
    //   child: MaterialApp.router(
    //     theme: appTheme(),
    //     debugShowCheckedModeBanner: false,
    //     localizationsDelegates: AppLocalizations.localizationsDelegates,
    //     supportedLocales: AppLocalizations.supportedLocales,
    //     routerConfig: _appRouter.config(),
    //   ),
    // );

    return MaterialApp.router(
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(),
    );
  }
}
