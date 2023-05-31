import 'package:github_surfer/models/github_repo_model.dart';

class FavoritesEntity {
  final List<GithubRepoModel> listOfRepos;
  final Set<int> favoriteIds;

  FavoritesEntity({
    this.listOfRepos = const [],
    this.favoriteIds = const {},
  });

  FavoritesEntity copyWith({
    List<GithubRepoModel>? listOfRepos,
    Set<int>? favoriteIds,
  }) {
    return FavoritesEntity(
      listOfRepos: listOfRepos ?? this.listOfRepos,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}
