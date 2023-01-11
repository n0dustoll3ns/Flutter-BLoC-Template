import '../../utils/urls.dart';

class Brand {
  final String name;
  final String id;
  final String? announce;
  final String? description;
  final String? imageUrl;

  Brand({required this.id, required this.name, this.imageUrl, this.announce, this.description});
  Brand.fromJson(this.id, Map json)
      : name = json["name"],
        announce = json["announce"],
        description = json["description"],
        imageUrl = "$brandsImagesUrl/$id/${json["image"]}";
}
