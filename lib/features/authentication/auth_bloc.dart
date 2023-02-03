import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/user/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../app/routes/constants.dart';
import 'states.dart';
import 'user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository repository = UserRepository();

  // AndroidOptions _getAndroidOptions() => const AndroidOptions(
  //       encryptedSharedPreferences: true,
  //     );

  AuthenticationBloc() : super(AuthenticationUnauthenticated()) {
    on<AppStarted>(_startApp);
    on<LoginButtonPressed>(_tryAuthorize);
    on<LoggedOut>(_logOut);
    on<EditUserDataButtonPressed>(_editUserData);
  }
  final flutterSecureStorage = const FlutterSecureStorage();

  Future<void> _startApp(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      var mayBeToken = await flutterSecureStorage.read(
        key: secureStorageTokenKey,
      );
      RecordAuth authData;
      if (mayBeToken != null) {
        authData = await repository.authRefresh(mayBeToken);
      } else {
        emit(AuthenticationUnauthenticated());
        return;
      }
      emit(AuthenticationAuthenticated(
          token: authData.token, userData: UserData.fromJson(authData.record!.id, authData.record!.data)));
    } on Exception catch (_) {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _tryAuthorize(LoginButtonPressed event, Emitter<AuthenticationState> emitter) async {
    emitter(AuthenticationLoading());
    try {
      var authData = await repository.authenticate(username: event.userName, password: event.password);
      emitter(AuthenticationAuthenticated(
          token: authData.token, userData: UserData.fromJson(authData.record!.id, authData.record!.data)));
      const FlutterSecureStorage().write(key: secureStorageTokenKey, value: authData.token);
    } on Exception catch (e) {
      emitter(AuthenticationFailed(message: e.toString()));
    }
  }

  Future<void> _logOut(
    LoggedOut event,
    Emitter<AuthenticationState> emitter,
  ) async {
    try {
      repository.logOut();
      flutterSecureStorage.delete(key: secureStorageTokenKey);
      emitter(AuthenticationUnauthenticated());
    } on Exception catch (_) {
      // TODO
    }
  }

  Future<void> _editUserData(
    EditUserDataButtonPressed event,
    Emitter<AuthenticationState> emitter,
  ) async {
    // try {
    //   repository.logOut();
    //   emitter(AuthenticationUnauthenticated());
    // } on Exception catch (_) {
    //   // TODO
    // }
  }
}
