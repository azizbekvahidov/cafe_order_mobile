library yoshlar_portali.helper;

import 'dart:convert';

import 'package:cafe_mostbyte/components/order_footer.dart';
import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/models/print_data.dart';
import 'package:cafe_mostbyte/models/product.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../config/globals.dart' as globals;

String removeTag({required htmlString, strLength}) {
  var document = parse(htmlString);
  String parsedString = parse(document.body!.text).documentElement!.text;
  if (strLength != null) {
    parsedString = (parsedString.length >= strLength)
        ? "${parsedString.substring(0, strLength)}..."
        : parsedString;
  }
  return parsedString;
}

void calculateTotalSum() {
  var sum = 0;
  if (globals.currentExpense != null) {
    globals.currentExpense!.order.every((element) {
      double currentSum = element.amount * element.product!.price!;
      sum += (currentSum / 100).ceil() * 100;
      return true;
    });
    globals.currentExpense!.expense_sum = sum;
  }
  globals.currentExpenseSum = sum;
  orderFooterPageState.setState(() {});
}

void getToast(msg, BuildContext context) {
  showToast(msg,
      context: context,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      position: StyledToastPosition(align: Alignment.topCenter, offset: 60.0),
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: 4),
      //Animation duration   animDuration * 2 <= duration
      animDuration: Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      backgroundColor: Theme.of(context).colorScheme.error,
      textStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
      ),
      reverseCurve: Curves.fastOutSlowIn);
}

String getStrPart({required str, strLength = 50}) {
  if (strLength != null) {
    str = (str.length >= strLength) ? "${str.substring(0, strLength)}..." : str;
  }
  return str;
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

saveData(key, value, {type = 'string'}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool res = false;
  switch (type) {
    case 'string':
      res = await prefs.setString(key, value);
      break;
    case 'int':
      res = await prefs.setInt(key, value);
      break;
    case 'double':
      res = await prefs.setDouble(key, value);
      break;
    case 'bool':
      res = await prefs.setBool(key, value);
      break;
  }
  return res;
}

getData(key, {type = 'string'}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var res;
  switch (type) {
    case 'string':
      res = await prefs.getString(
        key,
      );
      break;
    case 'int':
      res = await prefs.getInt(key);
      break;
    case 'double':
      res = await prefs.getDouble(key);
      break;
    case 'bool':
      res = await prefs.getBool(key);
      break;
  }
  return res;
}

checkData(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool res = prefs.containsKey(key);
  return res;
}

deleteData(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

List sortListMap(List data) {
  return data;
}

String mapToString(Map map) {
  String str = "";
  if (map.isNotEmpty) {
    for (var item in map.entries) {
      str += "&${item.key}=${item.value}";
    }
  }
  return str;
}

unformatDateTime(dateStr) {
  DateFormat dateF = DateFormat('dd.MM.yyyy HH.mm');
  String res = dateF.format(DateTime.parse(
      DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUTC(dateStr).toString()));
  return res;
}

unformatDate(dateStr) {
  DateFormat dateF = DateFormat('dd.MM.yyyy');
  String res = dateF.format(
      DateTime.parse(DateFormat('yyyy-MM-dd').parseUTC(dateStr).toString()));
  return res;
}

Map<String, dynamic> parseSettings(List data) {
  Map<String, dynamic> res = {};
  data.forEach((element) {
    res.addAll({element["setting_name"]: element["setting_value"]});
  });
  return res;
}

generateCheck(
    {required Product data, required type, required amount, comment = null}) {
  if (globals.orderState == null) {
    PrintData orderState = new PrintData(
        expense_id: globals.currentExpense!.id,
        employee: globals.currentExpense!.employee.name,
        table: globals.currentExpense!.table != null
            ? globals.currentExpense!.table!.name
            : "С собой",
        departments: [
          Department(
              department_id: data.department.department_id,
              printer: data.department.printer,
              name: data.department.name,
              orders: [
                Order(
                    product_id: data.id,
                    type: type,
                    amount: double.parse(amount.toString()),
                    comment: comment,
                    product: data)
              ])
        ]);
    globals.orderState = orderState;
  } else {
    Department? s = globals.orderState!.departments!.firstWhere((e) {
      return e.department_id == data.department.department_id;
    }, orElse: () {
      return Department(
        department_id: data.department.department_id,
        printer: data.department.printer,
        name: data.department.name,
        orders: null,
      );
    });
    if (s.orders == null) {
      s.orders = [
        Order(
            product_id: data.id,
            type: type,
            amount: double.parse(amount.toString()),
            comment: comment,
            product: data)
      ];
      globals.orderState!.departments!.add(s);
    } else {
      Order order = s.orders!.firstWhere(
          (element) => element.product_id == data.id && element.type == type,
          orElse: () => Order(
              product_id: data.id,
              type: type,
              amount: 0.0,
              product: data,
              comment: comment));
      if (order.amount == 0.0) {
        order.amount += amount;
        order.comment = comment;
        s.orders!.add(order);
      } else {
        order.amount += amount;
        order.comment = comment;
      }
    }
  }

  // if (globals.orderState.containsKey("data")) {
  //   if (globals.orderState["data"].containsKey(data.department.name)) {
  //     var cur_item =
  //         globals.orderState["data"][data.department.name].firstWere((element) {
  //       return element["product_id"] == data.id && element["type"] == type;
  //     }, orElse: () {
  //       Map record = {
  //         "amount": amount,
  //         "product_id": data.id,
  //         "type": type,
  //         "name": data.name,
  //         "comment": comment,
  //       };
  //       globals.orderState["data"][data.department.name].addAll(record);
  //     });
  //     if (cur_item) {
  //       var sum = (cur_item["amount"] + amount) as double;
  //       sum = double.parse(sum.toStringAsFixed(1));
  //       globals.orderState["data"][data.department.name]["amount"] = sum;
  //     }
  //   } else {
  //     Map record = {
  //       data.department.name: [
  //         {
  //           "amount": amount,
  //           "product_id": data.id,
  //           "type": type,
  //           "name": data.name,
  //           "comment": comment,
  //         }
  //       ]
  //     };
  //     globals.orderState["data"].addAll(record);
  //   }
  // } else {
  //   Map record = {
  //     "data": {
  //       data.department.name: {
  //         [
  //           {
  //             "amount": amount,
  //             "product_id": data.id,
  //             "type": type,
  //             "name": data.name,
  //             "comment": comment,
  //           }
  //         ]
  //       }
  //     }
  //   };
  //   globals.orderState.addAll(record);
  // }
}
