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
  const SearchImages(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}

class ToggleSearchActive extends SearchesEvent {
  const ToggleSearchActive(this.isActive);
  final bool isActive;

  @override
  List<Object?> get props => [isActive];
}
