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
    List response = jsonDecode(await _readCatalogJson());
    var list = List.generate(response.length, (index) => Category.fromJson(response[index]));
    list = list.sublist(0, 14);
    return list;
  }

  Future<List<Category>> _loadInheritedCategories({required String token, required int categoryId}) async {
    List? response = jsonDecode(await _readCatalogJson());
    if (response != null) {
      Category category = Category.fromJson(response.singleWhere((element) => element['id'] == categoryId));
      List? objects =
          response.where((element) => category.inheritedCategoryIds.contains(element['id'])).toList();
      var list = List.generate(objects.length, (index) => Category.fromJson(objects[index]));
      return list;
    } else {
      return [];
    }
  }

  Future<String> _readCatalogJson() async {
    var s = await rootBundle.loadString('assets/backend/categories.json');
    return s;
  }
}
