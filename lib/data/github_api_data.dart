import 'package:dio/dio.dart';
import 'package:github_surfer/entities/paginated_response.dart';
import 'package:github_surfer/models/githib_repo_model/github_repo_model.dart';

///Data class REST API
class GithubApiData {
  final Dio _dio;

  GithubApiData(this._dio);

  Future<PaginatedResponse<GithubRepoModel>> getRepositories({
    required int maxItems,
    required int page,
    required String searchValue,
  }) async {
    final response = await _dio.get('/repositories', queryParameters: {
      'q': searchValue,
      'page': page,
      'per_page': maxItems,
    });
    return PaginatedResponse.fromMap(
      map: response.data,
      maxItems: maxItems,
      listOfRepos: response.data['items'].map<GithubRepoModel>((e) {
        return GithubRepoModel.fromMap(e);
      }).toList(),
    );
  }
}
