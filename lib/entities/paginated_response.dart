enum FetchStatus {
  loading,
  success,
  error,
}

class PaginatedResponse<T> {
  // final int page;
  final List<T> listOfRepos;
  // final FetchStatus status;
  final int totalResults;
  final int totalPages;

  PaginatedResponse({
    // this.page = 1,
    this.listOfRepos = const [],
    // this.status = FetchStatus.loading,
    this.totalResults = 0,
    this.totalPages = 1,
  });

  factory PaginatedResponse.fromMap({
    required Map<String, dynamic> map,
    required List<T> listOfRepos,
    required int maxItems,
  }) {
    return PaginatedResponse(
      // page: map['page'] as int,
      listOfRepos: listOfRepos,
      // status: map['status'] as FetchStatus,
      totalResults: map['total_count'] as int,
      totalPages: map['total_count'] ~/ maxItems,
    );
  }
}
