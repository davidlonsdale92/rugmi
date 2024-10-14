import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'favourites_bloc_event.dart';
import 'favourites_bloc_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesLoading()) {
    on<LoadFavourites>(_onLoadFavourites);
    on<ClearFavourites>(_onClearFavourites);
  }

  Future<void> _onLoadFavourites(
      LoadFavourites event, Emitter<FavouritesState> emit) async {
    try {
      var box = await Hive.openBox('favouritesBox');
      if (box.isEmpty) {
        emit(FavouritesEmpty());
      } else {
        emit(FavouritesLoaded(box));
      }
    } catch (error) {
      emit(const FavouritesError('Failed to load favourites'));
    }
  }

  Future<void> _onClearFavourites(
      ClearFavourites event, Emitter<FavouritesState> emit) async {
    try {
      var box = await Hive.openBox('favouritesBox');
      await box.clear();
      emit(FavouritesEmpty());
    } catch (error) {
      emit(const FavouritesError('Failed to clear favourites'));
    }
  }
}
