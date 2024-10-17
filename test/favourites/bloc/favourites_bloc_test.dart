import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

import 'package:rugmi/services/hive_init.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
    await Hive.openBox(HiveRepo.favouritesBox);
  });

  tearDown(() async {
    await Hive.box(HiveRepo.favouritesBox).close();
    await tearDownTestHive();
  });

  group('HiveRepo FavouritesBox Tests', () {
    test('addItem adds an item to the favouritesBox without a key', () async {
      final box = Hive.box(HiveRepo.favouritesBox);

      await HiveRepo.addItem(HiveRepo.favouritesBox, {'imageUrl': 'url1'});

      final values = box.values.toList();

      expect(
        values,
        equals([
          {'imageUrl': 'url1'},
        ]),
      );
    });

    test('addItem adds an item to the favouritesBox with a key', () async {
      final box = Hive.box(HiveRepo.favouritesBox);

      await HiveRepo.addItem(
        HiveRepo.favouritesBox,
        {'imageUrl': 'url1'},
        key: 'key1',
      );

      expect(box.get('key1'), {'imageUrl': 'url1'});
    });

    test(
        'getItems returns all items from favouritesBox when no key is provided',
        () async {
      final box = Hive.box(HiveRepo.favouritesBox);
      await box.addAll([
        {'imageUrl': 'url1'},
        {'imageUrl': 'url2'},
      ]);

      final items = HiveRepo.getItems(HiveRepo.favouritesBox);

      expect(items, [
        {'imageUrl': 'url1'},
        {'imageUrl': 'url2'},
      ]);
    });

    test('getItems returns items by key from favouritesBox', () async {
      final box = Hive.box(HiveRepo.favouritesBox);
      await box.put('key1', {'imageUrl': 'url1'});

      final item = HiveRepo.getItems(HiveRepo.favouritesBox, key: 'key1');

      expect(item, {'imageUrl': 'url1'});
    });

    test('clearBox clears the favouritesBox', () async {
      final box = Hive.box(HiveRepo.favouritesBox);
      await box.add({'imageUrl': 'url1'});

      await HiveRepo.clearBox(HiveRepo.favouritesBox);

      expect(box.isEmpty, true);
    });

    test('removeItem removes item by index from favouritesBox', () async {
      final box = Hive.box(HiveRepo.favouritesBox);
      await box.addAll([
        {'imageUrl': 'url1'},
        {'imageUrl': 'url2'},
      ]);

      await HiveRepo.removeItem(HiveRepo.favouritesBox, 0);

      expect(box.values.toList(), [
        {'imageUrl': 'url2'},
      ]);
    });
  });
}
