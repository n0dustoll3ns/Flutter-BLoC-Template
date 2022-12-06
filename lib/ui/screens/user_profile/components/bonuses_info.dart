import 'package:flutter/material.dart';

import '../../../../features/user/states.dart';

class BonusesInfo extends StatelessWidget {
  final UserData userData;
  const BonusesInfo({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '500',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(
                'Available bonuses to spend',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
        Container(
          width: 1,
          height: MediaQuery.of(context).size.height / 22,
          color: Colors.black38,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '365841',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(
                'Left to the next status',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
        Container(
          width: 1,
          height: MediaQuery.of(context).size.height / 22,
          color: Colors.black38,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '112',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(
                'Days left to status ends',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
      ],
    );
  }
}
