import 'package:cafe_mostbyte/models/role.dart';

class User {
  int id;
  String name;
  String login;
  int check_percent;
  Role role;

  User(
      {required this.id,
      required this.name,
      required this.login,
      required this.check_percent,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      login: json["login"],
      check_percent: json["check_percent"],
      role: Role.fromJson(json["role"]),
    );
  }
}
