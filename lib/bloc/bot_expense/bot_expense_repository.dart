import 'dart:convert';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import '../../../config/globals.dart' as globals;
import '../../../services/helper.dart' as helper;

class BotExpenseRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<String?> discountExpense() async {
    try {
      if (globals.currentExpense != null) {
        if (globals.currentExpense!.phone != null) {
          var data = {
            "id": globals.currentExpenseId,
            "discount": globals.currentExpense!.discount,
          };

          final response =
              await net.post('${globals.apiLink}expense/discount', body: data);
          if (response.statusCode == 200) {
          } else {
            globals.currentExpense!.discount = 0;
            var res = json.decode(utf8.decode(response.bodyBytes));
            return res["message"];
          }
        } else {
          throw Exception("");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
