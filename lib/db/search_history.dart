import 'package:hive/hive.dart';
part 'search_history.g.dart';

@HiveType(typeId: 0)
class SearchHistory extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  SearchHistory(
      {required this.text,
      required this.date,
      required this.latitude,
      required this.longitude});
}
