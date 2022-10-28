import 'package:flutter/material.dart';

import '../../ui/screens/main_screen.dart';
import '../../ui/screens/sign_in_screen.dart';

class Routes {
  static const main = 'main';
  static const signIn = 'signIn';

  static final Map<String, Widget> _ways = {
    main: const MainScreen(),
    signIn: const SignInScreen(),
  };

  static final Map<String, WidgetBuilder> routes =
      _ways.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
