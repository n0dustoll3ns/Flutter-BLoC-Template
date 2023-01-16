import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/utils/string_capitalize.dart';

import '../../../../features/user/states.dart';

class PersonalData extends StatelessWidget {
  final UserData userData;
  const PersonalData({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 22),
      child: Column(
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
            'Status ${userData.customerStatus.toString().toCapitalized()} allows you to accumulate 10% from every purchase as bonuses',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
