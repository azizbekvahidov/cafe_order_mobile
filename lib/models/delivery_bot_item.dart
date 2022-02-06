import 'package:cafe_mostbyte/models/product.dart';

class DeliveryBotItem {
  int product_id;
  double amount;
  int type;
  Product product;

  DeliveryBotItem({
    required this.product_id,
    required this.amount,
    required this.type,
    required this.product,
  });

  factory DeliveryBotItem.fromJson(Map<String, dynamic> json) {
    return DeliveryBotItem(
      product_id: json["product_id"],
      amount: double.parse(json["amount"].toString()),
      type: json["type"],
      product: Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": product_id,
        "amount": amount,
        "type": type,
      };
}
