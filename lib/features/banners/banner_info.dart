import 'package:flutter/cupertino.dart';

class BannerInfo {
  final String backgroundUrl;
  final String? foregroundUrl;
  final String announce;
  final String? description;
  final String? buttonText;
  final String? routeName;
  final RouteSettings? routeSettings;
  final int? moveToTab;
  BannerInfo.fromJson({required Map json})
      : backgroundUrl = json["background"],
        foregroundUrl = json["foreground"],
        announce = json["announce"],
        description = json["description"],
        buttonText = json["button_text"],
        routeName = json["routeName"],
        routeSettings = RouteSettings(arguments: json["route_settings"]),
        moveToTab = json["moveToTab"];
}
