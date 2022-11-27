import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';

import '../authentication/auth_bloc.dart';
import '../authentication/states.dart';
import '../user/states.dart';
import 'states.dart';
import '../authentication/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  final UserBloc userBloc;

  LoginBloc({required this.userRepository, required this.authenticationBloc, required this.userBloc})
      : super(LoginInitial()) {
    on<LoginButtonPressed>(onLoginPressed);
  }

  Future<void> onLoginPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emitter,
  ) async {
    emitter(LoginLoading());
    try {
      final token = await userRepository.authenticate(
        username: event.username,
        password: event.password,
      );
      authenticationBloc.add(LoggedIn(token: token));
      userBloc.add(Authorized(token: token));
      emitter(LoginInitial());
    } catch (error) {
      emitter(LoginFailure(error: error.toString()));
    }
  }
}
