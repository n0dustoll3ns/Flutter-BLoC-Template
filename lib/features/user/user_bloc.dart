import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/user_repository.dart';
import 'states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<Authorized>(loadPersonalData);
    on<EditUserDataButtonPressed>(editUserData);
  }

  Future<void> loadPersonalData(
    Authorized event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final userData = await userRepository.personalDataRequest(event.token);
      emit(UserDataLoaded(userData: userData));
    } catch (error) {
      emit(UserFailure(error: error.toString()));
    }
  }

  Future<void> editUserData(EditUserDataButtonPressed event, Emitter<UserState> emit) async {
    emit(UserLoading()); 
    try {
      final newUserData = await userRepository.personalDataEdit(event.token, event.newUserData);
      emit(UserDataLoaded(userData: newUserData));
    } catch (error) {
      emit(UserFailure(error: error.toString()));
    }
  }
}
