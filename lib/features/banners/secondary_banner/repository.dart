import '../../../utils/urls.dart';
import 'secondary_banner.dart';

class SecondaryBannerRepository {
  Future<List<SecondaryBannerInfo>> loadSecondaryBannersData() async {
    final response = await pb.collection('secondary_banners').getFullList();
    var banners = response
        .map((recordModel) => SecondaryBannerInfo.fromJson(recordModel.id, recordModel.data))
        .toList();
    return banners;
  }
}
