import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/components/error_dialog.dart';
import 'package:flutter_bloc_template/utils/model/user_data.dart';

import '../../app/routes/routes.dart';
import '../../utils/bloc/auth.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AuthBloc>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<AuthBloc, UserDataState>(
            listener: ((context, state) {}),
            builder: ((context, state) {
              if (state is UserDataLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserDataErrorFetchDataState) {
                Future.delayed(
                  Duration.zero,
                ).then((value) => errorDialog(context));
              }
              if (state is UserDataSuccessFetchDataState) {
                Future.delayed(
                  Duration.zero,
                ).then((value) => Navigator.of(context).pushReplacementNamed(Routes.main));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(),
                  TextFormField(),
                  ElevatedButton(
                      onPressed: () {
                        bloc.add(FetchDataEvent());
                      },
                      child: const Text('Sign in'))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
