import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';
import 'user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository}) : super(AuthenticationUninitialized()) {
    on<AppStarted>(_startApp);
    on<LoggedIn>(_tryLogin);
    on<LoggedOut>(_logOut);
  }

  Future<void> _startApp(
    AppStarted event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final bool hasToken = await userRepository.hasToken();
    if (hasToken) {
      emitter(AuthenticationAuthenticated());
    } else {
      emitter(AuthenticationUnauthenticated());
    }
  }

  void _tryLogin(
    LoggedIn event,
    Emitter<AuthenticationState> emitter,
  ) {
    emitter(AuthenticationLoading());
    userRepository.persistToken(event.token);
    emitter(AuthenticationAuthenticated());
  }

  void _logOut(
    LoggedOut event,
    Emitter<AuthenticationState> emitter,
  ) async {
    emitter(AuthenticationLoading());
    await userRepository.deleteToken();
    emitter(AuthenticationUnauthenticated());
  }
}
