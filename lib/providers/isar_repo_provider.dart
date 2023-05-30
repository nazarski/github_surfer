import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/providers/isar_provider.dart';
import 'package:github_surfer/repository/isar_repository.dart';

final isarRepoProvider = Provider((ref) {
  final isar = ref.read(isarProvider);
  log('inside repo got instance');
  return IsarRepository(isar);
});
