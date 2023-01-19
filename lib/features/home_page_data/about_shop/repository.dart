import 'package:flutter_bloc_template/features/home_page_data/about_shop/model.dart';
import 'package:flutter_bloc_template/utils/urls.dart';

class AboutShopDataRepository {
  Future<AboutShopData> load() async {
    var res = await pb.collection('about_shop').getFirstListItem('');
    return AboutShopData.fromJson(res.id, res.data);
  }
}
