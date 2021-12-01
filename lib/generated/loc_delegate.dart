import './locale_base.dart';
import 'package:flutter/cupertino.dart';
import '../config/globals.dart' as globals;

class LocDelegate extends LocalizationsDelegate<LocaleBase> {
  const LocDelegate();
  final idMap = const {
    'en': 'locales/EN_US.json',
    'ru': 'locales/RU_RU.json',
    'uz': 'locales/UZ_UZ.json',
    'oz': 'locales/OZ_OZ.json',
  };

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ru', 'uz', 'oz'].contains(locale.languageCode);

  @override
  Future<LocaleBase> load(Locale locale) async {
    var lang = globals.lang;
    final loc = LocaleBase();
    await loc.load(idMap[lang]!);
    return loc;
  }

  @override
  bool shouldReload(LocDelegate old) => true;
}
