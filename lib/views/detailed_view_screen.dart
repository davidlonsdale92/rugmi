import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/widgets/detailed_image_card.dart';

@RoutePage()
class DetailedImageScreen extends StatefulWidget {
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
  _DetailedImageScreenState createState() => _DetailedImageScreenState();
}

class _DetailedImageScreenState extends State<DetailedImageScreen> {
  var favouritesBox = Hive.box('favouritesBox');

  bool isFavourite(String imageId) {
    return favouritesBox.containsKey(imageId);
  }

  Future<void> addToFavourites(
      String imageId, Map<String, dynamic> imageDetails) async {
    try {
      await favouritesBox.put(imageId, imageDetails);
      log('Image $imageId added to favourites.');
    } catch (e) {
      log('Error adding image to favourites: $e');
    }
  }

  Future<void> removeFromFavourites(String imageId) async {
    var favouritesBox = Hive.box('favouritesBox');
    try {
      await favouritesBox.delete(imageId);
      log('Image $imageId removed from favourites.');
    } catch (e) {
      log('Error removing image from favourites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: _buildDetailedContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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
          const Text(
            'Back',
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

  Widget _buildDetailedContent() {
    double cardWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          DetailedImageCard(
            imageUrl: widget.imageUrl,
            title: widget.title,
            points: widget.points,
            width: cardWidth,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: isFavourite(widget.imageUrl)
                  ? const WidgetStatePropertyAll(AppColors.error)
                  : const WidgetStatePropertyAll(AppColors.primary),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 12, horizontal: 65),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                if (isFavourite(widget.imageUrl)) {
                  removeFromFavourites(widget.imageUrl);
                } else {
                  addToFavourites(widget.imageUrl, {
                    'title': widget.title,
                    'points': widget.points,
                    'imageUrl': widget.imageUrl,
                  });
                }
              });
            },
            child: Text(
              isFavourite(widget.imageUrl)
                  ? 'Remove from Favourites'
                  : 'Add to Favourites',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.textWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}
