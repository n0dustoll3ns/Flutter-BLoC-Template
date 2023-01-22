class Reciever {
  final String id;
  String name;
  int phoneNumber;
  Reciever({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });
  Reciever.fromJson({required this.id, required Map json})
      : name = json['name'],
        phoneNumber = int.parse(json['phone_number']);
}
