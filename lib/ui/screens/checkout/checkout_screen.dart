// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/checkout/checkout_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/checkout/components/payment_method_selector.dart';
import '../../../app/routes/routes.dart';
import 'components/adress_selector.dart';
import 'components/progress_indicator.dart';
import 'components/reciever_selector.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order checkout'),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
        return ListView(
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
            CheckoutProgress(
              currentIndex: state.stageIndex,
              stages: const ['Set \nreciever', 'Delivery \nservice', 'Payment \nmethod', 'Use \nbonuses'],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select reciever',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(Routes.recieversList);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            RecieverSelector(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select Adress',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(Routes.adressesList);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            AdressSelector(
              isAvailable: state.stageIndex >= 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select payment method',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
            PaymentMethodSelecor(
              isAvailable: state.stageIndex >= 2,
            )
          ],
        );
      }),
    );
  }
}
