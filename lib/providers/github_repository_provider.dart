import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/entities/paginated_request.dart';
import 'package:github_surfer/entities/paginated_response.dart';
import 'package:github_surfer/models/githib_repo_model/github_repo_model.dart';
import 'package:github_surfer/providers/api_providers.dart';

import 'favorites_provider.dart';

///Holds new request as a state
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

/// The FutureProvider that does the fetching of the paginated list of repos
final paginatedGithubReposProvider =
    FutureProvider.family.autoDispose<PaginatedResponse<GithubRepoModel>, int>(
  (ref, page) async {
    final request = ref.watch(paginatedRequestProvider);

    /// Checks if there is any input
    if (request.searchValue.isNotEmpty) {
      final githubRepository = ref.watch(githubRepoRepositoryProvider);

      /// The API request:
      final result = await githubRepository.getRepositories(
          request: request.copyWith(page: page + 1));
      return result;
    }
    return PaginatedResponse();
  },
);

///Returns number of items to build
final githubReposCountProvider = FutureProvider.autoDispose<int>((ref) async {
  await ref.read(favouriteIdsFutureProvider.future);
  final initialRequest =
      await ref.watch(paginatedGithubReposProvider(0).future);
  return initialRequest.totalResults;
});

final currentGithubRepoProvider = Provider<AsyncValue<GithubRepoModel>>((ref) {
  throw UnimplementedError();
});
