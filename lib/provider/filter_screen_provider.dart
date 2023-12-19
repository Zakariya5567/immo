import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:immo/data/api_models/alert/delete_alert_model.dart';
import 'package:immo/data/api_models/filter_model/age_of_ad_model.dart';
import 'package:immo/data/api_models/filter_model/filter_floor_list_model.dart';
import 'package:immo/helper/date_format.dart';
import 'package:immo/helper/debouncer.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/search_map_provider.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../data/api_models/alert/create_alert_model.dart';
import '../data/api_models/alert/get_alert_model.dart';
import '../data/api_models/cities_model.dart';
import '../data/api_models/filter_model/ads_with_model.dart';
import '../data/api_models/filter_model/characterictis_model.dart';
import '../data/api_models/places_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_category_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_no_of_floors_model.dart';
import '../data/api_models/properties/drawn_map.dart';
import '../data/api_models/properties/property_list_model.dart';
import '../data/api_repo.dart';
import '../utils/api_url.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/size.dart';
import '../view/widgets/circular_progress.dart';
import 'package:http/http.dart' as http;

class FilterScreenProvider extends ChangeNotifier {
  //Models
  PropertyCategoryModel propertyCategoryModel = PropertyCategoryModel();
  NoOfFloorsModel noOfFloorsModel = NoOfFloorsModel();
  CharacteristicsModel characteristicsModel = CharacteristicsModel();
  AgeOfAdModel ageOfAdModel = AgeOfAdModel();
  AdsWithModel adsWithModel = AdsWithModel();
  FilterFloorListModel filterFloorListModel = FilterFloorListModel();
  PropertiesListModel propertiesListModel = PropertiesListModel();
  CreateAlertModel createAlertModel = CreateAlertModel();
  GetAlertModel getAlertModel = GetAlertModel();
  DeleteAlertModel deleteAlertModel = DeleteAlertModel();

  int isEdit = 0;
  int? alertId;
  int? alertIndex;

  setIsEdit(int value) {
    isEdit = value;
    debugPrint("IS EDIT : $isEdit");
    notifyListeners();
  }

  setAlertId(int id, int index) {
    alertId = id;
    alertIndex = index;
    debugPrint("Alert Id : $alertId");
    debugPrint("Alert Index : $alertIndex");
    notifyListeners();
  }

  //Variables

  //Api Repo
  ApiRepo apiRepo = ApiRepo();

  List<FloorSelectedData> filterFloorList = [];
  List<AgeOfAdData> ageOfAdList = [];
  List<CharacteristicsData> characteristicsList = [];
  List<AdsWithData> adsWithList = [];

//=======================================================================================
  //Alert Section

  TextEditingController alertNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  clearAlertTextField() {
    alertNameController.clear();
    emailController.clear();
    notifyListeners();
  }

  // Validation
  alertNameValidation(value) {
    if (value.isEmpty) {
      return hintAlertName;
    }
  }

  emailValidation(value, controller) {
    if (value.isEmpty) {
      return hintEmail;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return validEmail;
    }
    return null;
  }

  removeAlertFromList(int index) {
    if (deleteAlertModel.error == false) {
      getAlertModel.data!.removeAt(index);
    }
    notifyListeners();
  }

//=======================================================================================
  //Search result screen

  //Search Property sort Radio Lists
  int currentIndexSortRadioList = 0;
  String? selectedSortValue;
  List<String> searchSortRadioList = [
    topOffer,
    priceHigh,
    priceLow,
    roomsFew,
    roomsMany,
    areaSmall,
    areaLarge,
    mostRecentAds
  ];

