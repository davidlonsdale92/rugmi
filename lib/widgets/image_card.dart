import 'package:flutter/material.dart';
import 'package:rugmi/theme/app_colors.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.imageUrl,
    required this.title,
    required this.points,
    required this.width,
    super.key,
    this.height,
  });
  final String imageUrl;
  final String title;
  final int points;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.secondaryCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: height,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.w500,
                      color: AppColors.headerTextColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$points points',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w600,
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
