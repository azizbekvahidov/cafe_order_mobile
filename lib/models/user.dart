class User {
  int id;
  String name;
  String printer;
  int percent;
  List department;
  String cafe_name;

  User({
    required this.id,
    required this.name,
    required this.printer,
    required this.percent,
    required this.department,
    required this.cafe_name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      printer: json["printer"],
      percent: json["percent"],
      department: json["department"],
      cafe_name: json["cafe_name"],
    );
  }
}
