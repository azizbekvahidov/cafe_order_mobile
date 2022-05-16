import 'package:cafe_mostbyte/models/delivery_bot_item.dart';
import 'package:cafe_mostbyte/models/filial.dart';

class DeliveryBot {
  int id;
  String name;
  String phone;
  String? time;
  int? price;
  String? address;
  String order_type;
  Filial filial;
  List<DeliveryBotItem> listItem;

  DeliveryBot({
    required this.id,
    required this.phone,
    this.time,
    this.price,
    required this.name,
    required this.address,
    required this.order_type,
    required this.listItem,
    required this.filial,
  });

  factory DeliveryBot.fromJson(Map<String, dynamic> json) {
    return DeliveryBot(
      id: json["id"],
      phone: json["phone"],
      time: json["time"],
      price: json["price"],
      name: json["name"],
      address: json["address"],
      order_type: json["order_type"],
      listItem: List<DeliveryBotItem>.from(
          json["deliveryItem"].map((x) => DeliveryBotItem.fromJson(x))),
      filial: Filial.fromJson(json["filial"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "name": name,
        'time': time,
        'price': price,
        'address': address,
        'order_type': order_type,
        "deliveryItem": listItem.map((e) => e.toJson()).toList(),
      };
}
