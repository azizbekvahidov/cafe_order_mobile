class User {
  int id;
  String first_name;
  String last_name;
  String patronymic;
  String birth_date;
  bool gcp_verified;
  String gender;
  String phone;
  String email;
  bool is_oneid;
  String address;

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.patronymic,
    required this.birth_date,
    required this.gcp_verified,
    required this.gender,
    required this.phone,
    required this.email,
    required this.is_oneid,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      patronymic: json["patronymic"],
      birth_date: json["birth_date"],
      gcp_verified: json["gcp_verified"],
      gender: json["gender"],
      phone: json["phone"],
      email: json["email"],
      is_oneid: json["is_oneid"],
      address: json["address"],
    );
  }
}
