import 'dart:convert';

import 'package:cafe_mostbyte/models/order.dart';

class Expense {
  int id;
  String order_date;
  int expense_sum;
  int? discount;
  List<Order> order;

  Expense({
    required this.id,
    required this.order_date,
    required this.expense_sum,
    this.discount = null,
    required this.order,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json["id"],
      order_date: json["order_date"],
      expense_sum: json["expense_sum"],
      discount: json["discount"],
      order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    // print([order.map((e) => jsonEncode(e.toJson()))]);
    return {
      "id": id,
      "order_date": order_date,
      "expense_sum": expense_sum,
      "discount": discount,
      "order": order.map((e) => e.toJson()).toList(),
    };
  }
}
