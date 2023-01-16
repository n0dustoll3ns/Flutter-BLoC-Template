import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';

import '../authentication/user_repository.dart';
import 'states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository = UserRepository();
  final AuthenticationBloc authenticationBloc;
  UserBloc({required this.authenticationBloc}) : super(UserInitial()) {
    on<Authorized>(loadPersonalData);
    on<EditUserDataButtonPressed>(editUserData);
  }

  void loadPersonalData(
    Authorized event,
    Emitter<UserState> emit,
  ) async {
    emit(UserDataLoaded(userData: event.userData));
  }

  Future<void> editUserData(EditUserDataButtonPressed event, Emitter<UserState> emit) async {
    var authState = authenticationBloc.state;
    if (authState is AuthenticationAuthenticated) {
      emit(UserLoading());
      try {
        final newUserData = await repository.personalDataEdit(authState.token, event.newUserData);
        emit(UserDataLoaded(userData: newUserData));
      } catch (error) {
        emit(UserFailure(error: error.toString()));
      }
    }
  }
}
