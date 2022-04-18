class Tables {
  int id;
  String name;

  Tables({
    required this.id,
    required this.name,
  });

  factory Tables.fromJson(Map<String, dynamic> json) {
    return Tables(
      id: json["table_id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
