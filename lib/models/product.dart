import 'package:cafe_mostbyte/models/department.dart';

class Product {
  int id;
  String name;
  int? price;
  Department? department;
  String? image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.department,
    this.image = null,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    print("product");
    return Product(
      id: json["id"],
      name: json["name_uz"],
      price: json["price"] == null ? 0 : json["price"],
      department: json["department"] == null
          ? null
          : Department.fromJson(json["department"]),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "department_id": department == null ? null : department!.toJson(),
        "image": image,
      };
}
