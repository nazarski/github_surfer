import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/data/github_api_data.dart';
import 'package:github_surfer/entities/paginated_request.dart';
import 'package:github_surfer/entities/paginated_response.dart';
import 'package:github_surfer/models/github_repo_model.dart';
import 'package:github_surfer/repository/github_repo_repository.dart';

import 'favorites_provider.dart';

final apiDataProvider = Provider<GithubApiData>((ref) => GithubApiData());

final paginatedRequestProvider = StateNotifierProvider.autoDispose<
    PaginatedRequestNotifier, PaginatedRequest>((ref) {
  return PaginatedRequestNotifier();
});

class PaginatedRequestNotifier extends StateNotifier<PaginatedRequest> {
  PaginatedRequestNotifier() : super(const PaginatedRequest());

  void setNewValue(value) {
    state = state.copyWith(page: 1, searchValue: value);
  }
}

final githubRepoRepositoryProvider = Provider<GithubRepoRepository>(
  (ref) {
    final apiData = ref.watch(apiDataProvider);
    return GithubRepoRepository(apiData);
  },
);

final paginatedGithubReposProvider =
    FutureProvider.family.autoDispose<PaginatedResponse<GithubRepoModel>, int>(
  (ref, page) async {
    final request = ref.watch(paginatedRequestProvider);
    if (request.searchValue.isNotEmpty) {
      final githubRepository = ref.watch(githubRepoRepositoryProvider);
      // The API request:
      final result = await githubRepository.getRepositories(
          request: request.copyWith(page: page + 1));
      return result;
    }
    return PaginatedResponse();
  },
);

final githubReposCountProvider = FutureProvider.autoDispose<int>((ref) async {
  await ref.read(favouriteIdsFutureProvider.future);
  final initialRequest =
      await ref.watch(paginatedGithubReposProvider(0).future);
  return initialRequest.totalResults;
});

final currentGithubRepoProvider = Provider<AsyncValue<GithubRepoModel>>((ref) {
  throw UnimplementedError();
});
