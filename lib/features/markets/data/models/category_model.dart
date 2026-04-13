class MarketCategory {
  final String id;
  final String name;

  MarketCategory({required this.id, required this.name});

  factory MarketCategory.fromJson(Map<String, dynamic> json) {
    return MarketCategory(
      id: json['category_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
