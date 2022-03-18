import 'dart:convert';
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

        if (await helper.saveData("id", result["data"]["id"], type: "int")) {
          UserProvider _userProvider = UserProvider();
          globals.isAuth = true;
          globals.id = result["data"]["id"];
          var userData = await _userProvider.getUser();
          globals.userData = userData;
        } else {
          return ("error fetching users");
        }
      } else {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res["message"];
      }
    } catch (e) {
      return e.toString();
    }
  }
}
