class Product {
  int id;
  String name;
  int price;
  int department_id;
  String? image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.department_id,
    this.image = null,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name_uz"],
      price: json["price"],
      department_id: json["department_id"],
      image: json["image"],
    );
  }
}
