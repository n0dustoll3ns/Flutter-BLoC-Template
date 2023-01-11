class Brand {
  final String name;
  final String id;
  final String? announce;
  final String? description;
  final String? img;

  Brand({required this.id, required this.name, this.img, this.announce, this.description});
  Brand.fromJson(this.id, Map json)
      : name = json["name"],
        announce = json["announce"],
        description = json["description"],
        img = json["img"];
}
