/* ---  States   --- */

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserDataLoaded extends UserState {
  final UserData userData;
  UserDataLoaded({required this.userData});
}

class UserFailure extends UserState {
  final String error;

  const UserFailure({required this.error});

  @override
  String toString() => 'UserFailure { error: $error }';
}

/* ---  Events   --- */

abstract class UserEvent {
  const UserEvent();
}

class Authorized extends UserEvent {
  final String token;

  const Authorized({
    required this.token,
  });

  @override
  String toString() => 'UserButtonPressed {}';
}

class EditUserDataButtonPressed extends UserEvent {
  final String token;
  final UserData newUserData;
  EditUserDataButtonPressed({required this.token, required this.newUserData});
}

class UserData {
  final String userLogin;
  String firstName;
  String lastName;
  String email;
  int mobile;
  DateTime bDay;
  Status customerStatus;
  UserData({
    required this.userLogin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.bDay,
    required this.customerStatus,
  });
}

enum Status {
  standart,
  gold,
  silver;

  @override
  String toString() => name;
}
