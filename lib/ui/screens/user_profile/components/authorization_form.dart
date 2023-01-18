import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/styles/constants.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';
import '../../../components/loading_indicator.dart';
import 'sign_up_offer.dart';

class AuthorizationForm extends StatefulWidget {
  final bool accentAuthorize;
  const AuthorizationForm({super.key, required this.accentAuthorize});

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
      return AnimatedContainer(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height / 55),
        duration: shakeDuration,
        curve: Curves.bounceInOut,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 33),
            border: Border.all(
              width: widget.accentAuthorize ? 5 : 0,
              color: widget.accentAuthorize ? Colors.red : Colors.transparent,
            )),
        child: ShakeWidget(
          duration: shakeDuration,
          autoPlay: widget.accentAuthorize,
          shakeConstant: ShakeLittleConstant1(),
          child: Form(
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
                const SignUpOfferSection()
              ],
            ),
          ),
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
