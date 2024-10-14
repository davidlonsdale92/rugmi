import 'package:equatable/equatable.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavourites extends FavouritesEvent {}

class ClearFavourites extends FavouritesEvent {}
