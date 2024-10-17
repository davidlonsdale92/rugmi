import 'package:flutter/material.dart';
import 'package:rugmi/theme/app_colors.dart';

class DetailedImageCard extends StatelessWidget {
  const DetailedImageCard({
    required this.imageUrl,
    required this.title,
    required this.points,
    required this.width,
    super.key,
  });
  final String imageUrl;
  final String title;
  final int points;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.secondaryCardColor,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
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
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w500,
                      color: AppColors.headerTextColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$points points',
                    style: TextStyle(
                      fontSize: width * 0.03,
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
