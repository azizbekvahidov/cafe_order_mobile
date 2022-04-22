import 'dart:convert';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import '../../../config/globals.dart' as globals;

class ExpenseRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();
  Future<String?> createExpense() async {
    try {
      var data = {
        "user_id": globals.userData!.id,
        "filial_id": globals.filial,
        "order_type": "book_table"
      };
      final response =
          await net.post('${globals.apiLink}expense/create', body: data);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        globals.currentExpenseId = result["data"]['id'];
        globals.currentExpenseSum = result["data"]['expense_sum'];
        return result["data"];
      } else {
        throw Exception("");
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
      } else {
        throw Exception("");
      }
    } catch (e) {
      throw Exception(e.toString());
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
          throw Exception("");
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
        final response = await net
            .post('${globals.apiLink}expense/terminalClose', body: data);
        if (response.statusCode == 200) {
          globals.currentExpense = null;
          globals.orderState = null;
          globals.currentExpenseId = 0;
          globals.currentExpenseSum = 0;
        } else {
          throw Exception("");
        }
      } else {
        throw Exception("");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> debtCloseExpense() async {
    try {
      if (globals.currentExpense != null) {
        var data = globals.currentExpense!.toJson();
        final response =
            await net.post('${globals.apiLink}expense/debtClose', body: data);
        if (response.statusCode == 200) {
          globals.currentExpense = null;
          globals.orderState = null;
          globals.currentExpenseId = 0;
          globals.currentExpenseSum = 0;
        } else {
          throw Exception("");
        }
      } else {
        throw Exception("");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> avansCloseExpense() async {
    try {
      if (globals.currentExpense != null) {
        var data = globals.currentExpense!.toJson();
        final response =
            await net.post('${globals.apiLink}expense/avansClose', body: data);
        if (response.statusCode == 200) {
          globals.currentExpense = null;
          globals.orderState = null;
          globals.currentExpenseId = 0;
          globals.currentExpenseSum = 0;
        } else {
          throw Exception("");
        }
      } else {
        throw Exception("");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> deliveryExpense() async {
    try {
      if (globals.currentExpense != null) {
        if (globals.currentExpense!.delivery != null) {
          var data = {
            "id": globals.currentExpenseId,
            "delivery": globals.currentExpense!.delivery!.toJson()
          };

          final response =
              await net.post('${globals.apiLink}delivery/create', body: data);
          if (response.statusCode == 200) {
            var res = json.decode(utf8.decode(response.bodyBytes));
            globals.currentExpense!.delivery = Delivery.fromJson(res);
            globals.expenseDelivery = Delivery.fromJson(res);
          } else {
            throw Exception("");
          }
        } else {
          throw Exception("");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> takeawayExpense() async {
    try {
      if (globals.currentExpense != null) {
        if (globals.currentExpense!.phone != null) {
          var data = {
            "id": globals.currentExpenseId,
            "ready_time": globals.currentExpense!.ready_time,
            "phone": globals.currentExpense!.phone,
          };

          final response =
              await net.post('${globals.apiLink}expense/takeaway', body: data);
          if (response.statusCode == 200) {
          } else {
            throw Exception("");
          }
        } else {
          throw Exception("");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

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
            throw Exception("");
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
