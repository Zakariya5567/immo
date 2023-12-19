// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:immo/data/api_models/properties/property_list_model.dart';
import 'package:immo/data/api_models/cities_model.dart';
import 'package:immo/data/api_models/places_model.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/view/widgets/custom_snackbar.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/api_models/favourite_model/favourite_model.dart';
import '../data/api_models/favourite_model/favourite_un_favourite_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_category_model.dart';
import '../data/api_models/properties/delete_model.dart';
import '../data/api_models/properties/duplicate_model.dart';
import '../data/api_models/properties/properties_detail_model.dart';
import '../data/api_models/properties/report_ad_model.dart';
import '../data/api_models/submit_response.dart';
import '../data/api_repo.dart';
import '../helper/routes_helper.dart';
import '../utils/api_url.dart';
import '../utils/app_constant.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../utils/size.dart';
import '../utils/string.dart';
import '../view/widgets/circular_progress.dart';

class HomePageProvider extends ChangeNotifier {
  //Variables
  bool? isLoading;
  bool? isPropertyLoading;
  bool isdraftListLoading = true;
  bool isActiveListLoading = true;
  String? userId;
  bool? isPagination;
  bool isHomepageListReset = false;

  int currentPage = 1;
  int lastPage = 0;

// FOR NOTIFICATION
  bool? isNotify;

  resetPages() {
    currentPage = 1;
    lastPage = 0;
    notifyListeners();
  }

  resetHomePageList() {
    isHomepageListReset = false;
  }

