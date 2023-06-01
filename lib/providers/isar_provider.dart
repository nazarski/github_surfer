import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/repository/isar_repository.dart';
import 'package:isar/isar.dart';

///Overridden in main, holds isar instance
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider has not been initialized');
});

final isarRepoProvider = Provider((ref) {
  final isar = ref.read(isarProvider);
  return IsarRepository(isar);
});
