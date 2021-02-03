library cafe_order.globals;

import 'package:flutter/material.dart';

String font = "Raleway";
Color mainColor = Color(0xff0D335D);
Color secondaryColor = Color(0xffC70039);
Color thirdColor = Color(0xffC1A1D3);
Color fourthColor = Color(0xffFFF3E6);
bool isLogin = false;
String authName = "Aziz";
String code = "";
bool isOrder = false;

List<dynamic> orders = [
  {
    "id": 1,
    "name": "Узбекистан марочный конякУзбекистан марочный коняк",
    "price": 2000000,
    "cnt": 1,
  },
  {
    "id": 2,
    "name": "Узбекистан марочный конякУзбекистан марочный коняк",
    "price": 13000,
    "cnt": 4,
  },
  {
    "id": 4,
    "name": "Узбекистан марочный конякУзбекистан марочный коняк",
    "price": 30000,
    "cnt": 3,
  },
];
double totalSum;
getTotal() {
  double sum = 0;

  orders.forEach((element) {
    sum += element["price"] * element["cnt"];
  });
  return sum;
}
