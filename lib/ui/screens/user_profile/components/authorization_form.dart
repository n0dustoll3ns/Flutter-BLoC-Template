import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';
import '../../../components/loading_indicator.dart';

class AuthorizationForm extends StatefulWidget {
  const AuthorizationForm({super.key});

  @override
  State<AuthorizationForm> createState() => _AuthorizationFormState();
}

class _AuthorizationFormState extends State<AuthorizationForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(listener: (context, state) {
      if (state is AuthenticationFailed) _showMessageInSnackBar(state.message);
    }, builder: (context, state) {
      return Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Via email',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 44),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 77),
              child: TextFormField(
                decoration: const InputDecoration(label: Text('username')),
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 77),
              child: TextFormField(
                decoration: const InputDecoration(label: Text('password')),
                controller: _passwordController,
                obscureText: true,
              ),
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
    });
  }

  void _showMessageInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  _onLoginButtonPressed() {
    context.read<AuthenticationBloc>().add(LoginButtonPressed(
          userName: _usernameController.text,
          password: _passwordController.text,
        ));
  }
}
