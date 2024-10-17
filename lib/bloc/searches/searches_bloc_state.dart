import 'package:equatable/equatable.dart';

abstract class SearchesState extends Equatable {
  const SearchesState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends SearchesState {}

class GalleryLoading extends SearchesState {}

class SearchesInitial extends SearchesState {}

class SearchesLoading extends SearchesState {}

class SearchHistoryCleared extends SearchesState {}

class DropdownVisible extends SearchesState {}

class DropdownHidden extends SearchesState {}

class GalleryLoaded extends SearchesState {
  final List<dynamic> galleryItems;

  GalleryLoaded(this.galleryItems);

  @override
  List<Object?> get props => [galleryItems];
}

class GalleryError extends SearchesState {
  final String message;
  GalleryError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchesLoaded extends SearchesState {
  final List<dynamic> searchResults;

  const SearchesLoaded(this.searchResults);

  @override
  List<Object?> get props => [searchResults];
}

class RecentSearchesLoaded extends SearchesState {
  final List<String> recentSearches;

  const RecentSearchesLoaded(this.recentSearches);

  @override
  List<Object?> get props => [recentSearches];
}

class SearchError extends SearchesState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchActiveState extends SearchesState {
  final bool isActive;

  const SearchActiveState(this.isActive);

  @override
  List<Object?> get props => [isActive];
}
