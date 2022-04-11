import 'dart:convert';
import 'dart:io';

import 'package:cafe_mostbyte/models/category.dart';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/filial.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/models/settings.dart';
import 'package:path_provider/path_provider.dart';

import '../network_service.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

class DataApiProvider {
  NetworkService net = NetworkService();

  Future<void> getSettings() async {
    try {
      await getFileSettings();
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

  Future<void> getFileSettings() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/settings.json');
      Map settings = json.decode(await file.readAsString());
      globals.filial = settings["filial_id"];
      globals.isKassa = settings["isKassa"];
    } catch (e) {
      Map settings = {
        "filial_id": 0,
        "isKassa": false,
      };
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/settings.json');
      await file.writeAsString(json.encode(settings));
      globals.filial = settings["filial_id"];
      globals.isKassa = settings["isKassa"];
    }
  }

  Future<void> getDepartment() async {
    try {
      final response = await net.get('${globals.apiLink}departments');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        globals.department = List<Department>.from(
            res["data"].map((x) => Department.fromJson(x)));
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
        return List<MenuItem>.from(res["data"].map((x) {
          return MenuItem.fromJson(x);
        }));
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

  Future<Expense?> getExpense({id}) async {
    try {
      final response = await net.get('${globals.apiLink}expense/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return Expense.fromJson(res["data"]);
      } else {
        return null;
        // throw Exception("error fetching category");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<DeliveryBot>> getBotOrderApproveList({id}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}delivery/bot-list/$id?order_status=${globals.userData!.role.role == 'moderator' ? 2 : 1}');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return List<DeliveryBot>.from(
            res["data"].map((model) => DeliveryBot.fromJson(model)));
      } else {
        throw Exception("error fetching category");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Filial>> getFilials() async {
    try {
      final response = await net.get('${globals.apiLink}filial');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return List<Filial>.from(
            res["data"].map((model) => Filial.fromJson(model)));
      } else {
        throw Exception("error fetching filial list");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<MenuItem>> searchProducts({query}) async {
    try {
      final response = await net.get('${globals.apiLink}menu/search/$query');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return List<MenuItem>.from(res["data"].map((x) {
          return MenuItem.fromJson(x);
        }));
      } else {
        throw Exception("error fetching category");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
