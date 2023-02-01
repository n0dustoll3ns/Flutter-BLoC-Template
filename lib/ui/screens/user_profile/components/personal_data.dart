import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/utils/string_capitalize.dart';

import '../../../../features/user/model.dart';

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
            userData.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            userData.customerStatus.toString().toCapitalized(),
            style: Theme.of(context).textTheme.displaySmall,
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
