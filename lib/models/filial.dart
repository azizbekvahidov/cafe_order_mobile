class Filial {
  int id;
  String name;

  Filial({
    required this.id,
    required this.name,
  });

  factory Filial.fromJson(Map<String, dynamic> json) {
    return Filial(
      id: json["id"],
      name: json["name_uz"],
    );
  }
}
