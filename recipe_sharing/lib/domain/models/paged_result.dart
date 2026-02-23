class PagedResult<T> {
  List<T> result;
  int currentPage;
  int totalPages;
  int pageSize;

  PagedResult({
    required this.result,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
  });
}
