import '../../products/model/product.dart';

class Category {
  List<Category> inheritedCategories = [];
  final String name;
  final int id;
  final List<int> productIds;
  final String description;
  final String? img;
  final List<Product> productList = [];

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.productIds,
    this.img,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        productIds = List.from(json['productIds'] ?? []),
        description = json['description'] ?? '',
        img = json['img'];
}
