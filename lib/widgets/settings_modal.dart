import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/utils/common.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onFavouritesCleared;

  const SettingsScreen({
    required this.onFavouritesCleared,
    super.key,
  });

  void clearAllFavourites() async {
    var box = Hive.box('favouritesBox');
    await box.clear();
    onFavouritesCleared();
  }

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
                  clearRecentSearches();
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
                  clearAllFavourites();
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
