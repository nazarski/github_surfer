import 'package:github_surfer/models/search_history_model.dart';
import 'package:isar/isar.dart';

class IsarRepository {
  final Isar _isar;

  IsarRepository(this._isar);

  Future<List<SearchHistoryModel>> getSearchHistory() async {
    return _isar.txn(() {
      return _isar.searchHistoryModels.where().findAll();
    });
  }

  Future<void> addToHistory(SearchHistoryModel searchModel) async {
    await _isar.writeTxn(() async {
      await _isar.searchHistoryModels.put(searchModel);
    });
  }
}
