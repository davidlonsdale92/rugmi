import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToHome extends NavigationEvent {}

class NavigateToFavourites extends NavigationEvent {}

class NavigateToSettings extends NavigationEvent {}

class NavigateToDetails extends NavigationEvent {}
