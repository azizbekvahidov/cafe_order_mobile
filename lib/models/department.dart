import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/foundation.dart';

class Department {
  int department_id;
  String printer;
  String name;
  List<Order>? orders;

  Department({
    required this.department_id,
    required this.printer,
    required this.name,
    this.orders = null,
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
        'orders':
            orders != null ? orders!.map((e) => e.toJson()).toList() : null,
      };
}
