import 'package:flutter/material.dart';

class CartIcon extends StatefulWidget {
  final int count;
  const CartIcon({super.key, required this.count});

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        ScaleTransition(
          scale: _animation,
          child: Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Text(widget.count.toString()),
          ),
        ),
        const Icon(Icons.shopping_cart_outlined),
      ],
    );
  }
}
