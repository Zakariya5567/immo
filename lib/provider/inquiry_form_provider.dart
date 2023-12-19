import 'package:flutter/material.dart';
import 'package:immo/utils/string.dart';

class InquiryFormProvider extends ChangeNotifier {
  TextEditingController firstAndLastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  clearTextField() {
    firstAndLastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    messageController.clear();
    notifyListeners();
  }

  phoneValidation(value) {
    String pattern = r'^\d{2}\s\d{3}\s\d{2}\s\d{2}$';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return hintPhone;
    } else if (!regExp.hasMatch(value)) {
      return validPhoneNumber;
    }
  }
}
