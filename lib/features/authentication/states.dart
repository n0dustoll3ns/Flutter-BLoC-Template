/* ---  States   --- */

import 'package:flutter_bloc_template/features/user/model.dart';

abstract class AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  UserData userData;
  String token;
  AuthenticationAuthenticated({required this.userData, required this.token});
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

class LoggedOut extends AuthenticationEvent {
  LoggedOut();
}

class EditUserDataButtonPressed extends AuthenticationEvent {
  final UserData newUserData;
  EditUserDataButtonPressed({required this.newUserData});
}

