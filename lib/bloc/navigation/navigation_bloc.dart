import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_bloc_event.dart';
import 'navigation_bloc_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const HomePageState()) {
    on<NavigateToHome>(_onNavigateToHome);
    on<NavigateToDetails>(_onNavigateToDetails);
    on<NavigateToSettings>(_onNavigateToSettings);
    on<NavigateToFavourites>(_onNavigateToFavourites);
  }

  void _onNavigateToHome(NavigateToHome event, Emitter<NavigationState> emit) {
    emit(const HomePageState());
  }

  void _onNavigateToFavourites(
      NavigateToFavourites event, Emitter<NavigationState> emit) {
    emit(const FavouritesPageState());
  }

  void _onNavigateToSettings(
      NavigateToSettings event, Emitter<NavigationState> emit) {
    emit(const SettingsPageState());
  }

  void _onNavigateToDetails(
      NavigateToDetails event, Emitter<NavigationState> emit) {
    emit(const DetailsPageState());
  }
}
