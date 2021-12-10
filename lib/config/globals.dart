library cafe_order.globals;

import 'package:cafe_mostbyte/models/settings.dart';
import 'package:cafe_mostbyte/models/user.dart';
import 'package:flutter/material.dart';

String apiLink = "http://87.237.234.154/api/v1/";
// String apiLink = "http://localhost:3007/";

String lang = "ru";
var loc;
bool isAuth = false;
List? categories;
int filial = 1;
int currentExpenseId = 0;
int currentExpenseSum = 0;

String font = "Raleway";
Color mainColor = Color(0xff0D335D);
Color secondaryColor = Color(0xffC70039);
Color thirdColor = Color(0xffC1A1D3);
Color fourthColor = Color(0xffFFF3E6);
Map<String, String> headers = {"content-type": "application/json"};
bool isLogin = false;
User? userData;
Settings? settings;
String authName = "Aziz";
String code = "";
bool isOrder = false;
List? tables;
String token = "";
int? id;
List? department;

bool isServerConnection = false;
