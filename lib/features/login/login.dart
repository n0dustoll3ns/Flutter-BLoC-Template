/* ---  States   --- */

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  String toString() => 'LoginFailure { error: $error }';
}

/* ---  Events   --- */

abstract class LoginEvent {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    required this.username,
    required this.password,
  });

  @override
  String toString() => 'LoginButtonPressed { username: $username, password: $password }';
}
