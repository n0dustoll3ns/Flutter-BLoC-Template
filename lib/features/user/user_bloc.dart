import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/user_repository.dart';
import 'states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<Authorized>(loadPersonalData);
  }

  Future<void> loadPersonalData(
    Authorized event,
    Emitter<UserState> emitter,
  ) async {
    emitter(UserLoading());
    try {
      final userData = await userRepository.personalDataRequest(event.token);
      emitter(UserDataLoaded(userData: userData));
    } catch (error) {
      emitter(UserFailure(error: error.toString()));
    }
  }
}
