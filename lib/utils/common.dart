import 'package:hive/hive.dart';

void clearRecentSearches() async {
  var searchesBox = Hive.box('searchesBox');
  searchesBox.put('recent_searches', <String>[]);
}
