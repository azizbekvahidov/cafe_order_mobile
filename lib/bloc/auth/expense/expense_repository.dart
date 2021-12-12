import 'dart:convert';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import '../../../config/globals.dart' as globals;
import '../../../services/helper.dart' as helper;

class ExpenseRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();
  Future<String?> createExpense() async {
    try {
      var data = {"user_id": globals.userData!.id, "filial_id": globals.filial};
      final response =
          await net.post('${globals.apiLink}expense/create', body: data);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        globals.currentExpenseSum = result["data"]['id'];
        return result["data"];
      } else {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["message"];
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> updateExpense() async {
    try {
      var data = globals.currentExpense!.toJson();
      print(data);
      final response =
          await net.post('${globals.apiLink}expense/update', body: data);
      if (response.statusCode == 200) {
      } else {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["message"];
      }
    } catch (e) {
      return e.toString();
    }
  }
}
