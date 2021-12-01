import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocaleBase {
  late Map<String, dynamic> _data;
  late String _path;
  Future<void> load(String path) async {
    _path = path;
    final strJson = await rootBundle.loadString(path);
    _data = jsonDecode(strJson);
    initAll();
  }
  
  Map<String, String> getData(String group) {
    return Map<String, String>.from(_data[group]);
  }

  String getPath() => _path;

  late Localeauth _auth;
  Localeauth get auth => _auth;

  void initAll() {
    _auth = Localeauth(Map<String, String>.from(_data['auth']));
  }
}

class Localeauth {
  late final Map<String, String> _data;
  Localeauth(this._data);

  String getByKey(String key) {
    return _data[key]!;
  }

  String get go_back => _data["go_back"]!;
  String get log_in => _data["log_in"]!;
  String get login => _data["login"]!;
  String get password => _data["password"]!;
}

