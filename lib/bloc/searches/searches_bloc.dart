import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rugmi/api/imgur_api.dart';
import 'package:rugmi/bloc/searches/searches_bloc_event.dart';
import 'package:rugmi/bloc/searches/searches_bloc_state.dart';
import 'package:rugmi/services/hive_init.dart';

class SearchesBloc extends Bloc<SearchesEvent, SearchesState> {
  SearchesBloc() : super(SearchesInitial()) {
    on<FetchGallery>(_onFetchGallery);
    on<ShowDropdown>(_onShowDropdown);
    on<HideDropdown>(_onHideDropdown);
    on<SearchImages>(_onSearchImages);
    on<LoadRecentSearches>(_onLoadRecentSearches);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<ToggleSearchActive>(_onToggleSearchActive);
  }
  final ImgurAPI _imgurAPI = GetIt.I<ImgurAPI>();

  // Event handler for FetchGallery
  Future<void> _onFetchGallery(
    FetchGallery event,
    Emitter<SearchesState> emit,
  ) async {
    emit(GalleryLoading());

    try {
      final gallery = await _imgurAPI.fetchGallery(
        section: 'hot',
        sort: 'viral',
        window: 'day',
        page: 1,
        showViral: true,
        showMature: false,
        albumPreviews: true,
      );

      if (gallery != null && gallery['data'] != null) {
        emit(
          GalleryLoaded(
            List<dynamic>.from(gallery['data'] as Iterable<dynamic>),
          ),
        );
      } else {
        debugPrint('Failed to fetch gallery');
        emit(const GalleryError('Failed to fetch gallery data.'));
      }
    } catch (e) {
      debugPrint('An error occurred while fetching the gallery: $e');
      emit(GalleryError('An error occurred while fetching the gallery: $e'));
    }
  }

  // Event handler for SearchImages
  Future<void> _onSearchImages(
    SearchImages event,
    Emitter<SearchesState> emit,
  ) async {
    emit(SearchesLoading());
    try {
      final searchResults = await _imgurAPI.searchImages(event.query);

      if (searchResults != null && searchResults['data'] != null) {
        await HiveRepo.addSearchQuery(event.query);
        emit(
          SearchesLoaded(
            List<dynamic>.from(searchResults['data'] as Iterable<dynamic>),
          ),
        );
      } else {
        debugPrint('Failed to search images');
        emit(const SearchError('Failed to search images'));
      }
    } catch (error) {
      debugPrint('Error While Searching: $error)');
      emit(SearchError(error.toString()));
    }
  }

  // Event handler for ToggleSearchActive
  void _onToggleSearchActive(
    ToggleSearchActive event,
    Emitter<SearchesState> emit,
  ) {
    emit(SearchActiveState(event.isActive));
    if (event.isActive) {
      emit(DropdownVisible());
    } else {
      emit(DropdownHidden());
    }
  }

  // Event handler for LoadRecentSearches
  void _onLoadRecentSearches(
    LoadRecentSearches event,
    Emitter<SearchesState> emit,
  ) {
    final recentSearches = HiveRepo.getRecentSearches();
    emit(RecentSearchesLoaded(recentSearches));
  }

  // Event handler for ClearSearchHistory
  Future<void> _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<SearchesState> emit,
  ) async {
    await HiveRepo.clearRecentSearches();
    emit(SearchHistoryCleared());
  }

  // Event handler for ShowDropdown
  void _onShowDropdown(ShowDropdown event, Emitter<SearchesState> emit) {
    emit(DropdownVisible());
  }

  // Event handler for HideDropdown
  void _onHideDropdown(HideDropdown event, Emitter<SearchesState> emit) {
    emit(DropdownHidden());
  }
}
