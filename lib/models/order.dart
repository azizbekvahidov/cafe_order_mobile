import 'dart:convert';

import 'package:cafe_mostbyte/models/product.dart';

class Order {
  int product_id;
  int type;
  double amount;
  String? comment;
  Product? product;

  Order({
    required this.product_id,
    required this.type,
    required this.amount,
    this.comment = null,
    required this.product,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      product_id: json["product_id"],
      type: json["type"],
      amount: double.parse(json["amount"].toString()),
      comment: json["comment"],
      product: Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": product_id,
        "type": type,
        "amount": amount,
        "comment": comment,
        "product": product != null ? product!.toJson() : null,
      };
}
