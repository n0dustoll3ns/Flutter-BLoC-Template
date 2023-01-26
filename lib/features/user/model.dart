import '../../utils/urls.dart';

class UserData {
  final String id;
  final String userLogin;
  String name;
  String email;
  final String? avatarUrl;
  String? phone;
  DateTime? bDay;
  Status customerStatus;
  List<String> cartItemIds;
  UserData({
    required this.id,
    required this.userLogin,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.bDay,
    required this.customerStatus,
    required this.cartItemIds,
  });

  UserData.fromJson(this.id, Map json)
      : userLogin = json["username"],
        name = json["name"],
        email = json["email"],
        avatarUrl = json["avatar"].isNotEmpty ? '$userDataFilesUrl/$id/${json["avatar"]}' : null,
        phone = json["phone"],
        bDay = DateTime.tryParse(json['bDay']),
        customerStatus = Status.values.singleWhere((element) => element.toString() == json['status']),
        cartItemIds = List.from(json['cart_items']);

  Map<String, dynamic> get toJson => {
        "username": userLogin,
        "name": name,
        "email": email,
        "phone": phone,
        'bDay': bDay.toString(),
        'status': customerStatus.toString(),
        'cart_items': cartItemIds,
      };
}

enum Status {
  standart,
  gold,
  silver;

  @override
  String toString() => name;
}
