import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';
import '../../../components/error_container.dart';
import '../../../components/loading_indicator.dart';
import '../components/avatar.dart';
import '../components/personal_data.dart';
import 'components/fields.dart';

class PersonalDataPage extends StatelessWidget {
  const PersonalDataPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
      if (state is AuthenticationUnauthenticated) {
        return const ErrorBox(message: 'You are ');
      } else if (state is AuthenticationFailed) {
        return ErrorBox(message: state.message);
      } else if (state is AuthenticationLoading) {
        return const LoadingIndicator();
      }
      state as AuthenticationAuthenticated;
      return Scaffold(
        appBar: AppBar(title: const Text('Personal Data')),
        body: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            const Avatar(),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            PersonalData(userData: state.userData),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            UserDataFields(userData: state.userData),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
          ],
        ),
      );
    });
  }
}
