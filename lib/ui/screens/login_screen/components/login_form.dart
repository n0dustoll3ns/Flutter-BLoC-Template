import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';

import '../../../components/loading_indicator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailed) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      },
      builder: (BuildContext context, AuthenticationState state) {
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
              state is AuthenticationLoading
                  ? const LoadingIndicator()
                  : ElevatedButton(
                      onPressed: _onLoginButtonPressed,
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
    context.read<AuthenticationBloc>().add(LoginButtonPressed(
          userName: _usernameController.text,
          password: _passwordController.text,
        ));
  }
}
