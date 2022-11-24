import 'package:flutter/material.dart';

import '../../../../app/routes/constants.dart';
import '../../../components/menu_button.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mainPageSections[2]),
          actions: const [MenuButton()],
        ),
        body: const Center(child: Text("Cart")));
  }
}
