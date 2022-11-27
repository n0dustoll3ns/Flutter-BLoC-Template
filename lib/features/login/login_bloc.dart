import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/auth_bloc.dart';
import '../authentication/states.dart';
import 'states.dart';
import '../authentication/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.userRepository, required this.authenticationBloc}) : super(LoginInitial()) {
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
      emitter(LoginInitial());
    } catch (error) {
      emitter(LoginFailure(error: error.toString()));
    }
  }
}
