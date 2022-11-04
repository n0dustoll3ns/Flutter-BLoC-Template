import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/catalog.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'model/model.dart';

class CategoriesRepository {
  Future<List<CatalogCategory>>? getCategories({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 11111));
    var list = List.generate(
      9,
      (index) => CatalogCategory(
        name: 'Root Category ${lorem(paragraphs: 1, words: 2).toLowerCase()}',
        description: lorem(paragraphs: 1, words: 9),
      )..inheritedCategories = List.generate(
          6,
          (index) => CatalogCategory(
            name: 'Secondary Category ${lorem(paragraphs: 1, words: 2).toLowerCase()}',
            description: lorem(paragraphs: 1, words: 9),
          ),
        ),
    );
    return list;
  }

  Future<List<CatalogCategory>> getInheritedCategories({required CatalogCategory category}) async {
    await Future.delayed(const Duration(milliseconds: 1111));
    return category.inheritedCategories;
  }
}
