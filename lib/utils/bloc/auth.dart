import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/utils/model/user_data.dart';

class AuthBloc extends Bloc<FetchDataEvent, UserDataState> {
  AuthBloc() : super(const UserDataInitialState()) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  void _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<UserDataState> emitter,
  ) async {
    emitter(const UserDataLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    bool isSucceed = Random().nextBool();
    if (isSucceed) {
      String dummyLogin = 'Dave';
      emitter(UserDataSuccessFetchDataState(login: dummyLogin));
    } else {
      emitter(const UserDataErrorFetchDataState(
        errorMessage: "something went very wrong :(",
      ));
    }
  }
}

class AuthEvent {}
