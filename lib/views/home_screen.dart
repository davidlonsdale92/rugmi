import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/image_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageCard(
          imageUrl:
              'https://lumiere-a.akamaihd.net/v1/images/Yoda-Retina_2a7ecc26.jpeg?region=0%2C0%2C1536%2C864',
          title: 'Yoda',
          description: 'Grand Jedi Master',
        ),
      ],
    );
  }
}
