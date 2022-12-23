/* ---  States   --- */

abstract class AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  String token;
  AuthenticationAuthenticated({required this.token});
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationUnauthenticated {
  String message;
  AuthenticationFailed({required this.message});
}

/* ---  Events   --- */

abstract class AuthenticationEvent {
  AuthenticationEvent([List props = const []]);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoginButtonPressed extends AuthenticationEvent {
  final String userName;
  final String password;
  LoginButtonPressed({required this.userName, required this.password});
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  LoggedIn({
    required this.token,
  }) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
