class Settings {
  String cafe_name;
  String percent;
  String? logo_image;
  String printer;
  String printerKassa;
  String text_footer;
  String discount;

  Settings({
    required this.cafe_name,
    required this.percent,
    this.logo_image = null,
    required this.printer,
    required this.printerKassa,
    required this.text_footer,
    required this.discount,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      cafe_name: json["name"],
      percent: json["percent"],
      logo_image: json["logo_image"],
      printer: json["printer"],
      printerKassa: json["printerKassa"],
      text_footer: json["text_footer"],
      discount: json["discount"],
    );
  }
}
