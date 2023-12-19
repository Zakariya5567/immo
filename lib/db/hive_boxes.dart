import 'package:hive/hive.dart';
import 'package:immo/db/search_history.dart';

class Boxes {
  static Box<SearchHistory> getSearchHistory() =>
      Hive.box<SearchHistory>("search_history");
}
