import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:rugmi/bloc/searches/searches_bloc.dart';
import 'package:rugmi/bloc/searches/searches_bloc_event.dart';
import 'package:rugmi/bloc/searches/searches_bloc_state.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/widgets/image_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchBarController;
  bool isSearchActive = false;
  List<dynamic> galleryItems = [];

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    final searchesBloc = context.read<SearchesBloc>();

    searchesBloc.add(FetchGallery());

    searchBarController = TextEditingController();
    searchBarController.addListener(() {
      if (searchBarController.text.isNotEmpty) {
        searchesBloc.add(const ToggleSearchActive(true));
      }
    });
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildSearchBar(),
      body: BlocBuilder<SearchesBloc, SearchesState>(
        builder: (context, state) {
          if (state is GalleryLoaded) {
            galleryItems = state.galleryItems;

            if (galleryItems.isEmpty) {
              return _buildEmptyGalleryContent();
            } else {
              return _buildImageGallery(galleryItems);
            }
          } else if (state is GalleryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GalleryError) {
            return _buildGalleryErrorContent();
          } else if (state is RecentSearchesLoaded ||
              state is DropdownVisible) {
            return Stack(
              children: [
                _buildImageGallery(galleryItems),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _buildSearchHistoryDropdown(
                    state is RecentSearchesLoaded ? state.recentSearches : [],
                  ),
                ),
              ],
            );
          } else if (state is SearchesLoaded) {
            return _buildImageGallery(state.searchResults);
          } else if (state is SearchError) {
            return _buildGalleryErrorContent();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildSearchBar() {
    final searchesBloc = context.read<SearchesBloc>();

    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: BlocBuilder<SearchesBloc, SearchesState>(
        builder: (context, state) {
          final isSearchActive = state is SearchActiveState;

          return AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: CompositedTransformTarget(
              link: LayerLink(),
              child: SearchBar(
                controller: searchBarController,
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 8),
                ),
                backgroundColor:
                    WidgetStateProperty.all(AppColors.searchBarColor),
                textStyle: WidgetStateProperty.all(
                  const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                  ),
                ),
                hintText: AppLocalizations.of(context).hintText,
                hintStyle: WidgetStateProperty.all(
                  const TextStyle(
                    color: AppColors.subtitleTextColor,
                    fontSize: 16,
                  ),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                trailing: [
                  if (isSearchActive)
                    IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {
                        searchBarController.clear();
                        searchesBloc.add(const ToggleSearchActive(false));
                        searchesBloc.add(FetchGallery());
                      },
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.search),
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {
                        final query = searchBarController.text;
                        if (query.isNotEmpty) {
                          searchesBloc.add(SearchImages(query));
                          searchesBloc.add(HideDropdown());
                        }
                      },
                    ),
                ],
                onTap: () {
                  if (searchBarController.text.isEmpty) {
                    searchesBloc.add(ShowDropdown());
                    searchesBloc.add(LoadRecentSearches());
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchHistoryDropdown(List<String> recentSearches) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.modalColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    recentSearches[index],
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    searchBarController.text = recentSearches[index];
                    context
                        .read<SearchesBloc>()
                        .add(SearchImages(recentSearches[index]));
                  },
                );
              },
            ),
            if (recentSearches.isNotEmpty)
              TextButton(
                onPressed: () {
                  context.read<SearchesBloc>().add(ClearSearchHistory());
                  context.read<SearchesBloc>().add(FetchGallery());
                },
                child: Text(
                  AppLocalizations.of(context).clearHistory,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery(List<dynamic> galleryItems) {
    final cardWidth = MediaQuery.of(context).size.width / 2;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: galleryItems.length,
      itemBuilder: (context, index) {
        final item = galleryItems[index];
        final imageUrl = item['cover'] != null
            ? 'https://i.imgur.com/${item['cover']}.jpg'
            : null;
        final title = item['title'] ?? 'Untitled';
        final points = item['points'] ?? '';

        return InkWell(
          onTap: () {
            context.push(
              '/details',
              extra: {
                'imageUrl': imageUrl,
                'title': title,
                'points': points,
              },
            );
          },
          child: item['cover'] != null
              ? ImageCard(
                  imageUrl: imageUrl!,
                  title: title is String ? title : 'Untitled',
                  points: points is int
                      ? points
                      : int.tryParse(points.toString()) ?? 0,
                  width: cardWidth,
                  height: 200,
                )
              : Image.asset(
                  'assets/images/image-placeholder.png',
                  width: cardWidth,
                  height: 200,
                ),
        );
      },
    );
  }

  Widget _buildEmptyGalleryContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/error.png',
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              AppLocalizations.of(context).struggling,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.headerTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/error.png',
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              AppLocalizations.of(context).uhOh,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.headerTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
