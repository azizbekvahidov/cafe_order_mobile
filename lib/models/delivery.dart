import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Delivery {
  int? delivery_id;
  String? phone;
  String? delivery_time;
  String? address;
  String? comment;
  int? price;

  Delivery({
    this.delivery_id,
    this.phone,
    this.delivery_time,
    this.address,
    this.comment,
    this.price,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      delivery_id: json["delivery_id"],
      phone: json["phone"],
      delivery_time: json["delivery_time"],
      address: json["address"],
      comment: json["comment"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "delivery_id": delivery_id,
        "phone": phone,
        "delivery_time": delivery_time.toString(),
        'address': address,
        'comment': comment,
        'price': price,
      };
}
