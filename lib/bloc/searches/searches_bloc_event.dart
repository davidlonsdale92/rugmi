import 'package:equatable/equatable.dart';

abstract class SearchesEvent extends Equatable {
  const SearchesEvent();

  @override
  List<Object?> get props => [];
}

class FetchGallery extends SearchesEvent {}

class ShowDropdown extends SearchesEvent {}

class HideDropdown extends SearchesEvent {}

class LoadRecentSearches extends SearchesEvent {}

class ClearSearchHistory extends SearchesEvent {}

class SearchImages extends SearchesEvent {
  final String query;

  const SearchImages(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleSearchActive extends SearchesEvent {
  final bool isActive;

  const ToggleSearchActive(this.isActive);

  @override
  List<Object?> get props => [isActive];
}
