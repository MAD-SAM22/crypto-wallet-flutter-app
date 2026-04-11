import '../../domain/entities/Coin_category.dart';

class CategoryModel  {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['category_id']as String? ?? 'unknown',
      name: json['name']as String? ?? 'No Name',
    );
  }
}