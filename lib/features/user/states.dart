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
  final UserData userData;

  const Authorized({required this.userData});

  @override
  String toString() => 'UserButtonPressed {}';
}

class EditUserDataButtonPressed extends UserEvent {
  final UserData newUserData;
  EditUserDataButtonPressed({required this.newUserData});
}

class UserData {
  final String id;
  final String userLogin;
  String name;
  String email;
  final String? avatarUrl;
  String? phone;
  DateTime? bDay;
  Status customerStatus;
  UserData({
    required this.id,
    required this.userLogin,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.bDay,
    required this.customerStatus,
  });

  UserData.fromJson(this.id, Map json)
      : userLogin = json["username"],
        name = json["name"],
        email = json["email"],
        avatarUrl = json["avatar"],
        phone = json["phone"],
        bDay = DateTime.tryParse(json['bDay']),
        customerStatus = Status.values.singleWhere((element) => element.toString() == json['status']);

  Map<String, dynamic> get toJson => {
        "username": userLogin,
        "name": name,
        "email": email,
        "phone": phone,
        'bDay': bDay.toString(),
        'status': customerStatus.toString(),
      };
}

enum Status {
  standart,
  gold,
  silver;

  @override
  String toString() => name;
}
