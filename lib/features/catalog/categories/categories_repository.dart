import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'model/model.dart';

class CategoriesRepository {
  Future<List<Category>?> getInheritedCategories({required String token, int? categoryId}) async {
    List response = jsonDecode(await _readJson());

    var list = List.generate(
      response.length,
      (index) {
        return Category.fromJson(response[index]);
      },
    );
    return list;
  }

  Future<String> _readJson() async => await rootBundle.loadString('assets/backend/categories.json');
}
