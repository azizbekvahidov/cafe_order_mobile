import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:cafe_mostbyte/models/employee.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/models/table.dart';

class Expense {
  int id;
  String order_date;
  int print;
  int expense_sum;
  int discount;
  int? terminal;
  int prepaid;
  int? debt_payed;
  String comment;
  int prepaidSum;
  String? ready_time;
  String? phone;
  Employee employee;
  Table? table;
  List<Order> order;
  bool isChanged;
  Delivery? delivery;

  Expense({
    required this.id,
    required this.order_date,
    required this.print,
    required this.expense_sum,
    this.discount = 0,
    this.terminal = null,
    this.debt_payed = null,
    required this.comment,
    required this.prepaid,
    required this.prepaidSum,
    required this.ready_time,
    required this.phone,
    required this.employee,
    this.table = null,
    required this.order,
    this.isChanged = false,
    this.delivery,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json["id"],
      order_date: json["order_date"],
      print: json["print"],
      expense_sum: json["expense_sum"],
      discount: json["discount"],
      terminal: json["terminal"],
      prepaid: json["prepaid"],
      comment: json["comment"],
      debt_payed: json["debt_payed"],
      prepaidSum: json["prepaidSum"],
      ready_time: json["ready_time"],
      phone: json["phone"],
      employee: Employee.fromJson(json["employee"]),
      table: json["table"] != null ? Table.fromJson(json["table"]) : null,
      order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
      delivery:
          json["delivery"] != null ? Delivery.fromJson(json["delivery"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_date": order_date,
      'print': print,
      "expense_sum": expense_sum,
      "discount": discount,
      "terminal": terminal,
      "comment": comment,
      "prepaid": prepaid,
      "debt_payed": debt_payed,
      "prepaidSum": prepaidSum,
      'ready_time': ready_time,
      'phone': phone,
      'employee': employee.toJson(),
      'table': table != null ? table!.toJson() : 0,
      "order": order.map((e) => e.toJson()).toList(),
      "delivery": delivery != null ? delivery!.toJson() : null,
    };
  }
}
