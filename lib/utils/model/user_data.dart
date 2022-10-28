abstract class UserDataState {
  final String? userLogin;
  const UserDataState({this.userLogin});
}

class UserDataInitialState extends UserDataState {
  const UserDataInitialState();
}

class UserDataLoadingState extends UserDataState {
  const UserDataLoadingState();
}

class UserDataErrorFetchDataState extends UserDataState {
  final String errorMessage;
  const UserDataErrorFetchDataState({
    required this.errorMessage,
  });
}

class UserDataSuccessFetchDataState extends UserDataState {
  const UserDataSuccessFetchDataState({
    required String login,
  }) : super(userLogin: login);
}

class FetchDataEvent {
  @override
  List<Object?> get props => [];

  const FetchDataEvent();
}
