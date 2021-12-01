import 'dart:convert';

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
}
