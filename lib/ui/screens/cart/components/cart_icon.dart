import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        const Icon(Icons.shopping_cart_outlined),
        BlocBuilder<CartBloc, CartState>(
          builder: ((context, state) => AnimatedContainer(
                curve: Curves.bounceOut,
                margin: EdgeInsets.all(state.items.isEmpty ? 5.5 : 0),
                width: state.items.isEmpty ? 0 : 11,
                height: state.items.isEmpty ? 0 : 11,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                duration: const Duration(milliseconds: 567),
              )),
        ),
      ],
    );
  }
}
