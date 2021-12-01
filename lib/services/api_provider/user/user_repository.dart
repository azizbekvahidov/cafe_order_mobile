import '../../../models/user.dart';
import './user_api_provider.dart';
import '../../helper.dart' as helper;
import '../../../config/globals.dart' as globals;

class UserRepository {
  UserProvider _userProvider = UserProvider();
  Future<User> getUser() => _userProvider.getUser();
  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    helper.deleteData('token');
    // await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    helper.saveData("token", token);
    // await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    bool res = await helper.checkData("token");
    if (res) {
      globals.token = await helper.getData("token");
    }
    // await Future.delayed(Duration(seconds: 1));
    return res;
  }

  Future<bool> hasId() async {
    bool res = await helper.checkData("id");
    if (res) {
      globals.id = await helper.getData("id", type: "int");
    }
    // await Future.delayed(Duration(seconds: 1));
    return res;
  }
}
