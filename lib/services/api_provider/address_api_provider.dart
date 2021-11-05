import 'dart:convert';

import '../http_exception.dart';
import '../network_service.dart';
import '../../config/globals.dart' as globals;

class AddressApiProvider {
  NetworkService net = NetworkService();

  Future<List<dynamic>> getCity({id = ""}) async {
    try {
      final response = await net
          .get('${globals.apiLink}locations/district?pm_gov=1&region_id=${id}');
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
