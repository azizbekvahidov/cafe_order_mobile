import 'dart:convert';
import 'dart:io';

import 'package:cafe_mostbyte/utils/enums/roles.dart';
import 'package:http/io_client.dart';
import '../../../models/user.dart';
import '../../network_service.dart';
import '../../../config/globals.dart' as globals;
import '../../../services/helper.dart' as helper;

class UserProvider {
  NetworkService net = NetworkService();
  Future<User> getUser() async {
    final response = await net.get('${globals.apiLink}users/${globals.id}');

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      final User userJson = User.fromJson(result["data"]);

      globals.filial = userJson.filial != null ? userJson.filial!.id : 0;
      globals.isKassa = false;
      if (userJson.role.role == Roles.cashier.name) {
        globals.isKassa = true;
      }
      return userJson;
    } else {
      throw Exception("error fetching users");
    }
  }
}
