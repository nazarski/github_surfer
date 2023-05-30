import 'package:isar/isar.dart';

part 'search_history_model.g.dart';
@collection
class SearchHistoryModel{
  Id id = Isar.autoIncrement;
  final String searchValue;

  SearchHistoryModel(this.searchValue);
}