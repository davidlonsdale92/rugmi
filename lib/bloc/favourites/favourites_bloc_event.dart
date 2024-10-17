import 'package:equatable/equatable.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavourites extends FavouritesEvent {}

class ClearFavourites extends FavouritesEvent {}

class AddFavourite extends FavouritesEvent {
  const AddFavourite(this.imageId, this.imageDetails);
  final String imageId;
  final Map<String, dynamic> imageDetails;

  @override
  List<Object?> get props => [imageId, imageDetails];
}

class RemoveFavourite extends FavouritesEvent {
  const RemoveFavourite(this.imageId);
  final String imageId;

  @override
  List<Object?> get props => [imageId];
}
