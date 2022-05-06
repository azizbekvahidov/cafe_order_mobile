import 'dart:convert';
import 'package:cafe_mostbyte/models/change_sum.dart';
import 'package:intl/intl.dart';

import 'package:cafe_mostbyte/models/change.dart';
import 'package:cafe_mostbyte/services/network_service.dart';

import '../../../models/user.dart';
import './user_api_provider.dart';
import '../../helper.dart' as helper;
import '../../../config/globals.dart' as globals;

class UserRepository {
  UserProvider _userProvider = UserProvider();
  NetworkService net = NetworkService();
  Future<User> getUser() => _userProvider.getUser();
  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    helper.deleteData('id');
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

  Future<void> closeChange() async {
    await getChange();
    final change = await net.post('${globals.apiLink}change/close', body: {
      "user_id": globals.userData!.id,
      "sum":
          globals.tempChangeSum != null ? globals.tempChangeSum!.closed_sum : 0
    });
    if (change.statusCode == 200) {
      var result = json.decode(change.body);
      globals.tempChange = Change.fromJson(result["data"]);
    } else {
      throw Exception("bad request");
    }

    // await getChange();
  }

  Future<Change?> getChange() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final change = await net
        .get('${globals.apiLink}change/get?user_id=${globals.userData!.id}');
    if (change.statusCode == 200) {
      var result = json.decode(change.body);
      final changeSum = await net.get(
        '${globals.apiLink}report/proceed-filial?start=${result["data"]["start_time"]}&end=${formattedDate}&filial_id=${result["data"]["filial"]["id"]}',
      );
      var sum = json.decode(changeSum.body);
      globals.tempChange = Change.fromJson(result["data"]);
      if (sum["data"].length != 0) {
        globals.tempChangeSum = ChangeSum.fromJson(sum["data"][0]);
      }
    }
    return null;
  }
}
