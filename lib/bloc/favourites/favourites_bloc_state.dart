import 'package:equatable/equatable.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesEmpty extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesError extends FavouritesState {
  const FavouritesError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class FavouritesLoaded extends FavouritesState {
  const FavouritesLoaded(this.favourites);
  final List<dynamic> favourites;

  @override
  List<Object?> get props => [favourites];
}
