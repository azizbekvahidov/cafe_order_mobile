import 'dart:convert';
import '../../models/user.dart';

import '../../services/api_provider/data_api_provider.dart';
import '../../services/network_service.dart';
import '../../services/api_provider/user/user_api_provider.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

class AuthRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();
  Future<String?> login({login, pass}) async {
    try {
      var data = {"login": login, "password": pass};
      final response =
          await net.post('${globals.apiLink}users/signin', body: data);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        globals.id = result["data"]["id"];
        UserProvider _userProvider = UserProvider();
        User userData = await _userProvider.getUser();
        if (globals.isKassa) {
          final change = await net.post('${globals.apiLink}change/open',
              body: {"user_id": result["data"]["id"]});
          if (change.statusCode == 201 || change.statusCode == 200) {
            if (await helper.saveData("id", result["data"]["id"],
                type: "int")) {
              globals.isAuth = true;
              User userData = await _userProvider.getUser();

              globals.userData = userData;
            } else {
              return "no-login";
            }
          } else {
            throw "no-change";
          }
        } else {
          if (await helper.saveData("id", result["data"]["id"], type: "int")) {
            globals.isAuth = true;
            User userData = await _userProvider.getUser();

            globals.userData = userData;
          } else {
            return "no-login";
          }
        }
      } else {
        return "no-login";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
