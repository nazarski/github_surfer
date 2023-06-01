///Response class holds list of response items [listOfRepos], total number of pages [totalResults]
///and total number of results to be fetched [totalResults]

class PaginatedResponse<T> {
  final List<T> listOfRepos;
  final int totalResults;
  final int totalPages;

  PaginatedResponse({
    this.listOfRepos = const [],
    this.totalResults = 0,
    this.totalPages = 1,
  });

  factory PaginatedResponse.fromMap({
    required Map<String, dynamic> map,
    required List<T> listOfRepos,
    required int maxItems,
  }) {
    return PaginatedResponse(
      listOfRepos: listOfRepos,
      totalResults: map['total_count'] as int,
      totalPages: map['total_count'] ~/ maxItems,
    );
  }
}
