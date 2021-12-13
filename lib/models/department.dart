import 'package:flutter/foundation.dart';

class Department {
  int department_id;
  String printer;
  String name;

  Department({
    required this.department_id,
    required this.printer,
    required this.name,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      department_id: json["department_id"],
      printer: json["printer"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "department_id": department_id,
        "printer": printer,
        "name": name,
      };
}
