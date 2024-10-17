import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc_event.dart';
import 'package:rugmi/bloc/home/searches_bloc.dart';
import 'package:rugmi/bloc/home/searches_bloc_event.dart';
import 'package:rugmi/theme/app_colors.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/settings_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.headerTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 6),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.primary),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 12, horizontal: 65),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                onPressed: () {
                  context.read<SearchesBloc>().add(ClearSearchHistory());
                  context.read<SearchesBloc>().add(FetchGallery());
                },
                child: const Text(
                  'Clear Search History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.error),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 12, horizontal: 58),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                onPressed: () {
                  context.read<FavouritesBloc>().add(ClearFavourites());
                },
                child: const Text(
                  'Remove All Favourites',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
