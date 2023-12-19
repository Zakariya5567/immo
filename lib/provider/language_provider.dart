import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:immo/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/widgets/radio_list.dart';

class LanguageProvider extends ChangeNotifier {
  String languageCode = "en";
  bool isEnglishSelected = false;
  bool isGermenSelected = false;
  bool isFrenchSelected = false;
  bool isItalianSelected = false;
  Future<SharedPreferences> languageInstance = SharedPreferences.getInstance();
  updateLanguage() async {
    final SharedPreferences languagePrefrences = await languageInstance;
    final String langCodeValue =
        (languagePrefrences.getString(AppConstant.langCode) ?? "en");
    languagePrefrences.setString(AppConstant.langCode, langCodeValue);

    languageCode = langCodeValue;
    if (languageCode == "en") {
      isEnglishSelected = true;
      isGermenSelected = false;
      isFrenchSelected = false;
      isItalianSelected = false;
      languageCurrentIndex = 0;
    } else if (languageCode == "de") {
      isEnglishSelected = false;
      isFrenchSelected = false;
      isItalianSelected = false;
      isGermenSelected = true;
      languageCurrentIndex = 1;
    } else if (languageCode == "fr") {
      isFrenchSelected = true;
      isEnglishSelected = false;
      isGermenSelected = false;
      isItalianSelected = false;
      languageCurrentIndex = 2;
    } else if (languageCode == "it") {
      isFrenchSelected = false;
      isEnglishSelected = false;
      isGermenSelected = false;
      isItalianSelected = true;
      languageCurrentIndex = 3;
    }
    debugPrint("-----------------------------------   $languageCode");
    notifyListeners();
  }

  // Change language
  void changeLanguage(newLanguageCode) async {
    final SharedPreferences languagePrefrences = await languageInstance;
    languagePrefrences.setString(AppConstant.langCode, newLanguageCode ?? "en");
    final String langCodeValue =
        (languagePrefrences.getString(AppConstant.langCode) ?? "en");
    languageCode = langCodeValue;
    if (languageCode == "en") {
      isEnglishSelected = true;
      isGermenSelected = false;
      isFrenchSelected = false;
      isItalianSelected = false;
      languageCurrentIndex = 0;
    } else if (languageCode == "de") {
      isEnglishSelected = false;
      isFrenchSelected = false;
      isItalianSelected = false;
      isGermenSelected = true;
      languageCurrentIndex = 1;
    } else if (languageCode == "fr") {
      isFrenchSelected = true;
      isEnglishSelected = false;
      isGermenSelected = false;
      isItalianSelected = false;
      languageCurrentIndex = 2;
    } else if (languageCode == "it") {
      isFrenchSelected = false;
      isEnglishSelected = false;
      isGermenSelected = false;
      isItalianSelected = true;
      languageCurrentIndex = 3;
    }
    notifyListeners();
  }
}
