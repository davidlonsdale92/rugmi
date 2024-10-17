import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  final int selectedIndex;

  const NavigationState(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

class HomePageState extends NavigationState {
  const HomePageState() : super(0);
}

class FavouritesPageState extends NavigationState {
  const FavouritesPageState() : super(1);
}

class SettingsPageState extends NavigationState {
  const SettingsPageState() : super(2);
}

class DetailsPageState extends NavigationState {
  const DetailsPageState() : super(3);
}
