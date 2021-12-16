import 'package:cafe_mostbyte/models/department.dart';

class Product {
  int id;
  String name;
  int price;
  Department department;
  String? image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.department,
    this.image = null,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name_uz"],
      price: json["price"],
      department: Department.fromJson(json["department"]),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "department_id": department.toJson(),
        "image": image,
      };
}
