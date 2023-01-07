import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';

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
      emitter(AuthenticationAuthenticated(authData: AdminAuth()));
    } else {
      emitter(AuthenticationUnauthenticated());
    }
  }

  Future<void> _tryAuthorize(LoginButtonPressed event, Emitter<AuthenticationState> emitter) async {
    emitter(AuthenticationLoading());
    try {
      var adminAuth = await userRepository.authenticate(username: event.userName, password: event.password);
      if (adminAuth != null) {
        emitter(AuthenticationAuthenticated(authData: adminAuth));
      } else {
        emitter(AuthenticationFailed(message: 'failed'));
      }
    } on Exception catch (e) {
      emitter(AuthenticationFailed(message: e.toString()));
    }
  }

  void _login(LoggedIn event, Emitter<AuthenticationState> emitter) {
    emitter(AuthenticationLoading());
    userRepository.persistToken(event.token);
    emitter(AuthenticationAuthenticated(authData: AdminAuth()));
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
