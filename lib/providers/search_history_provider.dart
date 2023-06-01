import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/models/search_history_model/search_history_model.dart';
import 'package:github_surfer/providers/isar_provider.dart';
import 'package:github_surfer/repository/isar_repository.dart';

final searchHistoryProvider = StateNotifierProvider<SearchHistoryProvider,
    AsyncValue<List<SearchHistoryModel>>>((ref) {
  final repo = ref.read(isarRepoProvider);
  return SearchHistoryProvider(repo);
});

class SearchHistoryProvider
    extends StateNotifier<AsyncValue<List<SearchHistoryModel>>> {
  SearchHistoryProvider(this._repository) : super(const AsyncLoading()) {
    _getSearchHistory();
  }

  final IsarRepository _repository;

  Future<void> _getSearchHistory() async {
    final historyList = await _repository.getSearchHistory();
    log(historyList.toString());
    state = AsyncData(historyList);
  }

  Future<void> addToHistory({required String value}) async {
    final searchModel = SearchHistoryModel(value);
    await _repository.addToHistory(searchModel);
    _getSearchHistory();
  }
}
