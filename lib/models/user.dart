class User {
  int id;
  String name;
  String login;
  int check_percent;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.check_percent,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      login: json["login"],
      check_percent: json["check_percent"],
    );
  }
}
