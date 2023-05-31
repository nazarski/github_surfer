import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:github_surfer/entities/paginated_response.dart';
import 'package:github_surfer/models/github_repo_model.dart';

class GithubApiData {
  final _dio = Dio(BaseOptions(baseUrl: 'https://api.github.com/search'));

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
    log(response.realUri.toString());
    return PaginatedResponse.fromMap(
      map: response.data,
      maxItems: maxItems,
      listOfRepos: response.data['items'].map<GithubRepoModel>((e) {
        return GithubRepoModel.fromMap(e);
      }).toList(),
    );
  }
}
