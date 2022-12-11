import 'package:flutter/material.dart';

class CarouselDots extends StatelessWidget {
  final int activeDotIndex;
  final int dotsCount;
  const CarouselDots({super.key, required this.activeDotIndex, required this.dotsCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            dotsCount,
            (index) => AnimatedContainer(
                  margin: const EdgeInsets.all(25),
                  width: index == activeDotIndex ? 10 : 5,
                  height: index == activeDotIndex ? 10 : 5,
                  decoration: BoxDecoration(
                    color: index == activeDotIndex ? Theme.of(context).primaryColor : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  duration: const Duration(milliseconds: 450),
                )),
      ),
    );
  }
}
