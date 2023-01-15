import '../../utils/urls.dart';
import '../catalog/products/model/product.dart';
import 'model.dart';

class PromoRepository {
  Future<List<Promo>> loadAllPromos() async {
    final response = await pb.collection('promo').getFullList();
    var promotionModels =
        response.map((recordModel) => Promo.fromJson(recordModel.id, recordModel.data)).toList();
    return promotionModels;
  }

  Future<List<Promo>> loadMainPagePromos(int page) async {
    final response = await pb.collection('promo').getList(page: page, perPage: 2, expand: 'products');
    var promotionModels =
        response.items.map((recordModel) => Promo.fromJson(recordModel.id, recordModel.data)).toList();
    return promotionModels;
  }

  Future<List<Promo>> loadPromosOf(Product product) async {
    var filter = 'products ~ "${product.id}"';
    final response = await pb.collection('promo').getFullList(filter: filter);
    var promotionModels =
        response.map((recordModel) => Promo.fromJson(recordModel.id, recordModel.data)).toList();
    return promotionModels;
  }
}
