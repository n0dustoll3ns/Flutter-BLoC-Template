import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/payment/methods/payment_methods.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import '../../../app/routes/routes.dart';
import '../../../features/adresses/adresses_bloc.dart';
import '../../../features/authentication/auth_bloc.dart';
import '../../../features/authentication/states.dart';
import '../main_screen.dart';
import 'components/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late BuildContext dialogContext = context;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          initializeUserData(context, state.token);
          return const MainScreen();
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Login'),
          ),
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: LoginForm(),
          ),
        );
      },
    );
  }

  void initializeUserData(BuildContext context, String token) {
    context.read<RecieversBloc>().add(Authorized(token: token));
    context.read<AdressesBloc>().add(AuthComplete(token: token));
    context.read<PaymentMethodsBloc>().add(AllowLoadPaymentMethods());
  }
}
