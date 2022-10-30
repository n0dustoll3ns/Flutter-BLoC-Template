import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/login/login.dart';
import '../../../../features/login/login_bloc.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  const LoginForm({
    Key? key,
    required this.loginBloc,
    required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
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
