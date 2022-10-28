import 'package:flutter/material.dart';

import 'app/routes/routes.dart';
import 'app/theme/theme.dart';
import 'ui/screens/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      routes: Routes.routes,
      home: const SignInScreen(),
    );
  }
}
