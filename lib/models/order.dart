import 'package:cafe_mostbyte/models/product.dart';

class Order {
  int product_id;
  int type;
  double amount;
  Product product;

  Order({
    required this.product_id,
    required this.type,
    required this.amount,
    required this.product,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      product_id: json["product_id"],
      type: json["type"],
      amount: double.parse(json["amount"].toString()),
      product: Product.fromJson(json["product"]),
    );
  }
}
