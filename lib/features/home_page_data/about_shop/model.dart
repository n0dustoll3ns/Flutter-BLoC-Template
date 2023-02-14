import '../../../utils/urls.dart';

class AboutShopData {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  const AboutShopData({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  AboutShopData.fromJson(this.id, Map json)
      : imageUrl = "$aboutShopImagesUrl/$id/${json["image"]}",
        title = json["title"],
        description = json["description"];
}
