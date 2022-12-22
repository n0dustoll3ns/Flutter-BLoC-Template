import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/payment/methods/payment_methods.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_bloc.dart';
import '../../../app/routes/routes.dart';
import '../../../features/adresses/adresses_bloc.dart';
import '../../../features/authentication/auth_bloc.dart';
import '../../../features/authentication/states.dart';
import 'components/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            Navigator.of(context).pushReplacementNamed(Routes.home);
            context.read<RecieversBloc>().add(Authorized(token: state.token));
            context.read<AdressesBloc>().add(AuthComplete(token: state.token));
            context.read<PaymentMethodsBloc>().add(AllowLoadPaymentMethods());
          }
        },
        builder: ((context, state) {
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
        }));
  }
}
