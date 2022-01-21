import 'package:cafe_mostbyte/models/department.dart';

class PrintData {
  int? expense_id;
  String? table;
  String? employee;
  List<Department>? departments;

  PrintData({
    this.employee = null,
    this.expense_id = null,
    this.table = null,
    this.departments = null,
  });

  Map<String, dynamic> toJson() => {
        "expense_id": expense_id,
        "table": table,
        "employee": employee,
        'departments': departments != null
            ? departments!.map((e) => e.toJson()).toList()
            : null,
      };
}
