import 'package:flutter/material.dart';

import '../../features/authentication/user_repository.dart';
import '../../ui/screens/main_screen/main_screen.dart';
import '../../ui/screens/login_screen/login_screen.dart';

class Routes {
  static const home = 'main';
  static const signIn = 'signIn';

  static final Map<String, Widget> _ways = {
    home: MainScreen(),
    signIn: LoginPage(),
  };

  static final Map<String, WidgetBuilder> routes =
      _ways.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
