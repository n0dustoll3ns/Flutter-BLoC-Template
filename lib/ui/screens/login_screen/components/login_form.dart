import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/login/login.dart';
import '../../../../features/login/login_bloc.dart';
import '../../../widgets/loading_indicator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  bool dialogIsShown = false;

  @override
  void initState() {
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (dialogIsShown) {
          dialogIsShown = false;
          Navigator.of(context).pop();
        }
        if (state is LoginLoading) {
          dialogIsShown = true;
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => const CupertinoAlertDialog(
              content: LoadingIndicator(),
            ),
          );
        }
      },
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('username')),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('password')),
                controller: _passwordController,
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
                child: const Text('Login'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.add(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}
