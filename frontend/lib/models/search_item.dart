class SearchItem {
  final int fdcId;
  final String description;
  final String brandName;

  SearchItem({
    required this.fdcId,
    required this.description,
    required this.brandName,
  });

  factory SearchItem.fromJson(Map<String, dynamic> j) => SearchItem(
        fdcId: j['fdcId'] as int? ?? 0,
        description: j['description'] as String? ?? '',
        brandName: j['brandName'] as String? ?? '',
      );
}
