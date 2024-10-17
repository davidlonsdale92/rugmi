import 'package:hive_flutter/hive_flutter.dart';

class HiveRepo {
  static const String searchesBox = 'searchesBox';
  static const String favouritesBox = 'favouritesBox';
  static const String recentSearchesKey = 'recent_searches';

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox(searchesBox);
    await Hive.openBox(favouritesBox);
  }

  static Box getBox(String boxName) {
    return Hive.box(boxName);
  }

  static Future<void> addItem(String boxName, dynamic item,
      {String? key}) async {
    final box = getBox(boxName);

    if (key != null) {
      await box.put(key, item);
    } else {
      await box.add(item);
    }
  }

  static List<dynamic> getItems(String boxName, {String? key}) {
    final box = getBox(boxName);

    if (key != null) {
      return box.get(key, defaultValue: <dynamic>[]).cast<dynamic>();
    } else {
      return box.values.toList();
    }
  }

  static Future<void> clearBox(String boxName) async {
    final box = getBox(boxName);
    await box.clear();
  }

  static Future<void> removeItem(String boxName, int index) async {
    final box = getBox(boxName);
    await box.deleteAt(index);
  }

  static Future<void> addSearchQuery(String query) async {
    final box = getBox(searchesBox);
    List<String> recentSearches =
        box.get(recentSearchesKey, defaultValue: <String>[])!.cast<String>();

    if (!recentSearches.contains(query)) {
      recentSearches.add(query);
      await box.put(recentSearchesKey, recentSearches);
    }
  }

  static List<String> getRecentSearches() {
    final box = getBox(searchesBox);
    return box.get(recentSearchesKey, defaultValue: <String>[])!.cast<String>();
  }

  static Future<void> clearRecentSearches() async {
    final box = getBox(searchesBox);
    await box.put(recentSearchesKey, <String>[]);
  }
}