  setNotificationStatus(bool value) async {
    debugPrint("set Notification");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppConstant.isNotify, value);
    isNotify = sharedPreferences.getBool(AppConstant.isNotify);
    debugPrint("isNotify : $isNotify");
    notifyListeners();
  }

  // Search City Controller
  TextEditingController searchCityController = TextEditingController();

  //List
  List<PropertiesData> activePropertiesList = [];
  List<PropertiesData> draftPropertiesList = [];

  //Models
  PropertyCategoryModel propertyCategoryModel = PropertyCategoryModel();
  PropertiesListModel propertiesListModel = PropertiesListModel();
  FavouriteModel favouriteModel = FavouriteModel();
  FavouriteUnFavouriteModel favouriteUnFavouriteModel =
      FavouriteUnFavouriteModel();

  CitiesModel citiesModel = CitiesModel();
  PlacesModel placesModel = PlacesModel();
  DeleteModel deleteModel = DeleteModel();
  DuplicateModel duplicateModel = DuplicateModel();
  PropertiesDetailModel propertiesDetailModel = PropertiesDetailModel();

  //Api Repo
  ApiRepo apiRepo = ApiRepo();
  // Rent Button
  bool isButtonSelected = true;
  bool isToggleLoading = true;
  bool? isDetailLoading;

  //Filters for home screen
  // Highlight the category button
  int? propertySelectedIndex;
  // filter
  int? categoryId;
  String ownershipType = "for_rent";

  int imageSelectedIndex = 0;

  setDetailLoading(bool value) {
    isDetailLoading = value;
    notifyListeners();
  }

  setImageSelectedIndex(int newIndex) {
    imageSelectedIndex = newIndex;
    notifyListeners();
  }

  // Set Ownership button color Rent/Buy
  setButtonFlag(int index) {
    if (index == 0) {
      ownershipType = "for_rent";
      isButtonSelected = true;
    } else if (index == 1) {
      ownershipType = "for_sale";
      isButtonSelected = false;
    }
    notifyListeners();
  }

  clearData() {
    propertySelectedIndex = null;
    categoryId = null;
    notifyListeners();
  }

  setToggleLoading(bool value) {
    isToggleLoading = value;
    notifyListeners();
  }

  Color getRentButtonColor() {
    if (isButtonSelected) {
      return orangePrimary;
    } else {
      return Colors.transparent;
    }
  }

  Color getRentButtonTextColor() {
    if (isButtonSelected) {
      return whitePrimary;
    } else {
      return blackPrimary;
    }
  }

  // Buy Button
  Color getbuyButtonColor() {
    if (isButtonSelected) {
      return Colors.transparent;
    } else {
      return orangePrimary;
    }
  }

  Color getbuyButtonTextColor() {
    if (isButtonSelected) {
      return blackPrimary;
    } else {
      return whitePrimary;
    }
  }

  //City Validation

  cityValidation(value) {
    if (value.isEmpty) {
      return enterCity;
    }
  }

  setPropertySelectedIndex({required int index, required int newCategoryId}) {
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
    debugPrint("index:$index categoryId : $newCategoryId");
    notifyListeners();
  }

  setPropertyFavouriteIconById(int id, BuildContext context) {
    if (propertiesListModel.data != null) {
      for (var element in propertiesListModel.data!) {
        if (element.id == id) {
          element.isFavourite == true
              ? element.isFavourite = false
              : element.isFavourite = true;
        }
      }
    }
    if (propertiesDetailModel.data != null) {
      if (propertiesDetailModel.data!.id! == id) {
        propertiesDetailModel.data!.isFavourite == true
            ? propertiesDetailModel.data!.isFavourite = false
            : propertiesDetailModel.data!.isFavourite = true;
      }
    }
    if (favouriteModel.data != null) {
      favouriteModel.data!.asMap().forEach((index, value) {
        if (value.id == id) {
          favouriteModel.data!.removeAt(index);
        }
      });
    }

    final filerProvider =
        Provider.of<FilterScreenProvider>(context, listen: false);
    if (filerProvider.propertiesListModel.data != null) {
      filerProvider.propertiesListModel.data!.asMap().forEach((index, value) {
        if (value.id == id) {
          value.isFavourite == true
              ? value.isFavourite = false
              : value.isFavourite = true;
          filerProvider.notifyListeners();
        }
      });
    }

    notifyListeners();
  }

  // set Is Pagination
  setPagination(bool value) {
    isPagination = value;
    notifyListeners();
  }

  //Loading
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Property Loading
  setPropertyLoading(bool value) {
    isPropertyLoading = value;
    notifyListeners();
  }

  setDraftListLoading(bool value) {
    isdraftListLoading = value;
    notifyListeners();
  }

  setActiveListLoading(bool value) {
    isActiveListLoading = value;
    notifyListeners();
  }

  setUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString(AppConstant.userId);
    notifyListeners();
  }

  // When the user tap on favourite icon we will remove the item from the favourite list
  removeFavouriteFromList(int index) {
    if (favouriteUnFavouriteModel.error == false) {
      favouriteModel.data!.removeAt(index);
    }
    notifyListeners();
  }

  // remove item from the list

  removePropertyFromList(int index, int isActive, BuildContext context) async {
    if (deleteModel.error == false) {
      if (isActive == 1) {
        activePropertiesList.removeAt(index);
        setLoading(true);
        resetPages();
        await getActivePropertyList(
            context, 0, 1, 1, RouterHelper.myAdsListScreen);
      } else {
        draftPropertiesList.removeAt(index);
        setLoading(true);
        resetPages();
        await getActivePropertyList(
            context, 0, 1, 0, RouterHelper.myAdsListScreen);
      }
    }
    notifyListeners();
  }

  // APIs Calling =========================================================
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

  //GET PROPERTY LIST

  getPropertyList(
      BuildContext context, int pagination, int page, String screen) async {
    if (pagination == 1) {
      setPagination(true);
    } else {
      setPropertyLoading(true);
    }
    debugPrint("isLoading: $isLoading");
    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.propertiesListUrl, {
        "categoryId": categoryId,
        'page': page,
        "ownership_type": ownershipType,
        "address[postcode_city]":
            searchCityController.text == "" ? null : searchCityController.text,
        "address[lat]": latitude,
        "address[lng]": langitude,
      });

      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      if (pagination == 0) {
        resetPages();
        isHomepageListReset = true;
      } else {
        isHomepageListReset = false;
      }
      lastPage = PropertiesListModel.fromJson(responseBody).meta!.lastPage!;
      if (page != 1) {
        for (var element in PropertiesListModel.fromJson(responseBody).data!) {
          if (!propertiesListModel.data!.contains(element)) {
            propertiesListModel.data!.add(element);
          }
        }
      } else {
        propertiesListModel = PropertiesListModel.fromJson(responseBody);
      }

      if (pagination == 1) {
        setPagination(false);
      } else {
        setPropertyLoading(false);
      }
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      if (pagination == 1) {
        setPagination(false);
      } else {
        setPropertyLoading(false);
      }
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  // GET PROPERTY BY ID -> PROPERTY DETAIL

  getPropertyById(BuildContext context, String screen, int id) async {
    setDetailLoading(true);
    debugPrint("isLoading: $isLoading");
    try {
      final url = ApiUrl.getPropertyByIdUrl + id.toString();

      Response response = await apiRepo.getData(context, screen, url, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      propertiesDetailModel = PropertiesDetailModel.fromJson(responseBody);
      setDetailLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setDetailLoading(false);
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Get Property List
  getActivePropertyList(BuildContext context, int pagination, int page,
      int index, String screen) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString(AppConstant.userId);
    if (pagination == 1) {
      setPagination(true);
    } else {
      setLoading(true);
      setDraftListLoading(true);
      setActiveListLoading(true);
    }
    debugPrint("isLoading: $isLoading");
    debugPrint("dropLoading: $isdraftListLoading");
    debugPrint("activeLoading: $isActiveListLoading");
    debugPrint(" User Id ==========================>>> $userId");

    try {
      Response response = userId!.isNotEmpty
          ? await apiRepo.postData(
              context, screen, '${ApiUrl.propertiesListUrl}?user_id=$userId', {
              'page': page,
              'published': index,
            })
          : await apiRepo.postData(context, screen, ApiUrl.propertiesListUrl, {
              'page': page,
            });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      propertiesListModel = PropertiesListModel.fromJson(responseBody);
      if (propertiesListModel.error == false) {
        if (pagination != 1) {
          if (activePropertiesList.isNotEmpty) {
            activePropertiesList.clear();
          }
          if (draftPropertiesList.isNotEmpty) {
            draftPropertiesList.clear();
          }
        }
        for (var element in propertiesListModel.data!) {
          if (element.published == 1) {
            activePropertiesList.add(element);
          }
          if (element.published == 0) {
            draftPropertiesList.add(element);
          }
        }
      }
      if (pagination == 1) {
        setPagination(false);
      } else {
        setDraftListLoading(false);
        setActiveListLoading(false);
        setLoading(false);
      }
      debugPrint("isLoading: $isLoading");
      debugPrint("dropLoading: $isdraftListLoading");
      debugPrint("activeLoading: $isActiveListLoading");
    } catch (e) {
      if (pagination == 1) {
        setPagination(false);
      } else {
        setDraftListLoading(false);
        setActiveListLoading(false);
        setLoading(false);
      }
      debugPrint("isLoading: $isLoading");
      debugPrint("dropLoading: $isdraftListLoading");
      debugPrint("activeLoading: $isActiveListLoading");
    }

    notifyListeners();
  }

  setPageIncrement() {
    currentPage = currentPage + 1;
    notifyListeners();
  }

  //GET FAVOURITE LIST
  getFavouriteList(
      BuildContext context, int pagination, int page, String screen) async {
    if (pagination == 1) {
      setPagination(true);
    } else {
      setLoading(true);
    }
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getFavouriteUrl, {
        'page': page,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      if (page != 1) {
        for (var element in FavouriteModel.fromJson(responseBody).data!) {
          if (!favouriteModel.data!.contains(element)) {
            favouriteModel.data!.add(element);
          }
        }
      } else {
        favouriteModel = FavouriteModel.fromJson(responseBody);
      }
      pagination == 1 ? setPagination(false) : setLoading(false);

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      pagination == 1 ? setPagination(false) : setLoading(false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  //FAVOURITE UN FAVOURITE DATA
  favouriteUnFavourite(BuildContext context, String screen, int id) async {
    try {
      final url = ApiUrl.favouriteUnFavouriteUrl + id.toString();
      Response response = await apiRepo.getData(context, screen, url, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      favouriteUnFavouriteModel =
          FavouriteUnFavouriteModel.fromJson(responseBody);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  //DELETE PROPERTIES
  deleteProperty(context, String screen, int id) async {
    debugPrint("Delete Property  ==========================>>>");
    String url = "${ApiUrl.deletePropertyUrl}$id";
    try {
      Response response = await apiRepo.deleteData(context, screen, url, {});
      final responseBody = response.data;
      debugPrint(
          "Delete property response body ===============>>> $responseBody");
      deleteModel = DeleteModel.fromJson(responseBody);

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  //DELETE PROPERTIES
  duplicateProperty(context, String screen, int id) async {
    debugPrint("Duplicated Property  ==========================>>>");
    String url = "${ApiUrl.duplicatePropertyUrl}$id";
    try {
      Response response = await apiRepo.getData(context, screen, url, {});
      final responseBody = response.data;
      debugPrint(
          "Delete property response body ===============>>> $responseBody");
      duplicateModel = DuplicateModel.fromJson(responseBody);

      if (duplicateModel.error == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar(context, duplicateModel.message!, 1));
      }
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  //Download
  downloadCsvFile(
      BuildContext context, String screen, String url, String localPath) async {
    setReportLoading(context, true);
    debugPrint("download csv  ==========================>>>");

    String fileName = url.substring(url.lastIndexOf("/") + 1);
    debugPrint("file :$fileName");
    List splitList = fileName.split("?");
    debugPrint("list :$splitList");
    debugPrint("file name is  : ${splitList.first}");
    String savePath =
        '$localPath${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}_${DateTime.now().millisecond}_${splitList.first}';

    try {
      Response response =
          await apiRepo.downloadData(context, screen, url, savePath);
      if (response.statusCode == 200) {
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackBar(context, downloadSuccessful, 0));
          try {
            OpenAppFile.open(savePath);
          } catch (er) {
            ScaffoldMessenger.of(context)
                .showSnackBar(customSnackBar(context, downloadpdfreader, 1));
          }
        });
      }

      setReportLoading(context, false);
    } catch (e) {
      setReportLoading(context, false);
    }

    notifyListeners();
  }

  //========================================================================
  //GET AD REPORT

  TextEditingController firstAndLastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  clearTextField() {
    firstAndLastNameController.clear();
    phoneNumberController.clear();
    emailController.clear();
    descriptionController.clear();
    selectedIndex = 0;
    notifyListeners();
  }

  // Validation

  // drop down
  int selectedIndex = 0;

  String? reasonString;

  setDropDownValue(
      {required String title, required String value, required int index}) {
    selectedIndex = index;
    reasonString = value;
    notifyListeners();
  }

  ReportAdModel reportAdModel = ReportAdModel();
  List<String> reportList = [];

  // GET REPORT
  getReportAdList(BuildContext context, String screen) async {
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.getPropertyReportUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      reportAdModel = ReportAdModel.fromJson(responseBody);

      if (reportAdModel.error == false) {
        reportList.clear();
        reportAdModel.data!.forEach((key, value) {
          reportList.add(value);
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  // POST REPORT

  createReportAd(context, screen, id) async {
    setReportLoading(context, true);
    try {
      Response response = await apiRepo
          .postData(context, screen, ApiUrl.createPropertyReportUrl, {
        "property_id": id,
        "reason": reasonString == null || reasonString == ""
            ? reportList.first
            : reasonString,
        "email": emailController.text,
        "telephone_number": "+41 ${phoneNumberController.text}",
        "information": descriptionController.text,
      });
      final responseBody = response.data;
      debugPrint(
          "Create Report response body ===============>>> $responseBody");
      reportAdModel = ReportAdModel.fromJson(responseBody);
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(context,
          reportAdModel.message!, reportAdModel.error == false ? 0 : 1));
      setReportLoading(context, false);
    } catch (e) {
      setReportLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  SubmitResponse submitResponse = SubmitResponse();

  submitContactUs(BuildContext context, String screen, int id) async {
    setReportLoading(context, true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" Submit contact us ==========================>>>");

    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.sendInquiryUrl, {
        "property_id": id,
        "full_name": firstAndLastNameController.text,
        "phone_number": "+41 ${phoneNumberController.text}",
        "email": emailController.text,
        "message": descriptionController.text,
      });
      final responseBody = response.data;
      debugPrint("Submit response body ===============>>> $responseBody");
      submitResponse = SubmitResponse.fromJson(responseBody);

      if (submitResponse.error == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, submitResponse.message.toString(), 0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, submitResponse.message.toString(), 1));
      }

      setReportLoading(context, false);
    } catch (e) {
      setReportLoading(context, false);
    }

    notifyListeners();
  }

  //=======================================================================
  // GET CITES

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

  //========================================================================
  bool? isReportLoading;
  //Loading

  setReportLoading(context, bool value) {
    isReportLoading = value;
    if (value == true) {
      loaderDialog(context);
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

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
