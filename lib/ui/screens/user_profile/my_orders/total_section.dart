import 'package:flutter/material.dart';

import '../../../../features/order/model.dart';

class TotalSection extends StatelessWidget {
  final Order order;
  const TotalSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '\$${order.totalCost.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items, ${order.items.length} pieces',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
                ),
                Text(
                  '\$${(order.totalCost - 30).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promo-code',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
                ),
                Text(
                  '0',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment method',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
                ),
                Text(
                  '-\$10',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bonuses',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
                ),
                Text(
                  '-\$20',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
