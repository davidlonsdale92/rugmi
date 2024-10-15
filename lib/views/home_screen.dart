import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:rugmi/api/imgur_api.dart';
import 'package:rugmi/theme/app_colors.dart';
import 'package:rugmi/utils/common.dart';
import 'package:rugmi/widgets/image_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _galleryItems = [];
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late ImgurAPI _imgurAPI;
  late TextEditingController searchBarController;
  bool isDropdownOpen = false;
  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _imgurAPI = GetIt.I<ImgurAPI>();
    searchBarController = TextEditingController();
    searchBarController.addListener(_onSearchChanged);
    _fetchGallery();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    searchBarController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _fetchGallery() async {
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
      setState(() {
        _galleryItems = gallery['data'];
      });
    } else {
      debugPrint('Failed to fetch gallery');
    }
  }

  void _searchImages(String query) async {
    final searchResults = await _imgurAPI.searchImages(query);

    if (searchResults != null && searchResults['data'] != null) {
      setState(() {
        _galleryItems = searchResults['data'];
      });
    } else {
      debugPrint('Failed to search images');
    }
  }

  void saveSearchQuery(String query) async {
    var searchesBox = Hive.box('searchesBox');
    List<String> recentSearches = searchesBox
            .get('recent_searches', defaultValue: <String>[])?.cast<String>() ??
        [];

    if (!recentSearches.contains(query)) {
      recentSearches.add(query);
      searchesBox.put('recent_searches', recentSearches);
    }
  }

  List<String> getRecentSearches() {
    var searchesBox = Hive.box('searchesBox');
    return searchesBox
            .get('recent_searches', defaultValue: <String>[])?.cast<String>() ??
        [];
  }

  void _onSearchChanged() {
    final query = searchBarController.text;
    if (query.isNotEmpty && !isDropdownOpen) {
      _showDropdown();
    } else if (query.isEmpty && isDropdownOpen) {
      _hideDropdown();
    }

    setState(() {
      isSearchActive = query.isNotEmpty;
    });
  }

  void _showDropdown() {
    if (_overlayEntry != null) {
      _hideDropdown();
    }

    final recentSearches = getRecentSearches();
    if (recentSearches.isEmpty) return;

    _overlayEntry = _createOverlayEntry(recentSearches);
    Overlay.of(context).insert(_overlayEntry!);
    isDropdownOpen = true;
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    isDropdownOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _buildAppBar(),
        body: _galleryItems.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : _buildImageGallery());
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: CompositedTransformTarget(
          link: _layerLink,
          child: SearchBar(
            controller: searchBarController,
            padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 0, horizontal: 8)),
            backgroundColor: WidgetStateProperty.all(AppColors.searchBarColor),
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
              ),
            ),
            hintText: 'Images, #tags, @users oh my!',
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
                    _hideDropdown();
                    _fetchGallery();
                    setState(() {
                      isSearchActive = false;
                    });
                  },
                ),
              IconButton(
                icon: const Icon(Icons.search),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  final query = searchBarController.text;
                  if (query.isNotEmpty) {
                    saveSearchQuery(query);
                    _searchImages(query);
                    _hideDropdown();
                  }
                },
              ),
            ],
            onTap: () {
              if (searchBarController.text.isEmpty) {
                _showDropdown();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    double cardWidth = MediaQuery.of(context).size.width / 2;

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: _galleryItems.length,
      itemBuilder: (context, index) {
        final item = _galleryItems[index];
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
                'imageUrl': imageUrl!,
                'title': title,
                'points': points,
              },
            );
          },
          child: item['cover'] != null
              ? ImageCard(
                  imageUrl: imageUrl!,
                  title: title,
                  points: points,
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

  OverlayEntry _createOverlayEntry(List<String> recentSearches) {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width - 20,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0.0, 65.0),
            child: Material(
              color: AppColors.backgroundColor,
              elevation: 4.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recentSearches[index],
                            style: const TextStyle(color: AppColors.textWhite)),
                        if (index == recentSearches.length - 1)
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(EdgeInsets.zero),
                              foregroundColor:
                                  WidgetStateProperty.all(AppColors.primary),
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () {
                              clearRecentSearches();
                              _hideDropdown();
                            },
                            child: const Text('Clear Search History'),
                          ),
                      ],
                    ),
                    onTap: () {
                      searchBarController.text = recentSearches[index];
                      _searchImages(recentSearches[index]);
                      _hideDropdown();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
