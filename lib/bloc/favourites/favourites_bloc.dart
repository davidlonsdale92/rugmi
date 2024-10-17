import 'favourites_bloc_event.dart';
import 'favourites_bloc_state.dart';
import 'package:rugmi/services/hive_init.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesLoading()) {
    on<AddFavourite>(_onAddFavourite);
    on<LoadFavourites>(_onLoadFavourites);
    on<ClearFavourites>(_onClearFavourites);
    on<RemoveFavourite>(_onRemoveFavourite);
  }

  Future<void> _onLoadFavourites(
      LoadFavourites event, Emitter<FavouritesState> emit) async {
    try {
      var items = HiveRepo.getItems(HiveRepo.favouritesBox);
      if (items.isEmpty) {
        emit(FavouritesEmpty());
      } else {
        emit(FavouritesLoaded(items));
      }
    } catch (error) {
      emit(const FavouritesError('Failed to load favourites'));
    }
  }

  Future<void> _onClearFavourites(
      ClearFavourites event, Emitter<FavouritesState> emit) async {
    try {
      await HiveRepo.clearBox(HiveRepo.favouritesBox);
      emit(FavouritesEmpty());
    } catch (error) {
      emit(const FavouritesError('Failed to clear favourites'));
    }
  }

  Future<void> _onAddFavourite(
      AddFavourite event, Emitter<FavouritesState> emit) async {
    try {
      await HiveRepo.addItem(HiveRepo.favouritesBox, event.imageDetails);
      var items = HiveRepo.getItems(HiveRepo.favouritesBox);
      emit(FavouritesLoaded(items));
    } catch (error) {
      emit(const FavouritesError('Failed to add favourite'));
    }
  }

  Future<void> _onRemoveFavourite(
      RemoveFavourite event, Emitter<FavouritesState> emit) async {
    try {
      var items = HiveRepo.getItems(HiveRepo.favouritesBox);
      var index =
          items.indexWhere((element) => element['imageUrl'] == event.imageId);
      if (index != -1) {
        await HiveRepo.removeItem(HiveRepo.favouritesBox, index);
      }
      items = HiveRepo.getItems(HiveRepo.favouritesBox);
      emit(FavouritesLoaded(items));
    } catch (error) {
      emit(const FavouritesError('Failed to remove favourite'));
    }
  }
}
