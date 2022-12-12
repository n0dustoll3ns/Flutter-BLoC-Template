import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/checkout/checkout_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_bloc.dart';

class RecieverSelector extends StatelessWidget {
  const RecieverSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecieversBloc, RecieversState>(builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.width / 6,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            state.items.length,
            ((index) => InkWell(
                  onTap: () {
                    context.read<CheckoutBloc>().add(SetReciever(reciever: state.items[index]));
                  },
                  child: Card(
                    elevation: 5,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 366),
                      curve: Curves.ease,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: state.items[index].id == context.read<CheckoutBloc>().state.reciever?.id
                                  ? 1.5
                                  : 0,
                              color: state.items[index].id == context.read<CheckoutBloc>().state.reciever?.id
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent)),
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 44),
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 44,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                state.items[index].name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '+${state.items[index].phoneNumber}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey.withOpacity(0.77)),
                              ),
                            ],
                          ),
                        ],
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
