import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';

class CheckoutCompletePage extends StatelessWidget {
  const CheckoutCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout complete'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Order is processed ',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'You can check info about your order in personal data section',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                context.read<BottomNavBarBloc>().add(SetBottomNavBarIndex(index: 4));
              },
              child: const Text('Go to profile'))
        ],
      ),
    );
  }
}
