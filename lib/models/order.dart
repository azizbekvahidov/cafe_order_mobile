import 'package:cafe_mostbyte/models/product.dart';

class Order {
  int productId;
  int type;
  double amount;
  Product product;

  Order({
    required this.productId,
    required this.type,
    required this.amount,
    required this.product,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      productId: json["product_id"],
      type: json["type"],
      amount: double.parse(json["amount"].toString()),
      product: Product.fromJson(json["product"]),
    );
  }
}
