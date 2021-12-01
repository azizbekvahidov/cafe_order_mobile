library cafe_order.globals;

import 'package:cafe_mostbyte/models/user.dart';
import 'package:flutter/material.dart';

String apiLink = "";
// String apiLink = "http://localhost:3007/";

String lang = "ru";
var loc;
bool isAuth = false;
String font = "Raleway";
Color mainColor = Color(0xff0D335D);
Color secondaryColor = Color(0xffC70039);
Color thirdColor = Color(0xffC1A1D3);
Color fourthColor = Color(0xffFFF3E6);
Map<String, String> headers = {"content-type": "application/json"};
bool isLogin = false;
User? userData;
String authName = "Aziz";
String code = "";
bool isOrder = false;
List? tables;
String token = "";
List? department;

bool isServerConnection = false;
