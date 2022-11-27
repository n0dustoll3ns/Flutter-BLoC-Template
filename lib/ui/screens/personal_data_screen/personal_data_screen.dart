import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/user/states.dart';

import '../main_screen/user_profile/components/avatar.dart';
import '../main_screen/user_profile/components/personal_data.dart';
import 'components/fields.dart';

class PersonalDataPage extends StatelessWidget {
  final UserData userData;
  const PersonalDataPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Data')),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 32),
          const Avatar(),
          SizedBox(height: MediaQuery.of(context).size.height / 32),
          PersonalData(userData: userData),
          SizedBox(height: MediaQuery.of(context).size.height / 32),
          const UserDataFields(),
          SizedBox(height: MediaQuery.of(context).size.height / 32),
        ],
      ),
    );
  }
}
