import 'package:flutter_lorem/flutter_lorem.dart';

class CatalogCategory {
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

List<CatalogCategory> categories = List.generate(
  9,
  (index) => CatalogCategory(
    name: 'Root Category ${lorem(paragraphs: 1, words: 2).toLowerCase()}',
    description: lorem(paragraphs: 1, words: 9),
  ),
);
