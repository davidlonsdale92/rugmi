import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc_event.dart';
import 'package:rugmi/bloc/modal/modal_bloc.dart';
import 'package:rugmi/bloc/modal/modal_bloc_event.dart';
import 'package:rugmi/bloc/modal/modal_bloc_state.dart';
import 'package:rugmi/bloc/navigation/navigation_bloc.dart';
import 'package:rugmi/bloc/navigation/navigation_bloc_event.dart';
import 'package:rugmi/bloc/navigation/navigation_bloc_state.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/widgets/settings_modal.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold({required this.child, required this.state, super.key});
  final Widget child;
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ModalBloc, ModalState>(
          listener: (context, state) {
            if (state is ModalVisible) {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: const SettingsModal(),
                  );
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                backgroundColor: AppColors.cardColor,
              ).whenComplete(() {
                context.read<ModalBloc>().add(HideModal());
                context.read<FavouritesBloc>().add(LoadFavourites());
              });
            }
          },
        ),
        BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            if (state is HomePageState) {
              context.go('/');
            } else if (state is FavouritesPageState) {
              context.go('/favourites');
            } else if (state is SettingsPageState) {
              context.read<ModalBloc>().add(ShowModal());
            } else if (state is DetailsPageState) {
              context.go('/details');
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: Container(
            padding: const EdgeInsets.all(16),
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
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Theme(
              data: Theme.of(context).copyWith(
                splashFactory: NoSplash.splashFactory,
              ),
              child: BottomNavigationBar(
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
                currentIndex: state.selectedIndex,
                iconSize: 28,
                selectedIconTheme: const IconThemeData(size: 35),
                showUnselectedLabels: false,
                showSelectedLabels: false,
                enableFeedback: true,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.unselectedColor,
                onTap: (index) {
                  if (index == 0) {
                    context.read<NavigationBloc>().add(NavigateToHome());
                  } else if (index == 1) {
                    context.read<NavigationBloc>().add(NavigateToFavourites());
                  } else if (index == 2) {
                    context.read<NavigationBloc>().add(NavigateToSettings());
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
