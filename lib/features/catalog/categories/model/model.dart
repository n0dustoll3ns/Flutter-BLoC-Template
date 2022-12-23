import '../../products/model/product.dart';

class Category {
  List<Category> inheritedCategories = [];
  final String name;
  final int id;
  final String description;
  final String? _img;
  final List<Product> productList = [];

  Category({
    String? img,
    required this.id,
    required this.name,
    required this.description,
  }) : _img = img;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        _img = json['img'];

  String get img => _img ?? '';
}
