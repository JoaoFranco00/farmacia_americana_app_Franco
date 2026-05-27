class SearchResultArguments {
  const SearchResultArguments.query(this.query)
    : categoryId = null,
      categoryName = null;

  const SearchResultArguments.category({
    required this.categoryId,
    required this.categoryName,
  }) : query = null;

  final String? query;
  final String? categoryId;
  final String? categoryName;

  bool get isCategorySearch => categoryId != null;
}
