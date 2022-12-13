import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/checkout/components/item_line.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.read<CartBloc>().state;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Delivery by shop • ${cart.items.length} items • 1,36 kg',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
              ),
            ),
            Text(
              '\$${cart.totalPrice.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 66),
        ...List.generate(
            cart.itemsCounted.length,
            (index) => ItemLine(
                item: cart.itemsCounted.keys.toList()[index],
                count: cart.itemsCounted.values.toList()[index])),
      ],
    );
  }
}
