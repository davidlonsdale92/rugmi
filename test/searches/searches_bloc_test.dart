import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

import 'package:rugmi/services/hive_init.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  group('HiveRepo Tests', () {
    test('addItem adds an item to the box without a key', () async {
      // Open the box
      var box = await Hive.openBox(HiveRepo.searchesBox);

      // Call the method under test
      await HiveRepo.addItem(HiveRepo.searchesBox, 'item');

      // Verify the item was added
      expect(box.values, contains('item'));
    });

    test('addItem adds an item to the box with a key', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);

      await HiveRepo.addItem(HiveRepo.searchesBox, 'item', key: 'key');

      expect(box.get('key'), 'item');
    });

    test('getItems returns all items when no key is provided', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);
      await box.addAll(['item1', 'item2']);

      final items = HiveRepo.getItems(HiveRepo.searchesBox);

      expect(items, ['item1', 'item2']);
    });

    test('getItems returns items by key', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);
      await box.put('key', ['item1', 'item2']);

      final items = HiveRepo.getItems(HiveRepo.searchesBox, key: 'key');

      expect(items, ['item1', 'item2']);
    });

    test('clearBox clears the box', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);
      await box.add('item');

      await HiveRepo.clearBox(HiveRepo.searchesBox);

      expect(box.isEmpty, true);
    });

    test('removeItem removes item by index', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);
      await box.addAll(['item1', 'item2']);

      await HiveRepo.removeItem(HiveRepo.searchesBox, 0);

      expect(box.values, ['item2']);
    });

    test('addSearchQuery adds a query to recent searches', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);
      await box.put(HiveRepo.recentSearchesKey, ['search1']);

      await HiveRepo.addSearchQuery('search2');

      final searches = box.get(HiveRepo.recentSearchesKey) as List<String>;

      expect(searches, ['search1', 'search2']);
    });

    test('getRecentSearches returns a list of recent searches', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);
      await box.put(HiveRepo.recentSearchesKey, ['search1', 'search2']);

      final searches = HiveRepo.getRecentSearches();

      expect(searches, ['search1', 'search2']);
    });

    test('clearRecentSearches clears recent searches', () async {
      var box = await Hive.openBox(HiveRepo.searchesBox);
      await box.put(HiveRepo.recentSearchesKey, ['search1', 'search2']);

      await HiveRepo.clearRecentSearches();

      final searches = box.get(HiveRepo.recentSearchesKey) as List<String>;

      expect(searches, <String>[]);
    });
  });
}
