class Role {
  int id;
  String name;
  String role;

  Role({
    required this.id,
    required this.name,
    required this.role,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json["id"],
      name: json["name"],
      role: json["role"],
    );
  }
}
