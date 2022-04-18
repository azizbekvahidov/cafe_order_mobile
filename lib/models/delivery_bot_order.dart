import 'package:cafe_mostbyte/models/delivery_bot_item.dart';
import 'package:cafe_mostbyte/models/filial.dart';

class DeliveryBotOrder {
  int id;
  String name;
  String phone;
  String? time;
  String? price;
  String? address;
  String order_type;

  DeliveryBotOrder({
    required this.id,
    required this.phone,
    this.time,
    this.price,
    required this.name,
    required this.address,
    required this.order_type,
  });

  factory DeliveryBotOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryBotOrder(
      id: json["id"],
      phone: json["phone"],
      time: json["time"],
      price: json["price"],
      name: json["name"],
      address: json["address"],
      order_type: json["order_type"],
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
      };
}
