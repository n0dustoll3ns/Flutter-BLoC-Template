import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/user/states.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';

import '../../../../components/error_container.dart';
import '../../../../widgets/loading_indicator.dart';
import '../components/avatar.dart';
import '../components/personal_data.dart';
import 'components/fields.dart';

class PersonalDataPage extends StatelessWidget {
  final UserData userData;
  const PersonalDataPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const ErrorBox(message: 'Somethig went wrong');
      } else if (state is UserFailure) {
        return ErrorBox(message: state.error);
      } else if (state is UserLoading) {
        return const LoadingIndicator();
      }
      state as UserDataLoaded;
      return Scaffold(
        appBar: AppBar(title: const Text('Personal Data')),
        body: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            const Avatar(),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            PersonalData(userData: userData),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            UserDataFields(userData: state.userData),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
          ],
        ),
      );
    });
  }
}
