import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rugmi/bloc/navigation/navigation_bloc.dart';
import 'package:rugmi/bloc/navigation/navigation_bloc_event.dart';
import 'package:rugmi/bloc/navigation/navigation_bloc_state.dart';

void main() {
  group('NavigationBloc', () {
    // Test initial state is HomePageState
    test('initial state is HomePageState', () {
      final navigationBloc = NavigationBloc();
      expect(navigationBloc.state, const HomePageState());
    });

    // Test when NavigateToHome is added
    blocTest<NavigationBloc, NavigationState>(
      'emits [HomePageState] when NavigateToHome is added',
      build: NavigationBloc.new,
      act: (bloc) => bloc.add(NavigateToHome()),
      expect: () => [const HomePageState()],
    );

    // Test when NavigateToFavourites is added
    blocTest<NavigationBloc, NavigationState>(
      'emits [FavouritesPageState] when NavigateToFavourites is added',
      build: NavigationBloc.new,
      act: (bloc) => bloc.add(NavigateToFavourites()),
      expect: () => [const FavouritesPageState()],
    );

    // Test when NavigateToSettings is added
    blocTest<NavigationBloc, NavigationState>(
      'emits [SettingsPageState] when NavigateToSettings is added',
      build: NavigationBloc.new,
      act: (bloc) => bloc.add(NavigateToSettings()),
      expect: () => [const SettingsPageState()],
    );

    // Test when NavigateToDetails is added
    blocTest<NavigationBloc, NavigationState>(
      'emits [DetailsPageState] when NavigateToDetails is added',
      build: NavigationBloc.new,
      act: (bloc) => bloc.add(NavigateToDetails()),
      expect: () => [const DetailsPageState()],
    );
  });
}
