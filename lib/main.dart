import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/authentication.dart';

import 'app/routes/routes.dart';
import 'app/theme/theme.dart';
import 'features/authentication/auth_bloc.dart';
import 'features/authentication/user_repository.dart';
import 'features/login/login_bloc.dart';
import 'ui/screens/login_screen/login_screen.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/widgets/loading_indicator.dart';

void main() {
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: ((context) => authenticationBloc)),
        BlocProvider<LoginBloc>(
          create: ((context) => LoginBloc(
                userRepository: userRepository,
                authenticationBloc: authenticationBloc,
              )),
        ),
      ],
      child: MaterialApp(
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            }
            if (state is AuthenticationLoading) {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => const CupertinoAlertDialog(
                  content: LoadingIndicator(),
                ),
              );
            }
          },
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            return LoginPage(key: UniqueKey(), userRepository: userRepository);
          },
        ),
      ),
    );
  }
}
