import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentRedirectPage extends StatelessWidget {
  const PaymentRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 8)).then((_) => Navigator.of(context).pop());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
