import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rugmi/bloc/favourites_bloc.dart';
import 'package:rugmi/bloc/favourites_bloc_state.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/widgets/image_card.dart';
import 'package:hive/hive.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is FavouritesLoaded) {
            // Show success message when favourites are loaded
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Favourites loaded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is FavouritesError) {
            // Show error message when there's an issue
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
            return _buildEmptyFavouritesContent();
          } else if (state is FavouritesLoaded) {
            return _buildFavouritesContent(state.favouritesBox, context);
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/error.png',
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.headerTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyFavouritesContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          )
        ],
      ),
    );
  }

  Widget _buildFavouritesContent(Box box, BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2;

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: box.length,
      itemBuilder: (context, index) {
        final item = box.getAt(index);
        final imageUrl = item['imageUrl'];
        final title = item['title'] ?? 'Untitled';
        final points = item['points'] ?? '';

        return InkWell(
          onTap: () {
            context.push(
              '/details',
              extra: {
                'imageUrl': imageUrl!,
                'title': title,
                'points': points,
              },
            );
          },
          child: item['imageUrl'] != null
              ? ImageCard(
                  imageUrl: imageUrl!,
                  title: title,
                  points: points,
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
