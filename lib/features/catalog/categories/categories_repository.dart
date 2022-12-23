import 'package:flutter_lorem/flutter_lorem.dart';

import 'model/model.dart';

class CategoriesRepository {
  Future<List<Category>?> getInheritedCategories({required String token, required Category category}) async {
    await Future.delayed(const Duration(milliseconds: 1111));
    var list = List.generate(
      9,
      (index) {
        return Category(
          name: 'Root Category ${lorem(paragraphs: 1, words: 2).toLowerCase()}',
          description: lorem(paragraphs: 1, words: 9),
        );
      },
    );
    return list;
  }
}
