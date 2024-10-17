import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:rugmi/services/hive_init.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockSearchBox;
  late MockBox mockFavouritesBox;

  setUp(() {
    mockSearchBox = MockBox();
    mockFavouritesBox = MockBox();
    Hive.initFlutter();
    when(Hive.box(HiveRepo.searchesBox)).thenReturn(mockSearchBox);
    when(Hive.box(HiveRepo.favouritesBox)).thenReturn(mockFavouritesBox);
  });

  group('HiveRepo Tests', () {
    test('addItem adds an item to the box without a key', () async {
      when(mockSearchBox.add('item')).thenAnswer((_) async => 1);
      await HiveRepo.addItem(HiveRepo.searchesBox, 'item');
      verify(mockSearchBox.add('item')).called(1);
    });

    test('addItem adds an item to the box with a key', () async {
      when(mockSearchBox.put('key', 'item')).thenAnswer((_) async => 1);
      await HiveRepo.addItem(HiveRepo.searchesBox, 'item', key: 'key');
      verify(mockSearchBox.put('key', 'item')).called(1);
    });

    test('getItems returns all items when no key is provided', () {
      when(mockSearchBox.values).thenReturn(['item1', 'item2']);
      final items = HiveRepo.getItems(HiveRepo.searchesBox);
      expect(items, ['item1', 'item2']);
      verify(mockSearchBox.values).called(1);
    });

    test('getItems returns items by key', () {
      when(mockSearchBox.get('key', defaultValue: <dynamic>[]))
          .thenReturn(['item1', 'item2']);
      final items = HiveRepo.getItems(HiveRepo.searchesBox, key: 'key');
      expect(items, ['item1', 'item2']);
      verify(mockSearchBox.get('key', defaultValue: <dynamic>[])).called(1);
    });

    test('clearBox clears the box', () async {
      when(mockSearchBox.clear()).thenAnswer((_) async => 0);
      await HiveRepo.clearBox(HiveRepo.searchesBox);
      verify(mockSearchBox.clear()).called(1);
    });

    test('removeItem removes item by index', () async {
      when(mockSearchBox.deleteAt(0)).thenAnswer((_) async => 0);
      await HiveRepo.removeItem(HiveRepo.searchesBox, 0);
      verify(mockSearchBox.deleteAt(0)).called(1);
    });

    test('addSearchQuery adds a query to recent searches', () async {
      List<String> mockRecentSearches = ['search1'];
      when(mockSearchBox.get(HiveRepo.recentSearchesKey,
          defaultValue: <String>[])).thenReturn(mockRecentSearches);

      await HiveRepo.addSearchQuery('search2');
      mockRecentSearches.add('search2');
      verify(mockSearchBox.put(HiveRepo.recentSearchesKey, mockRecentSearches))
          .called(1);
    });

    test('getRecentSearches returns a list of recent searches', () {
      when(mockSearchBox.get(HiveRepo.recentSearchesKey,
          defaultValue: <String>[])).thenReturn(['search1', 'search2']);
      final searches = HiveRepo.getRecentSearches();
      expect(searches, ['search1', 'search2']);
      verify(mockSearchBox
          .get(HiveRepo.recentSearchesKey, defaultValue: <String>[])).called(1);
    });

    test('clearRecentSearches clears recent searches', () async {
      when(mockSearchBox.put(HiveRepo.recentSearchesKey, <String>[]))
          .thenAnswer((_) async => 1);
      await HiveRepo.clearRecentSearches();
      verify(mockSearchBox.put(HiveRepo.recentSearchesKey, <String>[]))
          .called(1);
    });
  });
}
