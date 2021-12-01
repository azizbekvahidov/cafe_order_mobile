import 'package:cafe_mostbyte/generated/locale_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './globals.dart' as globals;

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('ru');
  final LocaleBase lBase = LocaleBase();
  String locale = "ru";

  Locale get appLocal => _appLocale;
  fetchLocale(var prefs) async {
    String? langCode = prefs.getString('language_code');
    if (langCode == null) {
      _appLocale = const Locale('uz');
      return Null;
    }
    globals.lang = langCode;
    _appLocale = Locale(langCode);
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("uz")) {
      _appLocale = const Locale("uz");
      await prefs.setString('language_code', 'uz');
      await prefs.setString('countryCode', 'UZ');
      locale = 'locales/UZ_UZ.json';
      globals.lang = 'uz';
    } else if (type == const Locale("ru")) {
      _appLocale = const Locale("ru");
      await prefs.setString('language_code', 'ru');
      await prefs.setString('countryCode', 'RU');
      locale = 'locales/RU_RU.json';
      globals.lang = 'ru';
    } else if (type == const Locale("oz")) {
      _appLocale = const Locale("oz");
      await prefs.setString('language_code', 'oz');
      await prefs.setString('countryCode', 'OZ');
      locale = 'locales/OZ_OZ.json';
      globals.lang = 'oz';
    } else if (type == const Locale("en")) {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'EN');
      locale = 'locales/EN_US.json';
      globals.lang = 'en';
    }
    lBase.load(locale).whenComplete(() {
      globals.loc = lBase;
    });
    notifyListeners();
  }
}
