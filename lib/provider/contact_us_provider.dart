// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:immo/data/api_models/contact_us/contact_us_model.dart';
import 'package:immo/data/api_models/contact_us/drop_down_list_model.dart';
import 'package:immo/utils/string.dart';

import '../data/api_models/contact_us/contact_us_detail_model.dart';
import '../data/api_repo.dart';
import '../helper/routes_helper.dart';
import '../utils/api_url.dart';
import '../utils/size.dart';
import '../view/widgets/circular_progress.dart';
import '../view/widgets/custom_snackbar.dart';

class ContactUsProvider extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController telePhoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  //Variables
  bool? isLoading;
  bool? isShimmerLoading;
  ApiRepo apiRepo = ApiRepo();

  //Models
  ContactUSDropDownListModel contactUSDropDownListModel =
      ContactUSDropDownListModel();
  ContactUsModel contactUsModel = ContactUsModel();
  ContactUsDetailModel contactUsDetailModel = ContactUsDetailModel();

  clearTextField() {
    firstNameController.clear();
    lastNameController.clear();
    telePhoneNumberController.clear();
    messageController.clear();
    emailController.clear();
    selectedIndex = 0;
    currentIndexContactUsRadioList = 0;
    reasonForRequestSelectedValue = '';
    contactUsDropDownKeys.elementAt(0);
    notifyListeners();
  }

  // Validation
  firstNameValidation(value) {
    if (value.isEmpty) {
      return hintFirstName;
    }
  }

  lastNameValidation(value) {
    if (value.isEmpty) {
      return hintLastName;
    }
  }

  //ContactUs Radio Lists
  int currentIndexContactUsRadioList = 0;
  List<String> contactUsRadioList = [genderMr, genderMs];

  setCurrentIndexContactUsRadioList(int newIndex) {
    currentIndexContactUsRadioList = newIndex;
    notifyListeners();
  }

  // Drop Down
  int selectedIndex = 0;

  String? reasonForRequestSelectedValue;
  List<String> contactUsDropDownList = ["0", "1"];
  List contactUsDropDownKeys = ["0", "1"];

  setDropDownValue(
      {required String title, required String value, required int index}) {
    if (title == "reasonForRequest") {
      selectedIndex = index;
      reasonForRequestSelectedValue = value;
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

  setShimmerLoading(bool value) {
    isShimmerLoading = value;
    notifyListeners();
  }

  //=================================================================================
  //Api

  // GET DropDown
  getDropDown(BuildContext context, String screen) async {
    setShimmerLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get plan  ==========================>>>");

    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.contactUsReasonUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      contactUSDropDownListModel =
          ContactUSDropDownListModel.fromJson(responseBody);
      if (contactUSDropDownListModel.error == false) {
        if (contactUSDropDownListModel.data != null) {
          reasonForRequestSelectedValue =
              contactUSDropDownListModel.data!.values.first;
          contactUsDropDownList.clear();
          contactUsDropDownKeys.clear();
          contactUSDropDownListModel.data!.forEach(
            (key, value) {
              if (!contactUsDropDownList.contains(value)) {
                contactUsDropDownList.add(value);
              }
              if (!contactUsDropDownKeys.contains(key)) {
                contactUsDropDownKeys.add(key);
              }
            },
          );
          debugPrint('$contactUsDropDownList');
          debugPrint('${contactUSDropDownListModel.message}');
        }
      }
      setShimmerLoading(false);
    } catch (e) {
      setShimmerLoading(false);
      debugPrint("Exception: $e");
    }

    notifyListeners();
  }

  // GET Owner Detail
  getOwnerDetail(BuildContext context, String screen) async {
    setShimmerLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get plan  ==========================>>>");

    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.contactUsDetailUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      contactUsDetailModel = ContactUsDetailModel.fromJson(responseBody);
      setShimmerLoading(false);
    } catch (exception) {
      setShimmerLoading(false);
      debugPrint("Exception: $exception");
    }

    notifyListeners();
  }

  // Contact US
  contactUsSubmition(BuildContext context, String screen) async {
    setLoading(context, true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" login ==========================>>>");

    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.contactUsUrl, {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "gender": currentIndexContactUsRadioList == 0 ? "mr" : "ms",
        "reason": contactUsDropDownKeys.elementAt(selectedIndex),
        "telephone_number": "+41 ${telePhoneNumberController.text}",
        "email": emailController.text,
        "message": messageController.text,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      contactUsModel = ContactUsModel.fromJson(responseBody);

      if (contactUsModel.error == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, contactUsModel.message.toString(), 0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, contactUsModel.message.toString(), 1));
      }
      setLoading(context, false);
      if (contactUsModel.message == "Success") {
        Navigator.pushReplacementNamed(context, RouterHelper.moreOptions);
        clearTextField();
      }

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(context, false);
      debugPrint("isLoading: $isLoading");
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
}
