import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              // This needs a conditional to only display when no favourites exist
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/favourites.png',
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Save your favourite posts to see them here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headerTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
