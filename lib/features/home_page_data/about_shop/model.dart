
import '../../../utils/urls.dart';

class AboutShopData {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  AboutShopData.fromJson(this.id, Map json)
      : imageUrl = "$aboutShopImagesUrl/$id/${json["image"]}",
        title = json["title"],
        description = json["description"];
}
