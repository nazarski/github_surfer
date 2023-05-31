import 'package:isar/isar.dart';

part 'github_repo_model.g.dart';

@collection
class GithubRepoModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  final int repoId;
  final String name;

  GithubRepoModel({
    required this.repoId,
    required this.name,
  });

  factory GithubRepoModel.fromMap(Map<String, dynamic> map) {
    return GithubRepoModel(
      repoId: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
