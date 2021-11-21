import 'dart:convert';

import '../network_service.dart';
import '../../config/globals.dart' as globals;

class DataApiProvider {
  NetworkService net = NetworkService();

  Future<List<dynamic>> getRegion() async {
    try {
      final response = await net.get('${globals.apiLink}pm-gov/region');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getScope() async {
    try {
      final response = await net.get('${globals.apiLink}appeals/scopes');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
