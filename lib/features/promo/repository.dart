import '../../utils/urls.dart';
import 'model.dart';

class PromoRepository {
  Future<List<Promo>> loadAllPromos() async {
    final response = await pb.collection('promo').getFullList();
    var banners = response.map((recordModel) => Promo.fromJson(recordModel.id, recordModel.data)).toList();
    return banners;
  }

  Future<List<Promo>> loadMainPagePromos(int page) async {
    final response = await pb.collection('promo').getList(page: page, perPage: 2);
    var banners =
        response.items.map((recordModel) => Promo.fromJson(recordModel.id, recordModel.data)).toList();
    return banners;
  }
}
