import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';
import 'user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();

  AuthenticationBloc() : super(AuthenticationUnauthenticated()) {
    on<AppStarted>(_startApp);
    on<LoginButtonPressed>(_tryAuthorize);
    on<LoggedIn>(_login);
    on<LoggedOut>(_logOut);
  }

  Future<void> _startApp(
    AppStarted event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final bool hasToken = await userRepository.hasToken();
    if (hasToken) {
      emitter(AuthenticationAuthenticated(token: ''));
    } else {
      emitter(AuthenticationUnauthenticated());
    }
  }

  Future<void> _tryAuthorize(LoginButtonPressed event, Emitter<AuthenticationState> emitter) async {
    emitter(AuthenticationLoading());
    var token = await userRepository.authenticate(username: event.userName, password: event.password);
    if (token != null) {
      emitter(AuthenticationAuthenticated(token: token));
    } else {
      emitter(AuthenticationFailed(message: 'failed'));
    }
  }

  void _login(LoggedIn event, Emitter<AuthenticationState> emitter) {
    emitter(AuthenticationLoading());
    userRepository.persistToken(event.token);
    emitter(AuthenticationAuthenticated(token: event.token));
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
