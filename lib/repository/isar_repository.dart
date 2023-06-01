import 'package:github_surfer/models/githib_repo_model/github_repo_model.dart';
import 'package:github_surfer/models/search_history_model/search_history_model.dart';
import 'package:isar/isar.dart';

class IsarRepository {
  final Isar _isar;

  IsarRepository(this._isar);

  Future<List<SearchHistoryModel>> getSearchHistory() async {
    return await _isar.txn(() async {
      return await _isar.searchHistoryModels.where().findAll();
    });
  }

  Future<void> addToHistory(SearchHistoryModel searchModel) async {
    await _isar.writeTxn(() async {
      await _isar.searchHistoryModels.put(searchModel);
    });
  }

  Future<List<GithubRepoModel>> getFavorites() async {
    return await _isar.txn(() async {
      return await _isar.githubRepoModels.where().findAll();
    });
  }

  Future<Set<int>> getFavoriteIds() async {
    return await _isar.txn(() async {
      final listOfRepos = await _isar.githubRepoModels.where().findAll();
      return listOfRepos.map((e) => e.repoId).toSet();
    });
  }

  Future<void> saveItemToFavorites(GithubRepoModel repo) async {
    await _isar.writeTxn(() async {
      await _isar.githubRepoModels.put(repo);
    });
  }

  Future<void> removeItemFromFavorites(int repoId) async {
    await _isar.writeTxn(() async {
      await _isar.githubRepoModels.deleteByRepoId(repoId);
    });
  }
}
