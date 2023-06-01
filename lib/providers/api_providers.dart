import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/data/github_api_data.dart';
import 'package:github_surfer/repository/github_repo_repository.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(baseUrl: 'https://api.github.com/search'),
  ),
);

final apiDataProvider = Provider<GithubApiData>((ref) {
  final dio = ref.read(dioProvider);
  return GithubApiData(dio);
});

final githubRepoRepositoryProvider = Provider<GithubRepoRepository>(
  (ref) {
    final apiData = ref.read(apiDataProvider);
    return GithubRepoRepository(apiData);
  },
);
