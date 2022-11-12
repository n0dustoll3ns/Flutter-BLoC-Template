import '../../products/model/product.dart';

class Category {
  List<Category> inheritedCategories = [];
  final String name;
  final String description;
  final String? _img;
  final List<Product> productList = [];

  Category({
    String? img,
    required this.name,
    required this.description,
  }) : _img = img;

  String get img => _img ?? '';
}
