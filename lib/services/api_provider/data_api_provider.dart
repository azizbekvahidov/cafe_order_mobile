import 'dart:convert';

import 'package:cafe_mostbyte/models/category.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/models/settings.dart';

import '../network_service.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

class DataApiProvider {
  NetworkService net = NetworkService();

  Future<void> getSettings() async {
    try {
      final response = await net.get('${globals.apiLink}get-settings');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        var settings = helper.parseSettings(res["data"]);
        globals.settings = Settings.fromJson(settings);
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getCategory() async {
    try {
      final response = await net.get('${globals.apiLink}menu/category');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        globals.categories = res["data"];
        return res["data"];
      } else {
        throw Exception("error fetching category");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<MenuItem>> getProducts({id}) async {
    try {
      final response =
          await net.get('${globals.apiLink}menu/list?category_id=$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return List<MenuItem>.from(
            res["data"].map((x) => MenuItem.fromJson(x)));
      } else {
        throw Exception("error fetching category");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getExpenses({id}) async {
    try {
      final response = await net.get('${globals.apiLink}expense/list/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["data"];
      } else {
        throw Exception("error fetching category");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Expense> getExpense({id}) async {
    try {
      final response = await net.get('${globals.apiLink}expense/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return Expense.fromJson(res["data"]);
      } else {
        throw Exception("error fetching category");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
