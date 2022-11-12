import 'package:flutter_lorem/flutter_lorem.dart';

import 'model/model.dart';

class CategoriesRepository {
  Future<Category>? getRootCategory({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 1111));
    var res = Category(
      name: 'Root Category ${lorem(paragraphs: 1, words: 2).toLowerCase()}',
      description: lorem(paragraphs: 1, words: 9),
    );
    res.inheritedCategories = await getInheritedCategories(token: token, category: res);

    return res;
  }

  Future<List<Category>>? getCategories({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 11111));
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

  Future<List<Category>> getInheritedCategories({required String token, required Category category}) async {
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
