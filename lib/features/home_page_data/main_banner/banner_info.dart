import '../../../utils/urls.dart';

class BannerInfo {
  final String id;
  final String backgroundUrl;
  final String? foregroundUrl;
  final String announce;
  final String? description;
  final String? buttonText;
  final String? routeName;
  final Map? routeSettings;
  BannerInfo.fromJson(this.id, Map json)
      : backgroundUrl = "$mainBannerFilesUrl/$id/${json["background"]}",
        foregroundUrl = "$mainBannerFilesUrl/$id/${json["foreground"]}",
        announce = json["announce"],
        description = json["description"],
        buttonText = json["button_text"],
        routeName = json["route_name"],
        routeSettings = json["route_settings"] != null ? Map.from(json["route_settings"]) : null;
}