  setCurrentIndexSortRadioList(int newIndex, context) {
    currentIndexSortRadioList = newIndex;
    if (currentIndexSortRadioList == 0) {
      selectedSortValue = "top_offers";
    } else if (currentIndexSortRadioList == 1) {
      selectedSortValue = "price_high";
    } else if (currentIndexSortRadioList == 2) {
      selectedSortValue = "price_low";
    } else if (currentIndexSortRadioList == 3) {
      selectedSortValue = "rooms_few";
    } else if (currentIndexSortRadioList == 4) {
      selectedSortValue = "rooms_many";
    } else if (currentIndexSortRadioList == 5) {
      selectedSortValue = "area_small";
    } else if (currentIndexSortRadioList == 6) {
      selectedSortValue = "area_large";
    } else if (currentIndexSortRadioList == 7) {
      selectedSortValue = "most_recent_ads";
    }

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  //=======================================================================================
  // Favourite un Favourite
  setPropertyFavouriteIconById(int id) {
    for (var element in propertiesListModel.data!) {
      if (element.id == id) {
        element.isFavourite == true
            ? element.isFavourite = false
            : element.isFavourite = true;
      }
    }
    notifyListeners();
  }

  //=======================================================================================
  //Property
  int? propertySelectedIndex;
  int? categoryId;

  setPropertySelectedIndex(
      {required int index, required int newCategoryId, required context}) {
    if (propertySelectedIndex != index) {
      propertySelectedIndex = index;
    } else {
      propertySelectedIndex = null;
    }
    if (categoryId != newCategoryId) {
      categoryId = newCategoryId;
    } else {
      categoryId = null;
    }

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  //=======================================================================================
  //toggle button
  // Set Ownership button color Rent/Buy

  bool isButtonSelected = true;
  int toggleIndex = 0;
  String? ownershipType = "for_rent";

  setButtonFlag(int index, context) {
    if (index == 0) {
      ownershipType = "for_rent";
      toggleIndex = 0;
    } else if (index == 1) {
      ownershipType = "for_sale";
      toggleIndex = 1;
    }

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
    debugPrint("Ownership type : $ownershipType");
    debugPrint("toggle index : $toggleIndex");
  }

  Color getbuyButtonTextColor() {
    if (isButtonSelected) {
      return blackPrimary;
    } else {
      return whitePrimary;
    }
  }

  //=======================================================================================
  //Bedroom & Bathroom selection section

  int? bedRoomIndex;

  setBedRoomCurrentIndex(int index, context) {
    if (bedRoomIndex == index) {
      bedRoomIndex = null;
    } else {
      bedRoomIndex = index;
    }

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  int? bathRoomIndex;

  setBathRoomCurrentIndex(int index, context) {
    if (bathRoomIndex == index) {
      bathRoomIndex = null;
    } else {
      bathRoomIndex = index;
    }

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  //=======================================================================================
  // Currency
  List<String> currencyRadioList = [chf, usd, eur];

  String currencyValue = 'chf';
  int currencyRadioListIndex = 0;

  setCurrencyCurrentIndexRadioList(int newIndex, context) {
    currencyRadioListIndex = newIndex;
    currencyValue = currencyRadioList[currencyRadioListIndex];

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  String getCurrencyCurrentValueRadioList() {
    return currencyRadioList[currencyRadioListIndex];
  }

  //=======================================================================================
  //Date Section
  //From date
  List<String> fromDateRadioList = [
    "immediately",
  ];
  List<String> toDateRadioList = [
    any,
  ];
  int? fromDateRadioListIndex = 0;
  int? toDateRadioListIndex = 0;
  String fromDateValue = "immediately";
  String toDateValue = any;

  setFromDateCurrentIndexRadioList(int newIndex, context) {
    fromDateRadioListIndex = newIndex;
    fromDateValue = fromDateRadioList[fromDateRadioListIndex!];

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  String getFromDateCurrentValueRadioList() {
    return fromDateRadioList[fromDateRadioListIndex!];
  }

  getFromDateMonthYearFromCurrent() {
    fromDateRadioList.clear();
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    fromDateRadioList.add("immediately");
    for (int i = 0; i < 12; i++) {
      DateTime createdDate = DateTime(currentYear, currentMonth + i);
      fromDateRadioList.add(dateMonthYearFormat(createdDate));
    }

    notifyListeners();
    debugPrint("Date List : $fromDateRadioList}");
  }

  //To date
  setToDateCurrentIndexRadioList(int newIndex, context) {
    toDateRadioListIndex = newIndex;

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  String getToDateCurrentValueRadioList() {
    toDateValue = toDateRadioList[toDateRadioListIndex!];
    return toDateRadioList[toDateRadioListIndex!];
  }

  getToDateMonthYearFromCurrent() {
    toDateRadioList.clear();
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    toDateRadioList.add("any");
    for (int i = 0; i < 12; i++) {
      DateTime createdDate = DateTime(currentYear, currentMonth + i);
      toDateRadioList.add(dateMonthYearFormat(createdDate));
    }
    notifyListeners();
    debugPrint("To Date List : $toDateRadioList}");
  }

  //Get month
  int getMonth(month) {
    switch (month) {
      case "January":
        return 1;
      case "February":
        return 2;
      case "March":
        return 3;

      case "April":
        return 4;

      case "May":
        return 5;
      case "June":
        return 6;

      case "July":
        return 7;

      case "August":
        return 8;

      case "September":
        return 9;

      case "October":
        return 10;

      case "November":
        return 11;

      case "December":
        return 12;
    }
    return 0;
  }

  //=======================================================================================
  //range slider
  final debouncer = DeBouncer(milliseconds: 500);
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController minAreaController = TextEditingController();
  TextEditingController maxAreaController = TextEditingController();

  clearTextField() {
    minPriceController.clear();
    maxPriceController.clear();
    minAreaController.clear();
    maxAreaController.clear();
    notifyListeners();
  }

  setCoursorofTextField() {
    minPriceController.selection = TextSelection.fromPosition(
        TextPosition(offset: minPriceController.text.length));
    maxPriceController.selection = TextSelection.fromPosition(
        TextPosition(offset: maxPriceController.text.length));
    minAreaController.selection = TextSelection.fromPosition(
        TextPosition(offset: minAreaController.text.length));
    maxAreaController.selection = TextSelection.fromPosition(
        TextPosition(offset: maxAreaController.text.length));
    notifyListeners();
  }

  double minimumPrice = 0;
  double maximumPrice = 5000000;
  double minimumArea = 0;
  double maximumArea = 500;
  RangeValues areaValues = const RangeValues(0, 500);
  RangeValues priceValues = const RangeValues(0, 5000000);

  setRangeValues(
      {required String rangeTitle,
      required RangeValues rangeValues,
      required context}) {
    if (rangeTitle == "areaRange") {
      areaValues = rangeValues;
      minAreaController.text = areaValues.start.round().toString();
      minAreaController.selection = TextSelection.fromPosition(
          TextPosition(offset: minAreaController.text.length));
      maxAreaController.text = areaValues.end.round().toString();
      maxAreaController.selection = TextSelection.fromPosition(
          TextPosition(offset: maxAreaController.text.length));
      debouncer.run(() {
        getFilterData(context, 0, 1, RouterHelper.filterScreen);
      });
      debugPrint('$areaValues');
    }
    if (rangeTitle == "priceRange") {
      priceValues = rangeValues;
      minPriceController.text = priceValues.start.round().toString();
      minPriceController.selection = TextSelection.fromPosition(
          TextPosition(offset: minPriceController.text.length));
      maxPriceController.text = priceValues.end.round().toString();
      maxPriceController.selection = TextSelection.fromPosition(
          TextPosition(offset: maxPriceController.text.length));
      debouncer.run(() {
        getFilterData(context, 0, 1, RouterHelper.filterScreen);
      });
    }
    notifyListeners();
  }

  //Minimum Price range TextField
  setMinPriceRange(String minValue, context) {
    if (minValue == '' || maximumPrice <= double.parse(minValue)) {
      priceValues = RangeValues(minimumPrice, maximumPrice);
      minPriceController.text = priceValues.start.round().toString();
    } else {
      priceValues = RangeValues(
          double.parse(minValue.replaceAll(RegExp(r'^0+(?=.)'), '')),
          maximumPrice);
      minPriceController.text = priceValues.start.round().toString();
      debouncer.run(() {
        getFilterData(context, 0, 1, RouterHelper.filterScreen);
      });
    }
    setCoursorofTextField();
    notifyListeners();
  }

  //Maximum Price range TextField
  setMaxPriceRange(String maxValue, context) {
    if (maxValue == '' ||
        double.parse(maxValue) <= minimumPrice ||
        double.parse(maxValue) >= maximumPrice) {
      priceValues = RangeValues(minimumPrice, maximumPrice);
      maxPriceController.text = priceValues.end.round().toString();
    } else {
      priceValues = RangeValues(minimumPrice,
          double.parse(maxValue.replaceAll(RegExp(r'^0+(?=.)'), '')));
      maxPriceController.text = priceValues.end.toString();
      debouncer.run(() {
        getFilterData(context, 0, 1, RouterHelper.filterScreen);
      });
    }

    notifyListeners();
  }

  //Minimum Area range TextField
  setMinAreaRange(String minValue, context) {
    if (minValue == '' || maximumArea <= double.parse(minValue)) {
      areaValues = RangeValues(minimumArea, maximumArea);
      minAreaController.text = areaValues.start.round().toString();
    } else {
      areaValues = RangeValues(
          double.parse(minValue.replaceAll(RegExp(r'^0+(?=.)'), '')),
          maximumArea);
      minAreaController.text = areaValues.start.round().toString();
      debouncer.run(() {
        getFilterData(context, 0, 1, RouterHelper.filterScreen);
      });
    }
    setCoursorofTextField();
    notifyListeners();
  }

  //Maximum Area range TextField
  setMaxAreaRange(String maxValue, context) {
    if (maxValue == '' ||
        double.parse(maxValue) <= minimumArea ||
        double.parse(maxValue) >= maximumArea) {
      areaValues = RangeValues(minimumArea, maximumArea);
      maxAreaController.text = areaValues.end.round().toString();
    } else {
      areaValues = RangeValues(minimumArea,
          double.parse(maxValue.replaceAll(RegExp(r'^0+(?=.)'), '')));
      maxAreaController.text = areaValues.end.round().toString();
      debouncer.run(() {
        getFilterData(context, 0, 1, RouterHelper.filterScreen);
      });
    }
    setCoursorofTextField();
    notifyListeners();
  }

  //=======================================================================================
  //Filter floor selection
  // Get value of floor values (true/false)

  bool? onlyOnTheGroundFloor;
  bool? notOnTheGround;
  bool? includeUnspecified;

  getFloor() {
    for (var element in filterFloorList) {
      if (element.key == "only_on_the_ground_floor") {
        onlyOnTheGroundFloor = element.isSelected;
      }
      if (element.key == "not_on_the_ground") {
        notOnTheGround = element.isSelected;
      }
      if (element.key == "include_unspecified") {
        includeUnspecified = element.isSelected;
      }
    }
    notifyListeners();
  }

  setFilterFloorSelectedIndex(int index, context) {
    filterFloorList[index].isSelected = !filterFloorList[index].isSelected!;

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  //=======================================================================================
  // Get value of characteristics values (true/false)

  setFilterCharacteristicsSelectedIndex(int index, context) {
    characteristicsList[index].isSelected =
        !characteristicsList[index].isSelected!;

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  //interior
  bool? wheelchairAccessible;
  bool? petsPermitted;

  //exterior
  bool? lift;
  bool? parkingSpace;
  bool? garage;
  bool? balconyTerracePatio;

  //others
  bool? newBuilding;
  bool? oldBuilding;
  bool? cornerHouseOrEndOfTerraceHouse;
  bool? midTerraceHouse;
  bool? houseOrFlatShare;

  //equipment
  bool? energyEfficientConstruction;
  bool? minergieCertified;

  getCharacteristics() {
    for (var element in characteristicsList) {
      if (element.key! == "wheelchair_accessible") {
        wheelchairAccessible = element.isSelected;
      }
      if (element.key! == "pets_permitted") {
        petsPermitted = element.isSelected;
      }
      if (element.key! == "lift") {
        lift = element.isSelected;
      }
      if (element.key! == "parking_space") {
        parkingSpace = element.isSelected;
      }
      if (element.key! == "garage") {
        garage = element.isSelected;
      }
      if (element.key! == "balcony_terrace_patio") {
        balconyTerracePatio = element.isSelected;
      }
      if (element.key! == "new_building") {
        newBuilding = element.isSelected;
      }
      if (element.key! == "old_building") {
        oldBuilding = element.isSelected;
      }
      if (element.key! == "corner_house_or_end_of_terrace_house") {
        cornerHouseOrEndOfTerraceHouse = element.isSelected;
      }
      if (element.key! == "mid_terrace_house") {
        midTerraceHouse = element.isSelected;
      }
      if (element.key! == "house_or_flat_share") {
        houseOrFlatShare = element.isSelected;
      }
      if (element.key! == "energy_efficient_construction") {
        energyEfficientConstruction = element.isSelected;
      }
      if (element.key! == "minergie_certified") {
        minergieCertified = element.isSelected;
      }
    }
    notifyListeners();
  }

  //=======================================================================================
  // Get value of age of ads values (true/false)
  // Age od ads
  int? ageOfAdIndex;
  setAgeOfAdIndex(int index, context) {
    ageOfAdIndex = index;
    ageOfAdList[index].isSelected = !ageOfAdList[index].isSelected!;

    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  String? ageOfAdValue;

  getAgeOfAd() {
    for (var element in ageOfAdList) {
      if (ageOfAdIndex == ageOfAdList.indexOf(element) &&
          element.isSelected == true) {
        ageOfAdValue = element.key;
      }
      if (ageOfAdIndex == ageOfAdList.indexOf(element) &&
          element.isSelected == true) {
        ageOfAdValue = element.key;
      }
      if (ageOfAdIndex == ageOfAdList.indexOf(element) &&
          element.isSelected == true) {
        ageOfAdValue = element.key;
      }
      if (ageOfAdIndex == ageOfAdList.indexOf(element) &&
          element.isSelected == true) {
        ageOfAdValue = element.key;
      }
      if (ageOfAdIndex == ageOfAdList.indexOf(element) &&
          element.isSelected == true) {
        ageOfAdValue = element.key;
      }
    }
    notifyListeners();
  }

  //=======================================================================================
  // Get value of get ads values (true/false)

  setAdsWithCurrentIndex(int index, context) {
    adsWithList[index].isSelected = !adsWithList[index].isSelected!;
    getAdsWith();
    getFilterData(context, 0, 1, RouterHelper.filterScreen);

    notifyListeners();
  }

  bool? adsWithImages;
  bool? adsWithPrices;
  bool? adsWithVirtualTour;
  bool? adsWithVideos;

  getAdsWith() {
    for (var element in adsWithList) {
      if (element.key! == "only_ads_with_images") {
        adsWithImages = element.isSelected;
      }
      if (element.key! == "only_ads_with_prices") {
        adsWithPrices = element.isSelected;
      }
      if (element.key! == "only_ads_with_virtual_tour") {
        adsWithVirtualTour = element.isSelected;
      }
      if (element.key! == "only_ads_with_videos") {
        adsWithVideos = element.isSelected;
      }
    }
    notifyListeners();
  }

  // ================================================================================
  //LOADER SECTION
  bool? isLoading;
  bool? isFilerLoading;
  //Loading
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool? isPagination;

  int currentPage = 1;
  int lastPage = 0;
  resetPages() {
    currentPage = 1;
    lastPage = 0;
    notifyListeners();
  }

  // set Is Pagination
  setPagination(bool value) {
    isPagination = value;
    notifyListeners();
  }

  setPageIncrement() {
    currentPage = currentPage + 1;
    notifyListeners();
  }

  setFilterLoading(context, bool value) {
    isFilerLoading = value;
    if (value == true) {
      loaderDialog(context);
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  //===============================================================================
  // Reset Filters

  resetFiler(context, int isReset) {
    ownershipType = "for_rent";

    categoryId = null;

    propertySelectedIndex = null;

    //filterFloorList
    for (var element in filterFloorList) {
      element.isSelected = false;
    }

    //characteristicsList
    for (var element in characteristicsList) {
      element.isSelected = false;
    }

    //Currency
    currencyRadioListIndex = 0;
    currencyValue = "chf";

    //From
    fromDateRadioListIndex = 0;
    getFromDateMonthYearFromCurrent();
    fromDateValue = "immediately";

    //To
    toDateRadioListIndex = 0;
    getToDateMonthYearFromCurrent();
    toDateValue = "any";

    //age of ad
    ageOfAdIndex = null;

    //bedroom
    bedRoomIndex = null;

    //bathroom
    bathRoomIndex = null;

    //characteristicsList
    for (var element in adsWithList) {
      element.isSelected = false;
    }
    ageOfAdValue = "";
    adsWithImages = false;
    adsWithPrices = false;
    adsWithVirtualTour = false;
    adsWithVideos = false;

    clearTextField();
    resetPages();

    //RangeValues
    areaValues = const RangeValues(0, 500);
    //PriceRangeValue
    priceValues = const RangeValues(0, 5000000);
    //Selected City
    selectedCity = null;
    latitude = null;
    langitude = null;

    Provider.of<SearchMapProvider>(context, listen: false).clearDrawPolygon();

    // Reset Results Data
    propertiesListModel = PropertiesListModel();

    notifyListeners();
  }

  //===============================================================================
  //APIs Calling
  // GET Category
  getCategoryList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Category  ==========================>>>");
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.getPropertyCategoriesUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      propertyCategoryModel = PropertyCategoryModel.fromJson(responseBody);
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  Future<void> getCharacteristicsList(
      BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Characteristics  ==========================>>>");
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.getCharacteristicsUrl, {});
      final responseBody = response.data;
      debugPrint(
          "Characteristics response body ===============>>> $responseBody");
      characteristicsModel = CharacteristicsModel.fromJson(responseBody);
      if (characteristicsModel.error == false) {
        characteristicsList.clear();
        for (var element in characteristicsModel.data!) {
          characteristicsList.add(CharacteristicsData(
              key: element.key, title: element.title, isSelected: false));
        }
      }
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
  }

  // GET AGE OF AD
  Future<void> getAgeOfAdList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get age of ad  ==========================>>>");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getAgeOfAdUrl, {});
      final responseBody = response.data;
      debugPrint("Age of ad response body ===============>>> $responseBody");
      ageOfAdModel = AgeOfAdModel.fromJson(responseBody);
      if (ageOfAdModel.error == false) {
        ageOfAdList.clear();
        ageOfAdModel.data!.forEach((key, value) {
          ageOfAdList
              .add(AgeOfAdData(key: key, value: value, isSelected: false));
        });
      }
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
  }

  // GET  ADS WITH
  Future<void> getAdsWithList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Characteristics  ==========================>>>");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getAdsWithUrl, {});
      final responseBody = response.data;
      debugPrint(
          "Characteristics response body ===============>>> $responseBody");
      adsWithModel = AdsWithModel.fromJson(responseBody);

      if (adsWithModel.error == false) {
        adsWithList.clear();
        adsWithModel.data!.forEach((key, value) {
          adsWithList
              .add(AdsWithData(key: key, value: value, isSelected: false));
        });
      }

      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
  }

  // GET Number of Floors
  Future<void> getFilterFloorsList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Category  ==========================>>>");
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.getFloorFilterListUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      filterFloorListModel = FilterFloorListModel.fromJson(responseBody);
      if (filterFloorListModel.error == false) {
        filterFloorList.clear();
        filterFloorListModel.data!.forEach((key, value) {
          filterFloorList.add(
              FloorSelectedData(key: key, value: value, isSelected: false));
        });
      }

      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
  }

  //Get The value of Filter

  getFilterData(context, int pagination, int page, String screen) async {
    final mapProvider = Provider.of<SearchMapProvider>(context, listen: false);
    if (pagination == 1) {
      setPagination(true);
    } else {
      setFilterLoading(context, true);
    }

    debugPrint("isLoading: $isFilerLoading");
    debugPrint(" get Filter data  ==========================>>>");
    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.propertiesListUrl, {
        "ownership_type": ownershipType,
        //"Optional ( Accepted values, for_sale, for_rent)",

        "categoryId": categoryId,
        //"Optional (Property Type)",

        "price_range[min]": priceValues.start,

        //Optional

        "price_range[max]": priceValues.end,
        //Optional

        "living_space_range[min]": areaValues.start,

        // Optional (Area Range)

        "living_space_range[max]": areaValues.end,
        //Optional

        "floor[only_on_the_ground_floor]": onlyOnTheGroundFloor,
        //Optional

        "floor[not_on_the_ground]": notOnTheGround,

        "floor[include_unspecified]": includeUnspecified,

        "availability_from": fromDateValue,

        "availability_to": toDateValue,

        "currency": currencyValue,

        "exterior[lift]": lift,

        "exterior[parking_space]": parkingSpace,

        "exterior[garage]": garage,

        "exterior[balcony_terrace_patio]": balconyTerracePatio,

        "other_features[new_building]": newBuilding,

        "other_features[old_building]": oldBuilding,

        "equipment[energy_efficient_construction]": energyEfficientConstruction,

        "equipment[minergie_certified]": minergieCertified,

        //"new building project": null,
        // not clear for this key

        "interior[wheelchair_accessible]": wheelchairAccessible,

        "interior[pets_permitted]": petsPermitted,

        "other_features[house_or_flat_share]": houseOrFlatShare,

        "other_features[corner_house_or_end_of_terrace_house]":
            cornerHouseOrEndOfTerraceHouse,

        "other_features[mid_terrace_house]": midTerraceHouse,

        "bed_rooms": bedRoomIndex == null ? "" : bedRoomIndex! + 1,

        "age_of_ad": ageOfAdValue ?? "",

        "bath_rooms": bathRoomIndex == null ? "" : bathRoomIndex! + 1,

        "ads_with[only_ads_with_images]": adsWithImages,

        "ads_with[only_ads_with_prices]": adsWithPrices,

        "ads_with[only_ads_with_virtual_tour]": adsWithVirtualTour,

        "ads_with[only_ads_with_videos]": adsWithVideos,
        "sort_by_filter": selectedSortValue,
        "address[postcode_city]": selectedCity,
        "address[lat]": latitude,
        "address[lng]": langitude,
        "coordinates":
            mapProvider.drawnMapList.isEmpty ? [] : mapProvider.drawnMapList,
        "page": page,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      lastPage = PropertiesListModel.fromJson(responseBody).meta!.lastPage!;
      if (page == 1) {
        propertiesListModel = PropertiesListModel.fromJson(responseBody);
      } else if (page <= lastPage) {
        for (var value in PropertiesListModel.fromJson(responseBody).data!) {
          if (!propertiesListModel.data!.contains(value)) {
            propertiesListModel.data!.add(value);
          }
        }
      }

      if (pagination == 1) {
        setPagination(false);
      } else {
        setFilterLoading(context, false);
      }
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      if (pagination == 1) {
        setPagination(false);
      } else {
        setFilterLoading(context, false);
      }
      debugPrint("isLoading: $isLoading");
    }
  }

  // ===========================================================================
  //Create Alert

  createAlert(context, String screen) async {
    final mapProvider = Provider.of<SearchMapProvider>(context, listen: false);
    getFloor();
    getCharacteristics();
    getAgeOfAd();
    getAdsWith();
    setFilterLoading(context, true);
    debugPrint("isLoading: $isFilerLoading");
    debugPrint("Create Alert  ==========================>>>");
    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.createAlertUrl, {
        "name": alertNameController.text,
        "email": emailController.text,

        "ownership_type": ownershipType,
        //"Optional ( Accepted values, for_sale, for_rent)",

        "categoryId": categoryId,
        //"Optional (Property Type)",

        "price_range[min]": priceValues.start,

        //Optional

        "price_range[max]": priceValues.end,
        //Optional

        "living_space_range[min]": areaValues.start,

        // Optional (Area Range)

        "living_space_range[max]": areaValues.end,
        //Optional

        "floor[only_on_the_ground_floor]": onlyOnTheGroundFloor,
        //Optional

        "floor[not_on_the_ground]": notOnTheGround,

        "floor[include_unspecified]": includeUnspecified,

        "availability_from": fromDateValue,

        "availability_to": toDateValue,

        "currency": currencyValue,

        "exterior[lift]": lift,

        "exterior[parking_space]": parkingSpace,

        "exterior[garage]": garage,

        "exterior[balcony_terrace_patio]": balconyTerracePatio,

        "other_features[new_building]": newBuilding,

        "other_features[old_building]": oldBuilding,

        "equipment[energy_efficient_construction]": energyEfficientConstruction,

        "equipment[minergie_certified]": minergieCertified,

        //"new building project": null,
        // not clear for this key

        "interior[wheelchair_accessible]": wheelchairAccessible,

        "interior[pets_permitted]": petsPermitted,

        "other_features[house_or_flat_share]": houseOrFlatShare,

        "other_features[corner_house_or_end_of_terrace_house]":
            cornerHouseOrEndOfTerraceHouse,

        "other_features[mid_terrace_house]": midTerraceHouse,

        "bed_rooms": bedRoomIndex == null ? "" : bedRoomIndex! + 1,

        "age_of_ad": ageOfAdValue ?? "",

        "bath_rooms": bathRoomIndex == null ? "" : bathRoomIndex! + 1,

        "ads_with[only_ads_with_images]": adsWithImages,

        "ads_with[only_ads_with_prices]": adsWithPrices,

        "ads_with[only_ads_with_virtual_tour]": adsWithVirtualTour,

        "ads_with[only_ads_with_videos]": adsWithVideos,

        "sort_by_filter": selectedSortValue,
        "address[postcode_city]": selectedCity,
        "address[lat]": latitude,
        "address[lng]": langitude,
        "coordinates":
            mapProvider.drawnMapList.isEmpty ? null : mapProvider.drawnMapList
      });
      final responseBody = response.data;
      debugPrint("create alert response body ===============>>> $responseBody");
      createAlertModel = CreateAlertModel.fromJson(responseBody);

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(context,
          createAlertModel.message!, createAlertModel.error == false ? 0 : 1));
      setFilterLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setFilterLoading(context, false);
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  updateAlert(context, String screen) async {
    final mapProvider = Provider.of<SearchMapProvider>(context, listen: false);
    getFloor();
    getCharacteristics();
    getAgeOfAd();
    getAdsWith();
    setFilterLoading(context, true);
    debugPrint("isLoading: $isFilerLoading");
    debugPrint("Update Alert  ==========================>>>");
    String url = "${ApiUrl.updateAlertUrl}$alertId";
    try {
      Response response = await apiRepo.postData(context, screen, url, {
        "name": alertNameController.text,
        "email": emailController.text,
        "_method": "PUT",
        "ownership_type": ownershipType,

        "categoryId": categoryId,

        "price_range[min]": priceValues.start,

        //Optional

        "price_range[max]": priceValues.end,
        //Optional

        "living_space_range[min]": areaValues.start,

        // Optional (Area Range)

        "living_space_range[max]": areaValues.end,
        //Optional

        "floor[only_on_the_ground_floor]": onlyOnTheGroundFloor,
        //Optional

        "floor[not_on_the_ground]": notOnTheGround,

        "floor[include_unspecified]": includeUnspecified,

        "availability_from": fromDateValue,

        "availability_to": toDateValue,

        "currency": currencyValue,

        "exterior[lift]": lift,

        "exterior[parking_space]": parkingSpace,

        "exterior[garage]": garage,

        "exterior[balcony_terrace_patio]": balconyTerracePatio,

        "other_features[new_building]": newBuilding,

        "other_features[old_building]": oldBuilding,

        "equipment[energy_efficient_construction]": energyEfficientConstruction,

        "equipment[minergie_certified]": minergieCertified,

        //"new building project": null,
        // not clear for this key

        "interior[wheelchair_accessible]": wheelchairAccessible,

        "interior[pets_permitted]": petsPermitted,

        "other_features[house_or_flat_share]": houseOrFlatShare,

        "other_features[corner_house_or_end_of_terrace_house]":
            cornerHouseOrEndOfTerraceHouse,

        "other_features[mid_terrace_house]": midTerraceHouse,

        "bed_rooms": bedRoomIndex == null ? "" : bedRoomIndex! + 1,

        "age_of_ad": ageOfAdValue ?? "",

        "bath_rooms": bathRoomIndex == null ? "" : bathRoomIndex! + 1,

        "ads_with[only_ads_with_images]": adsWithImages,

        "ads_with[only_ads_with_prices]": adsWithPrices,

        "ads_with[only_ads_with_virtual_tour]": adsWithVirtualTour,

        "ads_with[only_ads_with_videos]": adsWithVideos,

        "sort_by_filter": selectedSortValue,
        "address[postcode_city]": selectedCity,
        "address[lat]": latitude,
        "address[lng]": langitude,
        "coordinates":
            mapProvider.drawnMapList.isEmpty ? null : mapProvider.drawnMapList
      });
      final responseBody = response.data;
      debugPrint("update alert response body ===============>>> $responseBody");
      createAlertModel = CreateAlertModel.fromJson(responseBody);

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(context,
          createAlertModel.message!, createAlertModel.error == false ? 0 : 1));

      setFilterLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setFilterLoading(context, false);
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  getAlertList(context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isFilerLoading");
    debugPrint("Get Alert  ==========================>>>");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getAlertUrl, {});
      final responseBody = response.data;
      debugPrint("Get alert response body ===============>>> $responseBody");
      getAlertModel = GetAlertModel.fromJson(responseBody);
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  deleteAlert(context, String screen, int id) async {
    debugPrint("isLoading: $isFilerLoading");
    debugPrint("Delete Alert  ==========================>>>");
    String url = "${ApiUrl.deleteAlertUrl}$id";
    try {
      Response response = await apiRepo.deleteData(context, screen, url, {});
      final responseBody = response.data;
      debugPrint("Delete alert response body ===============>>> $responseBody");
      deleteAlertModel = DeleteAlertModel.fromJson(responseBody);
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(context,
          deleteAlertModel.message!, deleteAlertModel.error == false ? 0 : 1));
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  DrawnMapModel drawnMapModel = DrawnMapModel();
  editAlertData(context) {
    final mapProvider = Provider.of<SearchMapProvider>(context, listen: false);
    debugPrint(
        "ALERT=========================================>>>>>>>>>>>>>>>>>>>>>>>>");
    final alertData = getAlertModel.data![alertIndex!];
    for (var element in getAlertModel.data!) {
      if (element.id == alertId) {
        //===================================================================
        // name ane email
        alertNameController.text = alertData.name!;
        emailController.text = alertData.email!;

        //===================================================================
        // Property Category
        propertyCategoryModel.data!.asMap().forEach((index, element) {
          if (element.id == alertData.propertyCategoryId) {
            categoryId = alertData.propertyCategoryId;
            propertySelectedIndex = index;
          }
        });
        //===================================================================
        // Ownership type Toggle button

        ownershipType = alertData.ownershipType;
        toggleIndex = alertData.ownershipType == "for_rent" ? 0 : 1;
        //===================================================================
        // Selected City
        if (alertData.address != null) {
          if (alertData.address!.postcodeCity != null) {
            selectedCity = alertData.address!.postcodeCity;
          }
          if (alertData.address!.lat != null) {
            latitude = double.tryParse(alertData.address!.lat.toString());
            langitude = double.tryParse(alertData.address!.lng.toString());
          }
        }
        //===================================================================
        // Currency

        currencyRadioList.asMap().forEach((index, element) {
          if (element == alertData.currency) {
            currencyValue = alertData.currency!;
            currencyRadioListIndex = index;
          }
        });

        //===================================================================
        // Availability
        //From Date
        fromDateRadioList.asMap().forEach((index, element) {
          if (element == alertData.availabilityFrom) {
            fromDateValue = alertData.availabilityFrom!;
            fromDateRadioListIndex = index;
          }
        });

        //To Date
        toDateRadioList.asMap().forEach((index, element) {
          if (element == alertData.availabilityTo) {
            toDateValue = alertData.availabilityTo!;
            toDateRadioListIndex = index;
          }
        });

        //===================================================================
        // Price Range

        double? minPrice = alertData.priceRange!.min == null
            ? 1.0
            : double.tryParse(alertData.priceRange!.min!)!.toDouble();

        double? maxPrice = alertData.priceRange!.max == null
            ? 1.0
            : double.tryParse(alertData.priceRange!.max!)!.toDouble();

        priceValues = RangeValues(minPrice, maxPrice);

        int fieldMinPrice = alertData.priceRange!.min == null
            ? 1
            : double.tryParse(alertData.priceRange!.min!)!.round();

        minPriceController.text = fieldMinPrice.toString();

        int fieldMaxPrice = alertData.priceRange!.max == null
            ? 1
            : double.tryParse(alertData.priceRange!.max!)!.round();

        maxPriceController.text = fieldMaxPrice.toString();

        //===================================================================
        // Area Range

        double? minArea = alertData.livingSpaceRange!.min == null
            ? 1.0
            : double.tryParse(alertData.livingSpaceRange!.min!)!.toDouble();

        double? maxArea = alertData.livingSpaceRange!.max == null
            ? 1.0
            : double.tryParse(alertData.livingSpaceRange!.max!)!.toDouble();

        int fieldMinArea = alertData.livingSpaceRange!.min == null
            ? 1
            : double.tryParse(alertData.livingSpaceRange!.min!)!.round();

        minAreaController.text = fieldMinArea.toString();

        int fieldMaxArea = alertData.livingSpaceRange!.max == null
            ? 1
            : double.tryParse(alertData.livingSpaceRange!.max!)!.round();

        maxAreaController.text = fieldMaxArea.toString();

        areaValues = RangeValues(minArea, maxArea);

        //===================================================================
        // Floor

        for (var element in filterFloorList) {
          alertData.floor!.forEach((key, value) {
            if (element.key == key) {
              element.isSelected = value;
            }
          });
        }
        //===================================================================
        // Characteristics

        for (var element in characteristicsList) {
          alertData.characteristics!.forEach((key, value) {
            if (element.key == key) {
              element.isSelected = value;
            }
          });
        }
        //===================================================================
        // Age of Ad
        if (alertData.ageOfAd != null) {
          for (var element in ageOfAdList) {
            if (element.key == alertData.ageOfAd!) {
              element.isSelected = true;
              ageOfAdIndex = ageOfAdList.indexOf(element);
            }
          }
        }

        //===================================================================
        // Ads with

        for (var element in adsWithList) {
          alertData.adsWith!.forEach((key, value) {
            if (element.key == key) {
              element.isSelected = value;
            }
          });
        }

        //===================================================================
        // Bedroom

        bedRoomIndex = alertData.bedRooms == null || alertData.bedRooms == 0
            ? null
            : alertData.bedRooms! - 1;

        //===================================================================
        // Bathroom

        bathRoomIndex = alertData.bathRooms == null || alertData.bathRooms == 0
            ? null
            : alertData.bathRooms! - 1;

        //==================================================================

        for (var element in alertData.coordinates!) {
          double? newLat = double.tryParse(element.lat!);
          double? newLang = double.tryParse(element.lng!);

          mapProvider.userPolyLinesLatLngList.add(LatLng(newLat!, newLang!));

          mapProvider.drawnMapList
              .add(drawnMapModel.toJson(newLat: newLat, newLng: newLang));
        }

        mapProvider.polyLines.add(
          Polyline(
            polylineId: const PolylineId('user_polyline'),
            points: mapProvider.userPolyLinesLatLngList,
            width: 3,
            color: bluePrimary,
          ),
        );

        mapProvider.polygons.add(
          Polygon(
            polygonId: const PolygonId('user_polygon'),
            points: mapProvider.userPolyLinesLatLngList,
            strokeWidth: 3,
            strokeColor: bluePrimary,
            fillColor: Colors.transparent,
          ),
        );
      }
    }
    notifyListeners();
  }

  // ===========================================================================
  //Get Cities
  // Search City Controller
  TextEditingController searchCityController = TextEditingController();

  CitiesModel citiesModel = CitiesModel();
  PlacesModel placesModel = PlacesModel();

  String? countrySelectedValue = "Switzerland";
  String? selectedCity;
  List<String> placesList = [];
  String? placeId;

  clearSearch() {
    searchCityController.clear();
    notifyListeners();
  }

  clearLocation() {
    selectedCity = null;
    langitude = null;
    latitude = null;
    notifyListeners();
  }

  setCity(String newCity) {
    selectedCity = newCity;
    notifyListeners();
  }

  getCitiesList(String pattern) async {
    String request =
        '$placesBaseURL$pattern+in+$countrySelectedValue&types=geocode&key=$mapAPIKey';
    var response = await http.get(Uri.parse(request));
    try {
      if (response.statusCode == 200) {
        if (placesList.isNotEmpty) {
          placesList.clear();
        }

        var data = json.decode(response.body);
        citiesModel = CitiesModel.fromJson(data);

        for (var element in citiesModel.predictions!) {
          if (element.description!.endsWith(countrySelectedValue!)) {
            placesList.add(element.description!);
            placeId = element.placeId;
          }
        }
      } else {
        throw Exception("Error Found ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('$e');
    }
    return placesList;
  }

  double? latitude;
  double? langitude;

  setLatLng(double newLat, double newLng) {
    latitude = newLat;
    langitude = newLng;
    notifyListeners();
  }

  getPlace(String pattern) async {
    // try {
    //   var locations = await locationFromAddress(pattern);
    //   if (locations.isNotEmpty) {
    //     latitude = locations[0].latitude;
    //     langitude = locations[0].longitude;
    //     placesModel.status = "OK";
    //   }
    //   debugPrint("latitude=============================== $latitude");
    //   debugPrint("lagitude =============================== $langitude");
    // } catch (e) {
    //   throw Exception("Error Found $e");
    // }
    try {
      String request = '$geocodingBaseURL$pattern&key=$mapAPIKey';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        List coordinatesList = data['results']
            .map((prediction) => prediction['geometry']['location'])
            .toList();
        for (Map<String, dynamic> latLang in coordinatesList) {
          debugPrint('Latlang===========================: $latLang');
          latitude = latLang.entries.first.value;
          langitude = latLang.entries.last.value;
          placesModel.status = "OK";
          debugPrint('langitude: $latitude, Longitude: $langitude');
        }
      }
    } catch (e) {
      debugPrint('Error getting location from city name: $e');
    }
    notifyListeners();
  }

  // ===========================================================================
  // LOADING DIALOG

  loaderDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
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
