import 'package:flutter_bloc_template/utils/urls.dart';

import 'model.dart';

class BrandsRepository {
  Future<Brand> singleBrandInfo(String id) async {
    var brandModel = await pb.collection('brands').getOne(id);
    return Brand.fromJson(brandModel.id, brandModel.data);
  }

  Future<List<Brand>> mainPageBrandsInfo() async {
    var brandModels = await pb.collection('brands').getFullList(filter: 'show_on_main_page = true');
    return brandModels.map((e) => Brand.fromJson(e.id, e.data)).toList();
  }
}
