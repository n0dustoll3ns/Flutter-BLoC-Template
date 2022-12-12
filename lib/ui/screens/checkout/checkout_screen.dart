import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/progress_indicator.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order checkout'),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Switch between windows without leaving checkout',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close_rounded))
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 22),
          // ignore: prefer_const_constructors
          CheckoutProgress(
            currentIndex: 2,
            stages: ['My data', 'Delivery service', 'Payment method', 'Use bonuses'],
          ),
          
        ],
      ),
    );
  }
}
