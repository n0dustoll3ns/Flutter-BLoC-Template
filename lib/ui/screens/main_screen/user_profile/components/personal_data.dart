import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/utils/string_capitalize.dart';

import '../../../../../features/user/states.dart';

class PersonalData extends StatelessWidget {
  final UserData userData;
  const PersonalData({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${userData.firstName} ${userData.lastName}',
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          userData.customerStatus.toString().toCapitalized(),
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          'Status ${userData.customerStatus.toString().toCapitalized()} позволяет накапливать 10% бонусами с каждоый покупки',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
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
        )
      ],
    );
  }
}
