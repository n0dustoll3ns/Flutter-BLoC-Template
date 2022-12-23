import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/model.dart';

class CategoriesRepository {
  Future<List<Category>?> getInheritedCategories({required String token, int? categoryId}) async {
    List<Category>? res;
    try {
      if (categoryId == null) {
        res = await _loadRootCategories(token: token);
      } else {
        res = await _loadInheritedCategories(token: token, categoryId: categoryId);
      }
    } on Exception catch (_) {}
    return res;
  }

  Future<List<Category>?> getPopularCategories({required String token}) async {
    List<Category>? res;
    try {
      res = await _loadRootCategories(token: token);
      res = res.sublist(1, 6);
    } on Exception catch (_) {}
    return res;
  }

  Future<List<Category>> _loadRootCategories({required String token}) async {
    List response = jsonDecode(await _readJson());

    var list = List.generate(
      response.length,
      (index) {
        return Category.fromJson(response[index]);
      },
    );
    return list;
  }

  Future<List<Category>> _loadInheritedCategories({required String token, required int categoryId}) async {
    List response = jsonDecode(await _readJson());

    var list = List.generate(
      response.length,
      (index) {
        return Category.fromJson(response[index]);
      },
    );
    return list;
  }

  Future<String> _readJson() async {
    var s = await rootBundle.loadString('assets/backend/categories.json');
    return s;
  }
}
