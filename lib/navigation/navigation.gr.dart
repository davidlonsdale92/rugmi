// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'navigation.dart';

/// generated route for
/// [DetailedImageScreen]
class DetailedImageRoute extends PageRouteInfo<DetailedImageRouteArgs> {
  DetailedImageRoute({
    required String imageUrl,
    required String title,
    required int points,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DetailedImageRoute.name,
          args: DetailedImageRouteArgs(
            imageUrl: imageUrl,
            title: title,
            points: points,
            key: key,
          ),
        );

  static const String name = 'DetailedImageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailedImageRouteArgs>();
      return DetailedImageScreen(
        imageUrl: args.imageUrl,
        title: args.title,
        points: args.points,
        key: args.key,
      );
    },
  );
}

class DetailedImageRouteArgs {
  const DetailedImageRouteArgs({
    required this.imageUrl,
    required this.title,
    required this.points,
    this.key,
  });

  final String imageUrl;

  final String title;

  final int points;

  final Key? key;

  @override
  String toString() {
    return 'DetailedImageRouteArgs{imageUrl: $imageUrl, title: $title, points: $points, key: $key}';
  }
}

/// generated route for
/// [FavouritesScreen]
class FavouritesRoute extends PageRouteInfo<void> {
  const FavouritesRoute({List<PageRouteInfo>? children})
      : super(
          FavouritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavouritesScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}
