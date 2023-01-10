import 'package:flutter/cupertino.dart';

import '../../../utils/urls.dart';

class SecondaryBannerInfo {
  final String id;
  final String imageUrl;
  final String? header;
  final String title;
  final bool isBig;
  final String? routeName;
  final RouteSettings? routeSettings;
  final int? moveToTab;
  SecondaryBannerInfo.fromJson(this.id, Map json)
      : imageUrl = "$secondaryBannerFilesUrl/$id/${json["image"]}",
        header = json["header"],
        title = json["title"],
        isBig = json["isBig"],
        routeName = json["route_name"],
        routeSettings =
            json["route_settings"] != null ? RouteSettings(arguments: json["route_settings"]) : null,
        moveToTab = json["move_to_tab"];
}
