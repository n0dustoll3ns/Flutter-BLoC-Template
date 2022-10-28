import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen.dart';

class Routes {
  static const main = 'main';

  static final Map<String, Widget> _ways = {
    main: const MainScreen(),
  };

  static final Map<String, WidgetBuilder> routes =
      _ways.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
