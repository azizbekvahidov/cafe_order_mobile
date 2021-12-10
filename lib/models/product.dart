class Product {
  int id;
  String name;
  int price;
  int departmentId;
  String? image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.departmentId,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name_uz"],
      price: json["price"],
      departmentId: json["department_id"],
      image: json["image"],
    );
  }
}
