import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/cart/components/item_card.dart';

import '../../../app/routes/constants.dart';
import '../../components/menu_button.dart';

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
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return ListView(children: [
            ...List.generate(state.itemsCounted.length, (index) {
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
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 8),
              child: Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 12),
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 8)),
                child: Column(
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(child: const Text('Checkout'), onPressed: () {}),
            )
          ]);
        }));
  }
}
