library cafe_order.globals;

import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/print_data.dart';
import 'package:cafe_mostbyte/models/settings.dart';
import 'package:cafe_mostbyte/models/user.dart';
import 'package:flutter/material.dart';

String apiLink = "http://takes/api/v1/";
// String apiLink = "http://localhost:3007/";

String lang = "ru";
var loc;
bool isAuth = false;
List? categories;
int filial = 1;
int currentExpenseId = 0;
int currentExpenseSum = 0;
Expense? currentExpense;
PrintData? orderState;
User? userData;
Settings? settings;
List<Department>? department;
bool isKassa = true;

String font = "Raleway";
Color mainColor = Color(0xff0D335D);
Color secondaryColor = Color(0xffC70039);
Color thirdColor = Color(0xffC1A1D3);
Color fourthColor = Color(0xffFFF3E6);
Map<String, String> headers = {"content-type": "application/json"};
bool isLogin = false;
String authName = "Aziz";
String code = "";
bool isOrder = false;
List? tables;
String token = "";
int? id;

bool isServerConnection = false;
