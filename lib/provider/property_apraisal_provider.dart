import 'package:flutter/material.dart';
import 'package:immo/utils/string.dart';

class PropertyAppraisalProvider extends ChangeNotifier {
  TextEditingController postCodeandCityController = TextEditingController();
  TextEditingController streetAndHouseNumberController =
      TextEditingController();
  TextEditingController livingSpaceController = TextEditingController();
  TextEditingController numberOfRoomsController = TextEditingController();
  TextEditingController renovatedYearController = TextEditingController();
  TextEditingController constructionYearController = TextEditingController();
  TextEditingController firstAndLastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  clearTextField() {
    postCodeandCityController.clear();
    streetAndHouseNumberController.clear();
    livingSpaceController.clear();
    numberOfRoomsController.clear();
    renovatedYearController.clear();
    constructionYearController.clear();
    firstAndLastNameController.clear();
    emailController.clear();
    mobileNumberController.clear();
    notifyListeners();
  }

  // Validation
  firstAndLastNameValidation(value) {
    if (value.isEmpty) {
      return enterFirstAndLastName;
    }
  }

  mobileValidation(value) {
    String pattern = r'^\d{2}\s\d{3}\s\d{2}\s\d{2}$';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return enterMobileNumber;
    } else if (!regExp.hasMatch(value)) {
      return validMobileNumber;
    }
  }

  //Online Property Appraisal Radio Lists
  int currentIndexVerticalRadioList1 = 0;
  List<String> verticalRadioList1 = [
    onlineAppraisalRadioText1,
    onlineAppraisalRadioText2,
    onlineAppraisalRadioText3,
  ];

  setCurrentIndexVerticalRadioList1(int newIndex) {
    currentIndexVerticalRadioList1 = newIndex;
    notifyListeners();
  }

  int currentIndexVerticalRadioList2 = 0;
  List<String> verticalRadioList2 = [
    onlineAppraisalRadioText4,
    onlineAppraisalRadioText5,
    onlineAppraisalRadioText6,
    onlineAppraisalRadioText7,
  ];

  setCurrentIndexVerticalRadioList2(int newIndex) {
    currentIndexVerticalRadioList2 = newIndex;
    notifyListeners();
  }

  // Online Property Appraisal Steps
  int currentStep = 4;

  setCurrentStep(int step) {
    currentStep = step;
    notifyListeners();
  }

  // House or Appartment Selected
  bool isHouseSelected = true;

  setSelectedProperty(bool selection) {
    isHouseSelected = selection;
    notifyListeners();
  }
}
