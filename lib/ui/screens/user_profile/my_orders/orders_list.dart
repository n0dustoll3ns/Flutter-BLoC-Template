import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/order/orders_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/my_orders/order_tile.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var list = context.read<OrdersBloc>().state.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My orders'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: ListView(
        children: [
          ...List.generate(list.length, (index) => OrderTile(order: list[index])),
        ],
      ),
    );
  }
}
