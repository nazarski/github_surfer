import 'package:github_surfer/data/github_api_data.dart';
import 'package:github_surfer/entities/paginated_request.dart';
import 'package:github_surfer/entities/paginated_response.dart';
import 'package:github_surfer/models/github_repo_model.dart';

class GithubRepoRepository {
  final GithubApiData githubApi;

  GithubRepoRepository(this.githubApi);

  Future<PaginatedResponse<GithubRepoModel>> getRepositories({
    required PaginatedRequest request,
    int maxItems = 15,
  }) async {
    return await githubApi.getRepositories(
      maxItems: maxItems,
      page: request.page,
      searchValue: request.searchValue,
    );
  }
}
