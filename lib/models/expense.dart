import 'package:cafe_mostbyte/models/employee.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/models/table.dart';

class Expense {
  int id;
  String order_date;
  int print;
  int expense_sum;
  int? discount;
  String? ready_time;
  String? phone;
  Employee employee;
  Table? table;
  List<Order> order;

  Expense({
    required this.id,
    required this.order_date,
    required this.print,
    required this.expense_sum,
    this.discount = null,
    required this.ready_time,
    required this.phone,
    required this.employee,
    this.table = null,
    required this.order,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json["id"],
      order_date: json["order_date"],
      print: json["print"],
      expense_sum: json["expense_sum"],
      discount: json["discount"],
      ready_time: json["ready_time"],
      phone: json["phone"],
      employee: Employee.fromJson(json["employee"]),
      table: json["table"] != null ? Table.fromJson(json["table"]) : null,
      order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_date": order_date,
      'print': print,
      "expense_sum": expense_sum,
      "discount": discount,
      'ready_time': ready_time,
      'phone': phone,
      'employee': employee.toJson(),
      'table': table!.toJson(),
      "order": order.map((e) => e.toJson()).toList(),
    };
  }
}
