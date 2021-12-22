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
        globals.currentExpenseId = result["data"]['id'];
        globals.currentExpenseSum = result["data"]['expense_sum'];
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
      final response =
          await net.post('${globals.apiLink}expense/update', body: data);
      if (response.statusCode == 200) {
        await sendCheck();
      } else {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["message"];
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> closeExpense() async {
    try {
      if (globals.currentExpense != null) {
        final response = await net.post(
            '${globals.apiLink}expense/close/${globals.currentExpense!.id}',
            body: {});
        if (response.statusCode == 200) {
          globals.currentExpense = null;
          globals.orderState = null;
          globals.currentExpenseId = 0;
          globals.currentExpenseSum = 0;
        } else {
          var res = json.decode(utf8.decode(response.bodyBytes));
          return res["message"];
        }
      } else {
        throw Exception("");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> terminalCloseExpense() async {
    try {
      if (globals.currentExpense != null) {
        var data = globals.currentExpense!.toJson();
        print(json.encode(data));
        final response = await net
            .post('${globals.apiLink}expense/terminalClose', body: data);
        if (response.statusCode == 200) {
          globals.currentExpense = null;
          globals.orderState = null;
          globals.currentExpenseId = 0;
          globals.currentExpenseSum = 0;
        } else {
          var res = json.decode(utf8.decode(response.bodyBytes));
          return res["message"];
        }
      } else {
        throw Exception("");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> sendCheck() async {
    try {
      // var data = {
      //   "table": 0,
      //   "emp": globals.userData!.name,
      //   "departments": globals.department!.map((e) => e.toJson()).toList(),
      //   "data": globals.orderState.map((e) => e.toJson()).toList(),
      // };
      // print(globals.orderState.map((e) => e.toJson()).toList());
      // final response = await net.post('http://api/print', body: data);
      // if (response.statusCode == 200) {
      // } else {
      //   var res = json.decode(utf8.decode(response.bodyBytes));
      //   return res["message"];
      // }
    } catch (e) {
      return e.toString();
    }
  }
}
