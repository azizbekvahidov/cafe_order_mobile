import 'package:cafe_mostbyte/models/delivery_bot_item.dart';

class DeliveryBot {
  int id;
  String name;
  String phone;
  String address;
  String order_type;
  List<DeliveryBotItem> listItem;

  DeliveryBot({
    required this.id,
    required this.phone,
    required this.name,
    required this.address,
    required this.order_type,
    required this.listItem,
  });

  factory DeliveryBot.fromJson(Map<String, dynamic> json) {
    return DeliveryBot(
        id: json["id"],
        phone: json["phone"],
        name: json["name"],
        address: json["address"],
        order_type: json["order_type"],
        listItem: List<DeliveryBotItem>.from(
            json["deliveryItem"].map((x) => DeliveryBotItem.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "name": name,
        'address': address,
        'order_type': order_type,
        "deliveryItem": listItem.map((e) => e.toJson()).toList(),
      };
}
