import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final Box favouritesBox;

  const FavouritesLoaded(this.favouritesBox);

  @override
  List<Object?> get props => [favouritesBox];
}

class FavouritesEmpty extends FavouritesState {}

class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError(this.message);

  @override
  List<Object?> get props => [message];
}
