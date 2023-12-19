// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:immo/data/api_models/privacy_policy_model.dart';
import 'package:provider/provider.dart';
import '../data/api_repo.dart';
import '../utils/api_url.dart';
import '../utils/size.dart';
import '../utils/string.dart';
import '../view/widgets/circular_progress.dart';
import 'language_provider.dart';

class MoreOptionProvider extends ChangeNotifier {
  //Variable
  bool? isLoading;
  ApiRepo apiRepo = ApiRepo();
  //Model
  PrivacyPolicyModel privacyPolicyModel = PrivacyPolicyModel();

  //Search Property Radio Lists
  int currentIndexLanguageRadioList = 0;
  List<String> languageRadioList = [
    english,
    deutsch,
    francais,
    italiano,
  ];

  setCurrentIndexLanguageRadioList(int newIndex, BuildContext context) {
    currentIndexLanguageRadioList = newIndex;
    if (currentIndexLanguageRadioList == 0) {
      Provider.of<LanguageProvider>(context, listen: false)
          .changeLanguage("en");
    } else if (currentIndexLanguageRadioList == 1) {
      Provider.of<LanguageProvider>(context, listen: false)
          .changeLanguage("de");
    } else if (currentIndexLanguageRadioList == 2) {
      Provider.of<LanguageProvider>(context, listen: false)
          .changeLanguage("fr");
    } else if (currentIndexLanguageRadioList == 3) {
      Provider.of<LanguageProvider>(context, listen: false)
          .changeLanguage("it");
    }
    notifyListeners();
  }

  //Loading
  setLoading(BuildContext context, bool value) {
    isLoading = value;
    if (value == true) {
      loaderDialog(context);
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  // ===========================================================================
// LOADING DIALOG
  loaderDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(100),
          contentPadding: const EdgeInsets.all(25),
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            height: setWidgetHeight(80),
            width: setWidgetWidth(80),
            child: const CircularProgress(),
          ),
        );
      },
    );
  }

  // Get Privacy Policy
  getPrivacyPolicy(BuildContext context, String screen) async {
    setLoading(context, true);
    debugPrint("isLoading: $isLoading");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.privacyPoliciesUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      privacyPolicyModel = PrivacyPolicyModel.fromJson(responseBody);
      setLoading(context, false);

      debugPrint("isLoading: $isLoading");
    }catch(e){
      setLoading(context, false);
      debugPrint("isLoading: ${e.toString()}");
      debugPrint("isSaveLoading: $isLoading");
    }
  }
}
