import 'dart:convert';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import '../../../config/globals.dart' as globals;
import '../../../services/helper.dart' as helper;

class BotExpenseRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<Expense> addToExpense({DeliveryBot? data}) async {
    try {
      var body = data!.toJson();
      body.addAll({"user_id": globals.userData!.id});
      body.addAll({"filial_id": globals.filial});
      print(json.encode(body));
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
}
