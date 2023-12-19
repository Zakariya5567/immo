import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, Map<String, String>> languages = <String, Map<String, String>>{};
  Future<bool> load() async {
    String enString = await rootBundle.loadString('assets/locale/en.json');
    String deString = await rootBundle.loadString('assets/locale/de.json');
    String frString = await rootBundle.loadString('assets/locale/fr.json');
    String itString = await rootBundle.loadString('assets/locale/it.json');
    Map<String, dynamic> enMap = await json.decode(enString);
    Map<String, dynamic> deMap = await json.decode(deString);
    Map<String, dynamic> frMap = await json.decode(frString);
    Map<String, dynamic> itMap = await json.decode(itString);

    languages["en"] = enMap.map((key, value) => MapEntry(key, value));
    languages["de"] = deMap.map((key, value) => MapEntry(key, value));
    languages["fr"] = frMap.map((key, value) => MapEntry(key, value));
    languages["it"] = itMap.map((key, value) => MapEntry(key, value));
    return true;
  }

  String translate(String code, String key) {
    return languages[code]![key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale locale;
  const AppLocalizationsDelegate({required this.locale});

  @override
  bool isSupported(Locale locale) {
    return ['en','de','fr','it'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(this.locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

String? translate(BuildContext context, String code, String key) {
  String? abc = AppLocalizations.of(context)?.translate(code, key);
  return abc;
}
