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
