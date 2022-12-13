import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 33),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 33),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total without discount:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '\$${context.read<CartBloc>().state.totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Container(height: 2, color: Colors.grey),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery: ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '\$15',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Container(height: 5, color: Colors.grey),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total to pay',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '\$${(context.read<CartBloc>().state.totalPrice - 15).toStringAsFixed(2)}',
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
