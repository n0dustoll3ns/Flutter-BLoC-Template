import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/checkout/checkout_bloc.dart';
import 'package:flutter_bloc_template/features/payment/methods/payment_methods.dart';

class PaymentMethodSelecor extends StatelessWidget {
  final bool isAvailable;

  const PaymentMethodSelecor({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.width / 6,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            state.items.length,
            ((index) => Opacity(
                  opacity: !isAvailable ? 0.5 : 1,
                  child: InkWell(
                    onTap: isAvailable
                        ? () => context
                            .read<CheckoutBloc>()
                            .add(SetPaymentMethod(paymentMethod: state.items[index]))
                        : null,
                    child: Card(
                      elevation: 5,
                      child: AnimatedContainer(
                        width: MediaQuery.of(context).size.width / 1.5,
                        duration: const Duration(milliseconds: 366),
                        curve: Curves.ease,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: state.items[index].id ==
                                        context.read<CheckoutBloc>().state.paymentMethod?.id
                                    ? 1.5
                                    : 0,
                                color: state.items[index].id ==
                                        context.read<CheckoutBloc>().state.paymentMethod?.id
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent)),
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 44),
                        child: Row(
                          children: [
                            Icon(state.items[index].icon),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 44,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    state.items[index].name,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    state.items[index].description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.grey.withOpacity(0.77)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      );
    });
  }
}
