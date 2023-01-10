import '../../../utils/urls.dart';
import 'banner_info.dart';

class MainBannerRepository {

  Future<List<BannerInfo>> loadMainBannersData() async {
    final response = await pb.collection('main_banners').getFullList();
    var banners =
        response.map((recordModel) => BannerInfo.fromJson(recordModel.id, recordModel.data)).toList();
    return banners;
  }
}
