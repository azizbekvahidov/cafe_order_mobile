library yoshlar_portali.helper;

import 'package:cafe_mostbyte/components/order_footer.dart';
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
      double currentSum = element.amount * element.product.price;
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
      position: StyledToastPosition(align: Alignment.topCenter, offset: 0.0),
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: 4),
      //Animation duration   animDuration * 2 <= duration
      animDuration: Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      backgroundColor: Theme.of(context).backgroundColor,
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.error,
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
