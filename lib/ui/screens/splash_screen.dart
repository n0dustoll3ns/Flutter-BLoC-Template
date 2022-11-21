import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/widgets/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text('Splash Screen'),
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
