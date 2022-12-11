import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/screens/about_shop/about_shop.dart';
import 'package:flutter_bloc_template/ui/screens/loyalty_program/loyalty_program_screen.dart';

import '../../ui/screens/main_screen.dart';
import '../../ui/screens/login_screen/login_screen.dart';
import '../../ui/screens/user_profile/recievers_list/recievers.dart';

class Routes {
  static final home = CupertinoPageRoute(builder: (context) => const MainScreen());
  static final signIn = CupertinoPageRoute(builder: (context) => const LoginPage());
  static final loyaltyProgramScreen = CupertinoPageRoute(builder: (context) => const LoyaltyProgramScreen());
  static final aboutShopScreen = CupertinoPageRoute(builder: (context) => const AboutShopScreen());
  static final recieversList = CupertinoPageRoute(builder: ((context) => const RecieversListScreen()));
}
