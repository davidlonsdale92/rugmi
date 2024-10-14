import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rugmi/navigation/navigation.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/widgets/image_card.dart';

@RoutePage()
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late Future<Box> favouritesBox;

  @override
  void initState() {
    super.initState();
    favouritesBox = Hive.openBox('favouritesBox');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box>(
      future: favouritesBox,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildNetworkErrorContent();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildNoFavouritesContent();
        } else {
          var box = snapshot.data!;
          return _buildFavouritesContent(box);
        }
      },
    );
  }

  Widget _buildNetworkErrorContent() {
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'Error loading favourites',
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

  Widget _buildNoFavouritesContent() {
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

  Widget _buildFavouritesContent(Box box) {
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
            context.router.push(
              DetailedImageRoute(
                imageUrl: imageUrl!,
                title: title,
                points: points,
              ),
            );
          },
          child: item['imageUrl'] != null
              ? ImageCard(
                  imageUrl: imageUrl,
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
