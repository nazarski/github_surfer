import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/models/githib_repo_model/github_repo_model.dart';
import 'package:github_surfer/providers/isar_provider.dart';
import 'package:github_surfer/repository/isar_repository.dart';

///Favorite repos local db fetch
final favoritesGetFutureProvider =
    FutureProvider.autoDispose<List<GithubRepoModel>>((ref) async {
  final repository = ref.read(isarRepoProvider);
  return await repository.getFavorites();
});

///Hold list of favorite items
final favoritesListProvider =
    StateNotifierProvider.autoDispose<FavoritesProvider, List<GithubRepoModel>>(
        (ref) {
  final repository = ref.read(isarRepoProvider);
  final data = ref.watch(favoritesGetFutureProvider).value ?? [];
  return FavoritesProvider(data, repository);
});

class FavoritesProvider extends StateNotifier<List<GithubRepoModel>> {
  FavoritesProvider(super.state, this.repository);

  final IsarRepository repository;

  void removeElement({required int index, required int repoId}) {
    repository.removeItemFromFavorites(repoId);
    final newList = List<GithubRepoModel>.from(state);
    state = newList..removeAt(index);
  }
}

///Favorite repo ids local db fetch
final favouriteIdsFutureProvider =
    FutureProvider.autoDispose<Set<int>>((ref) async {
  final repository = ref.read(isarRepoProvider);
  return await repository.getFavoriteIds();
});

///Hold a set of favorite ids
final favoriteIdsProvider =
    StateNotifierProvider.autoDispose<FavoriteIdsProvider, Set<int>>((ref) {
  final repository = ref.read(isarRepoProvider);
  final state = ref.watch(favouriteIdsFutureProvider).value ?? {};
  return FavoriteIdsProvider(state, repository);
});

class FavoriteIdsProvider extends StateNotifier<Set<int>> {
  FavoriteIdsProvider(super.state, this.repository);

  final IsarRepository repository;

  void addIdToFavorites(GithubRepoModel repo) {
    repository.saveItemToFavorites(repo);
    final newSet = Set<int>.from(state);
    state = newSet..add(repo.repoId);
  }

  void removeIdFromFavorites(GithubRepoModel repo) {
    repository.removeItemFromFavorites(repo.repoId);
    final newSet = Set<int>.from(state);
    state = newSet..remove(repo.repoId);
  }
}
