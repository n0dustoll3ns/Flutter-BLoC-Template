class Characteristic {
  final String name;
  final String value;

  Characteristic({
    required this.name,
    required this.value,
  });

  Characteristic.fromJson(Map json)
      : name = json['name'],
        value = json['name'];
}
