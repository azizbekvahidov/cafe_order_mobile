class Settings {
  String cafe_name;
  String percent;
  String logo_image;
  String printer;
  String text_footer;

  Settings({
    required this.cafe_name,
    required this.percent,
    required this.logo_image,
    required this.printer,
    required this.text_footer,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      cafe_name: json["name"],
      percent: json["percent"],
      logo_image: json["logo_image"],
      printer: json["printer"],
      text_footer: json["text_footer"],
    );
  }
}
