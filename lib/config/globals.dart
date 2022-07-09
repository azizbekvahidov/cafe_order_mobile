library cafe_order.globals;

import 'package:cafe_mostbyte/models/change.dart';
import 'package:cafe_mostbyte/models/change_sum.dart';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/print_data.dart';
import 'package:cafe_mostbyte/models/settings.dart';
import 'package:cafe_mostbyte/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';

String apiLink = "https://cafe.mostbyte.uz/api/v1/";
// String apiLink = "https://api.kfcbeer.uz/api/v1/";

String lang = "ru";
var loc;
bool isAuth = false;
List? categories;
int filial = 0;
int currentExpenseId = 0;
int currentExpenseSum = 0;
bool currentExpenseChange = false;
Expense? currentExpense;
Delivery? expenseDelivery;
PrintData? orderState;
User? userData;
int? isBotOrder;
Settings? settings;
List<Department>? department;
bool isKassa = true;
Change? tempChange;
ChangeSum? tempChangeSum;
USBPrinterManager? manager;

String font = "Raleway";
Color mainColor = Color(0xff0D335D);
Color secondaryColor = Color(0xffC70039);
Color thirdColor = Color(0xffC1A1D3);
Color fourthColor = Color(0xffFFF3E6);
Map<String, String> headers = {
  "content-type": "application/json",
  'accept': 'application/json'
};
bool isLogin = false;
String authName = "Aziz";
String code = "";
bool isOrder = false;
List? tables;
String token = "";
int? id;

bool isServerConnection = false;
