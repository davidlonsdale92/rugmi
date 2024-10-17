import 'package:equatable/equatable.dart';

abstract class SearchesState extends Equatable {
  const SearchesState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends SearchesState {}

class GalleryLoading extends SearchesState {}

class DropdownHidden extends SearchesState {}

class SearchesInitial extends SearchesState {}

class SearchesLoading extends SearchesState {}

class DropdownVisible extends SearchesState {}

class SearchHistoryCleared extends SearchesState {}

class GalleryLoaded extends SearchesState {
  const GalleryLoaded(this.galleryItems);
  final List<dynamic> galleryItems;

  @override
  List<Object?> get props => [galleryItems];
}

class GalleryError extends SearchesState {
  const GalleryError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class SearchesLoaded extends SearchesState {
  const SearchesLoaded(this.searchResults);
  final List<dynamic> searchResults;

  @override
  List<Object?> get props => [searchResults];
}

class RecentSearchesLoaded extends SearchesState {
  const RecentSearchesLoaded(this.recentSearches);
  final List<String> recentSearches;

  @override
  List<Object?> get props => [recentSearches];
}

class SearchError extends SearchesState {
  const SearchError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class SearchActiveState extends SearchesState {
  const SearchActiveState(this.isActive);
  final bool isActive;

  @override
  List<Object?> get props => [isActive];
}
