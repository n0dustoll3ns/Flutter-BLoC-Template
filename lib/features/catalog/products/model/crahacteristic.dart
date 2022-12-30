class Property {
  final String name;
  final String value;

  Property({
    required this.name,
    required this.value,
  });

  Property.fromJson(Map json)
      : name = json['name'],
        value = json['name'];
}
