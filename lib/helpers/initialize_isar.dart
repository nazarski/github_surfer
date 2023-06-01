import 'package:github_surfer/models/githib_repo_model/github_repo_model.dart';
import 'package:github_surfer/models/search_history_model/search_history_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

///Func invokes at app launch, initializes Isar db and returns its instance
Future<Isar> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [SearchHistoryModelSchema, GithubRepoModelSchema],
    directory: dir.path,
  );
  return isar;
}
