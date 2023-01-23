class Adress {
  String buildingNumber;
  String streetName;
  String town;
  String zipCode;
  final String id;
  Adress({
    required this.id,
    required this.buildingNumber,
    required this.streetName,
    required this.town,
    required this.zipCode,
  });

  Adress.fromJson({required this.id, required Map json})
      : buildingNumber = json['building_number'],
        streetName = json['street_name'],
        town = json['town'],
        zipCode = json['zipcode'];
}
