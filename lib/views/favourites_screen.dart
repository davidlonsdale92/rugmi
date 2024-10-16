import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc_state.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/widgets/image_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is FavouritesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouritesError) {
            return _buildNetworkErrorContent(state.message);
          } else if (state is FavouritesEmpty) {
            return _buildEmptyFavouritesContent(context);
          } else if (state is FavouritesLoaded) {
            return _buildFavouritesContent(state.favourites, context);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildNetworkErrorContent(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/error.png',
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.headerTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFavouritesContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/favourites.png',
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              AppLocalizations.of(context).noFavourites,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.headerTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavouritesContent(
    List<dynamic> favourites,
    BuildContext context,
  ) {
    final cardWidth = MediaQuery.of(context).size.width / 2;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        final item = favourites[index];
        final imageUrl = item['imageUrl'];
        final title = item['title'] ?? 'Untitled';
        final points = item['points'] ?? '';

        return InkWell(
          onTap: () {
            context.push(
              '/details',
              extra: {
                'imageUrl': imageUrl,
                'title': title,
                'points': points,
              },
            );
          },
          child: imageUrl != null
              ? ImageCard(
                  imageUrl: imageUrl as String,
                  title: title as String,
                  points: points as int,
                  width: cardWidth,
                  height: 200,
                )
              : Image.asset(
                  'assets/images/image-placeholder.png',
                  width: cardWidth,
                  height: 200,
                ),
        );
      },
    );
  }
}
