import 'package:flutter/foundation.dart';

class Table {
  int id;
  String name;

  Table({
    required this.id,
    required this.name,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json["table_id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
