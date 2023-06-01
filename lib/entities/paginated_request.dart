///Request class holds page num and search value
class PaginatedRequest {
  final int page;
  final String searchValue;

  const PaginatedRequest({
    this.page = 0,
    this.searchValue = '',
  });

  PaginatedRequest copyWith({
    int? page,
    String? searchValue,
  }) {
    return PaginatedRequest(
      page: page ?? this.page,
      searchValue: searchValue ?? this.searchValue,
    );
  }
}
