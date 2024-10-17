import 'package:flutter/material.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugmi/widgets/detailed_image_card.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc_event.dart';
import 'package:rugmi/bloc/favourites/favourites_bloc_state.dart';

class DetailedImageScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int points;

  const DetailedImageScreen({
    required this.imageUrl,
    required this.title,
    required this.points,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: _buildDetailedContent(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(
        color: AppColors.primary,
        size: 25,
      ),
      backgroundColor: AppColors.backgroundColor,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 18,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back),
              color: AppColors.textWhite,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(width: 10),
          Text(
            AppLocalizations.of(context)!.back,
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  Widget _buildDetailedContent(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          DetailedImageCard(
            imageUrl: imageUrl,
            title: title,
            points: points,
            width: cardWidth,
          ),
          const SizedBox(height: 16),
          BlocBuilder<FavouritesBloc, FavouritesState>(
            builder: (context, state) {
              bool isFavourite = false;
              if (state is FavouritesLoaded) {
                isFavourite = state.favourites
                    .any((favourite) => favourite['imageUrl'] == imageUrl);
              }
              return _buildAddRemoveButton(context, isFavourite);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddRemoveButton(context, isFavourite) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isFavourite ? AppColors.error : AppColors.primary,
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 65),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: () {
        if (isFavourite) {
          context.read<FavouritesBloc>().add(RemoveFavourite(imageUrl));
        } else {
          context.read<FavouritesBloc>().add(AddFavourite(imageUrl, {
                'title': title,
                'points': points,
                'imageUrl': imageUrl,
              }));
        }
      },
      child: Text(
        isFavourite
            ? AppLocalizations.of(context)!.removeFromFavourites
            : AppLocalizations.of(context)!.addToFavourites,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
