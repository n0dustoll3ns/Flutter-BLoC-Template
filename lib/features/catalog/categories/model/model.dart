import 'package:flutter_lorem/flutter_lorem.dart';

class CatalogCategory {
  List<CatalogCategory> inheritedCategories = [];
  final String name;
  final String description;
  final String? _img;

  CatalogCategory({
    String? img,
    required this.name,
    required this.description,
  }) : _img = img;

  String get img => _img ?? '';
}
