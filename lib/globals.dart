library cafe_order.globals;

import 'package:flutter/material.dart';

const String apiLink = "http://127.0.0.1:8070/";
// String apiLink = "http://192.168.1.205/";

String font = "Raleway";
Color mainColor = Color(0xff0D335D);
Color secondaryColor = Color(0xffC70039);
Color thirdColor = Color(0xffC1A1D3);
Color fourthColor = Color(0xffFFF3E6);
bool isLogin = false;
Map<String, dynamic> userData;
String authName = "Aziz";
String code = "";
bool isOrder = false;
List tables;
