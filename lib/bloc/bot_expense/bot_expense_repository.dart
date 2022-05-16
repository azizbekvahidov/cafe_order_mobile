import 'dart:convert';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/models/employee.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/models/tables.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import 'package:flutter/cupertino.dart';
import '../../../config/globals.dart' as globals;

class BotExpenseRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<Expense> addToExpense({DeliveryBot? data}) async {
    try {
      var body = data!.toJson();
      int sum = 0;
      data.listItem.every((element) {
        double currentSum = element.amount * element.product.price!;
        sum += (currentSum / 100).ceil() * 100;
        return true;
      });
      body.addAll({"user_id": globals.userData!.id});
      body.addAll({"filial_id": globals.filial});
      body.addAll({"expense_sum": sum});
      final response =
          await net.post('${globals.apiLink}expense/add-bot-order', body: body);
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return Expense.fromJson(res["data"]);
      } else {
        globals.currentExpense!.discount = 0;
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["message"];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Expense> addExpense({DeliveryBot? data}) async {
    try {
      globals.filial = data!.filial.id;
      globals.isBotOrder = data.id;
      var expense = Expense(
        id: 0,
        num: 0,
        order_date: "",
        print: 0,
        expense_sum: 0,
        comment: "",
        prepaid: 0,
        prepaidSum: 0,
        ready_time: "",
        phone: "",
        delivery: Delivery(
          phone: data.phone,
          address: data.address,
          comment: data.name,
          delivery_time: data.time,
        ),
        order_type: data.order_type,
        employee: Employee(
            employee_id: globals.userData!.id,
            check_percent: globals.userData!.check_percent,
            login: globals.userData!.login,
            name: globals.userData!.name),
        order: data.listItem
            .map((e) => Order(
                amount: e.amount,
                product: e.product,
                product_id: e.product_id,
                type: e.type))
            .toList(),
        table: Tables(id: 0, name: ""),
      );
      return expense;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> AddBotOrder() async {
    try {
      Map body = {
        'bot_order': globals.isBotOrder,
        'address': globals.currentExpense!.delivery!.address,
        'filial_id': globals.filial,
        'phone': globals.currentExpense!.delivery!.phone,
        'name': globals.currentExpense!.delivery!.comment,
        'price': globals.currentExpense!.delivery!.price,
        'time': globals.currentExpense!.delivery!.delivery_time,
        'order_type': globals.currentExpense!.order_type,
        'status': 1,
        'products': globals.currentExpense!.order
            .map((e) => {
                  "product_id": e.product_id,
                  "amount": e.amount,
                  "type": e.type,
                  "comment": e.comment,
                })
            .toList(),
      };
      final response =
          await net.post('${globals.apiLink}delivery/store', body: body);
      if (response.statusCode == 201) {
        debugPrint("ok");
      } else {
        globals.currentExpense!.discount = 0;
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["data"];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> CancelBotOrder() async {
    try {
      Map body = {
        'bot_order': globals.isBotOrder,
        'address': globals.currentExpense!.delivery!.address,
        'filial_id': globals.filial,
        'phone': globals.currentExpense!.delivery!.phone,
        'name': globals.currentExpense!.delivery!.comment,
        'price': globals.currentExpense!.delivery!.price,
        'time': globals.currentExpense!.delivery!.delivery_time,
        'order_type': globals.currentExpense!.order_type,
        'status': 0,
        'products': globals.currentExpense!.order
            .map((e) => {
                  "product_id": e.product_id,
                  "amount": e.amount,
                  "type": e.type,
                  "comment": e.comment,
                })
            .toList(),
      };
      final response =
          await net.post('${globals.apiLink}delivery/store', body: body);
      if (response.statusCode == 201) {
        debugPrint("ok");
      } else {
        globals.currentExpense!.discount = 0;
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["data"];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
