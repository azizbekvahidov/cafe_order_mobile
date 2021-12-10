import 'package:cafe_mostbyte/models/product.dart';

class MenuItem {
  int id;
  int type;
  int category_id;
  Product product;

  MenuItem({
    required this.id,
    required this.type,
    required this.category_id,
    required this.product,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json["id"],
      type: json["type"],
      category_id: json["category_id"],
      product: Product.fromJson(json["product"]),
    );
  }
}
