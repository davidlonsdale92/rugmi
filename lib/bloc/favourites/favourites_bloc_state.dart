import 'package:equatable/equatable.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesEmpty extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavouritesLoaded extends FavouritesState {
  final List<dynamic> favourites;

  const FavouritesLoaded(this.favourites);

  @override
  List<Object?> get props => [favourites];
}
