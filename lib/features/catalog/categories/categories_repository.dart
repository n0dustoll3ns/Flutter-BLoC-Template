import 'package:pocketbase/pocketbase.dart';

import 'model/model.dart';

class CategoriesRepository {
  PocketBase pb = PocketBase('http://10.0.2.2:8090');
  Future<List<Category>?> getInheritedCategories({required String token, String? parentCategoryId}) async {
    List<Category>? res;

    try {
      if (parentCategoryId == null) {
        res = await _loadRootCategories();
      } else {
        res = await _loadInheritedCategories(parentCategoryId: parentCategoryId);
      }
    } on Exception catch (_) {}
    return res;
  }

  Future<List<Category>?> getPopularCategories() async {
    List<Category>? res;
    try {
      res = await _loadRootCategories();
      res = res.sublist(1, 6);
    } on Exception catch (_) {}
    return res;
  }

  Future<List<Category>> _loadRootCategories() async {
    final resultList = await pb.collection('categories').getList(
          filter: 'parent = null',
        );
    List<Category> categories = [];
    for (var model in resultList.items) {
      categories.add(Category.fromJson(model.id, model.data));
    }
    return categories;
  }

  Future<List<Category>> _loadInheritedCategories({required String parentCategoryId}) async {
    final resultList = await pb.collection('categories').getList(
          filter: 'parent = $parentCategoryId',
        );
    List<Category> categories = [];
    for (var model in resultList.items) {
      categories.add(Category.fromJson(model.id, model.data));
    }
    return categories;
  }
}
