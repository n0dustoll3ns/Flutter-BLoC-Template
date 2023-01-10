
import '../../../utils/urls.dart';

class TizerInfo {
  final String id;
  final String iconUrl;
  final String title;
  final String description;
  TizerInfo.fromJson(this.id, Map json)
      : iconUrl = "$tizersIconsUrl/$id/${json["icon"]}",
        title = json["title"],
        description = json["description"];
}
