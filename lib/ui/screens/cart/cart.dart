import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/app/routes/routes.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/cart/components/item_card.dart';

import '../../../app/routes/constants.dart';
import '../../components/menu_button.dart';
import '../catalog/item_page/components/recommended_items.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainPageSections[2]),
        actions: [
          IconButton(
              onPressed: () {
                context.read<CartBloc>().add(ClearCart());
              },
              icon: const Icon(Icons.cleaning_services_rounded)),
          const MenuButton(),
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(state.itemsCounted.length, (index) {
                var item = state.itemsCounted.keys.toList()[index];
                return Dismissible(
                  background: Container(color: Colors.redAccent),
                  onDismissed: (DismissDirection direction) =>
                      context.read<CartBloc>().add(RemoveItem(item: item)),
                  key: ValueKey(index),
                  child: ItemCard(
                    item: item,
                    count: state.itemsCounted[item]!,
                  ),
                );
              }),
            );
          }),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 8),
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 12),
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 8)),
              child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        Text(
                          '\$${state.totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${state.items.length} items',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                        const Spacer(),
                        Text(
                          '\$${state.totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          'Promo code',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                        const Spacer(),
                        Text(
                          '- \$10',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CupertinoTextField(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      controller: TextEditingController(text: 'Spring 2023'),
                    ),
                    const Spacer(),
                    Text(
                      'This promo code gives you discount \$10',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                child: const Text('Checkout'),
                onPressed: () {
                  if (context.read<CartBloc>().state.items.isEmpty) {
                    final snackBar = SnackBar(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 44),
                      content: Row(
                        children: [
                          const Expanded(child: Text('Your cart is empty!')),
                          TextButton(
                              style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColor),
                              onPressed: () {
                                context.read<BottomNavBarBloc>().add(SetBottomNavBarIndex(index: 1));
                                ScaffoldMessenger.of(context).clearSnackBars();
                              },
                              child: const Text('Let\'s shopping'))
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    if (context.read<AuthenticationBloc>().state is AuthenticationAuthenticated) {
                      Navigator.of(context).pushNamed(Routes.checkOut);
                    } else {
                      context.read<BottomNavBarBloc>().add(SetBottomNavBarIndex(index: 4));
                      var snackBar = const SnackBar(
                        content: Text('You must have been authenticated'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                }),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: RecomendedItems(product: null),
          ),
        ],
      ),
    );
  }
}
