import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/screens/loyalty_program/loyalty_program_screen.dart';

import '../../ui/screens/main_screen.dart';
import '../../ui/screens/login_screen/login_screen.dart';

class Routes {
  static const home = 'main';
  static const signIn = 'signIn';
  static const loyaltyProgramScreen = 'loyaltyProgramScreen';

  static final Map<String, Widget> _ways = {
    home: const MainScreen(),
    signIn: const LoginPage(),
    loyaltyProgramScreen: const LoyaltyProgramScreen(),
  };

  static final Map<String, WidgetBuilder> routes =
      _ways.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
