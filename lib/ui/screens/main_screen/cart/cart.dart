import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/cart/components/item_card.dart';

import '../../../../app/routes/constants.dart';
import '../../../components/menu_button.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mainPageSections[2]),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.cleaning_services_rounded)),
            MenuButton(),
          ],
        ),
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return ListView(
              children: List.generate(state.items.length, (index) => ItemCard(item: state.items[index])));
        }));
  }
}
