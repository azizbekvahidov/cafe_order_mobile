import 'package:cafe_mostbyte/models/change_sum.dart';
import 'package:cafe_mostbyte/models/employee.dart';
import 'package:cafe_mostbyte/models/filial.dart';

class Change {
  int id;
  Employee employee;
  int status;
  String start;
  String? end;
  int? change_sum;
  Filial filial;

  Change({
    required this.id,
    required this.employee,
    required this.status,
    required this.start,
    this.end,
    this.change_sum,
    required this.filial,
  });

  factory Change.fromJson(Map<String, dynamic> json) {
    return Change(
      id: json["id"],
      employee: Employee.fromJson(json["employee_id"]),
      status: json["status"],
      start: json["start_time"],
      end: json["end_time"],
      change_sum: json["sum"],
      filial: Filial.fromJson(json["filial"]),
    );
  }
}
