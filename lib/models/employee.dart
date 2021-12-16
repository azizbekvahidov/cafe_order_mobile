import 'package:flutter/foundation.dart';

class Employee {
  int employee_id;
  String login;
  String name;
  int check_percent;

  Employee({
    required this.employee_id,
    required this.login,
    required this.name,
    required this.check_percent,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employee_id: json["id"],
      login: json["login"],
      name: json["name"],
      check_percent: json["check_percent"],
    );
  }

  Map<String, dynamic> toJson() => {
        "employee_id": employee_id,
        "login": login,
        "name": name,
        'check_percent': check_percent,
      };
}
