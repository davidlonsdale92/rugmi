import 'package:equatable/equatable.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavourites extends FavouritesEvent {}

class ClearFavourites extends FavouritesEvent {}

class AddFavourite extends FavouritesEvent {
  final String imageId;
  final Map<String, dynamic> imageDetails;

  const AddFavourite(this.imageId, this.imageDetails);

  @override
  List<Object?> get props => [imageId, imageDetails];
}

class RemoveFavourite extends FavouritesEvent {
  final String imageId;

  const RemoveFavourite(this.imageId);

  @override
  List<Object?> get props => [imageId];
}
