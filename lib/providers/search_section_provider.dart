import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchStatus {
  empty,
  value,
}

final searchSectionProvider =
    StateNotifierProvider<SearchSectionProvider, SearchStatus>(
        (ref) => SearchSectionProvider());

class SearchSectionProvider extends StateNotifier<SearchStatus> {
  SearchSectionProvider() : super(SearchStatus.empty);

  void notifyStatusChange({required bool searchValueIsEmpty}) {
    if (searchValueIsEmpty && state != SearchStatus.empty) {
      state = SearchStatus.empty;
    }
    if (searchValueIsEmpty && state != SearchStatus.value) {
      state = SearchStatus.value;
    }
  }
}
