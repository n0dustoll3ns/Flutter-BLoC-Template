import 'package:flutter/material.dart';

import '../../../../../features/catalog/products/model/crahacteristic.dart';

class CharacteristicLine extends StatelessWidget {
  final Property characteristic;
  const CharacteristicLine({super.key, required this.characteristic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${characteristic.name} — ',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
          ),
          Text(
            characteristic.value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
