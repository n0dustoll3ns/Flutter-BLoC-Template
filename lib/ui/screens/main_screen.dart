import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/authentication.dart';
import '../../features/authentication/auth_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: Text('logout'),
          onPressed: () {
            authenticationBloc.add(LoggedOut());
          },
        )),
      ),
    );
  }
}
