// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';

import '../data/api_models/inquiry_management/iquiry_list.dart';
import '../data/api_models/submit_response.dart';
import '../data/api_repo.dart';
import '../utils/api_url.dart';
import '../utils/string.dart';
import '../view/widgets/circular_progress.dart';
import '../view/widgets/custom_snackbar.dart';

class ContactFormProvider extends ChangeNotifier {
  TextEditingController firstAndLastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool isLoading = false;
  ApiRepo apiRepo = ApiRepo();
  SubmitResponse submitResponse = SubmitResponse();
  InquiryResponse inquiryResponse = InquiryResponse();

  List<Data> list = [];

  clearTextField() {
    firstAndLastNameController.clear();
    phoneNumberController.clear();
    emailController.clear();
    messageController.clear();
    notifyListeners();
  }

// Validation
  firstAndLastNameValidation(value) {
    if (value.isEmpty) {
      return enterFirstAndLastName;
    }
  }

  mobileValidation(value) {
    String pattern = r'^(?:[+0][1-9])?[0-9]{11}$';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return enterMobileNumber;
    } else if (!regExp.hasMatch(value)) {
      return validMobileNumber;
    }
  }

  bool isValidPhone(String phoneNumber) {
    String pattern = r'^(?:[+0][1-9])?[0-9]{11}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  messageValidation(value) {
    if (value.isEmpty) {
      return writeMessage;
    }
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

  showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(context, message, 1));
  }

  // Contact US
  submitInquiry(BuildContext context, String screen, int id) async {
    if (firstAndLastNameController.text.trim() == "") {
      //error email
      showErrorMessage(context, enterFirstAndLastName);
      return;
    } else if (!isValidEmail(emailController.text.trim())) {
      //error email
      showErrorMessage(context, enterEmailAddress);
      return;
    } else if (!isValidPhone(emailController.text.trim())) {
      //error Phone
      showErrorMessage(context, enterTelephone);
      return;
    } else if (messageController.text.trim() == "") {
      //error Phone
      showErrorMessage(context, writeMessage);
      return;
    }

    setLoading(context, true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" login ==========================>>>");

    try {
     
      Response response =
         
          await apiRepo.postData(context, screen, ApiUrl.sendInquiryUrl, {
        "property_id": id,
        "full_name": firstAndLastNameController.text,
        "phone_number": "+41 ${phoneNumberController.text}",
        "email": emailController.text,
        "message": messageController.text,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      submitResponse = SubmitResponse.fromJson(responseBody);

      if (submitResponse.error == false) {
       
        ScaffoldMessenger.of(context).showSnackBar(
           
            customSnackBar(context, submitResponse.message.toString(), 0));
      } else {
       
        ScaffoldMessenger.of(context).showSnackBar(
           
            customSnackBar(context, submitResponse.message.toString(), 1));
      }

     
      setLoading(context, false);
      if (submitResponse.message == "Success") {
        Navigator.pop(context);
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

  //GET InquiryList LIST
  getInquiryList(BuildContext context, String screen) async {
    isLoading = true;
    notifyListeners();
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getInquiryUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      inquiryResponse = InquiryResponse.fromJson(responseBody);
      list = inquiryResponse.data!;
      isLoading = false;
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      isLoading = false;
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  //Delete Inquiry
  deleteInquiry(
      BuildContext context, String screen, int id, int position) async {
   
    setLoading(context, true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" login ==========================>>>");

    try {
     
      Response response =
         
          await apiRepo.deleteData(
              context, screen, "${ApiUrl.deleteInquiryUrl}/${id.toString()}", {
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      submitResponse = SubmitResponse.fromJson(responseBody);

      if (submitResponse.error == false) {
       
        ScaffoldMessenger.of(context).showSnackBar(
           
            customSnackBar(context, submitResponse.message.toString(), 0));
      } else {
       
        ScaffoldMessenger.of(context).showSnackBar(
           
            customSnackBar(context, submitResponse.message.toString(), 1));
      }

     
      setLoading(context, false);
      if (!submitResponse.error!) {
        list.removeAt(position);
        Navigator.pop(context);
      }

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(context, false);
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }
}
