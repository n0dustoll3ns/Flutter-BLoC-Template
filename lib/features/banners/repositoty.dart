import 'package:pocketbase/pocketbase.dart';

import 'banner_info.dart';

class MainBannerRepository {
  PocketBase pb = PocketBase('https://pocketbase.dancheg97.ru');

  Future<List<BannerInfo>> loadMainBannersData() async {
    final response = await pb.collection('main_banners').getFullList();
    var banners = response.map((recordModel) => BannerInfo.fromJson(json: recordModel.data)).toList();
    return banners;
  }
}
