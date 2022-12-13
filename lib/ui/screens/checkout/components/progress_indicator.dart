import 'package:flutter/material.dart';

class CheckoutProgress extends StatelessWidget {
  final List<String> stages;
  final int currentIndex;
  const CheckoutProgress({super.key, required this.stages, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    print(currentIndex);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: List.generate(
                  stages.length - 1,
                  (index) => Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 460),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: index > currentIndex - 1 ? Colors.grey : Theme.of(context).primaryColor,
                      ),
                      height: 5,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  stages.length,
                  (index) => Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 460),
                      height: index == currentIndex ? 25 : 15,
                      width: index == currentIndex ? 25 : 15,
                      decoration: BoxDecoration(
                        border: index == currentIndex
                            ? Border.fromBorderSide(
                                BorderSide(width: 5, color: Theme.of(context).primaryColor))
                            : null,
                        shape: BoxShape.circle,
                        color: index > currentIndex ? Colors.grey : Theme.of(context).primaryColor,
                      ),
                      child: Center(
                          child: AnimatedContainer(
                        duration: const Duration(milliseconds: 460),
                        height: index == currentIndex ? 12 : 0,
                        width: index == currentIndex ? 12 : 0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == currentIndex ? Colors.grey : Colors.transparent,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width / 22),
        Row(
          children: List.generate(
            stages.length,
            (index) => Expanded(
              child: Text(
                stages[index],
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
