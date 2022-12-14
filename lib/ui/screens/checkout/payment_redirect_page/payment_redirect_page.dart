import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/routes/routes.dart';
import '../../../../features/cart/cart_bloc.dart';

class PaymentRedirectPage extends StatelessWidget {
  const PaymentRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 8)).then((_) {
      context.read<CartBloc>().add(ClearCart());
      return Navigator.of(context).pushReplacement(Routes.checkoutCompletePage);
    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LottieBuilder.asset('assets/animations/payment.json'),
          Text(
            'In this page happens paying magic of your order. \nYou will automatocally be returned to in 5 sec',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
