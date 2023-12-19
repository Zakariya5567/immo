// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:immo/utils/string.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import '../data/api_models/post_an_ad/last_step/publish_ad_model.dart';
import 'package:immo/data/api_models/properties/property_list_model.dart';
import '../data/api_models/post_an_ad/step_four/save_contact_form.dart';
import '../data/api_models/post_an_ad/step_one/setep_one_contries_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_category_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_no_of_floors_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_no_of_housing_units_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_no_of_rooms_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_save_property_model.dart';
import '../data/api_models/post_an_ad/step_one/step_one_sub_category_model.dart';
import '../data/api_models/post_an_ad/step_three/delete_file_model.dart';
import '../data/api_models/post_an_ad/step_three/save_doc_modle.dart';
import '../data/api_models/post_an_ad/step_three/save_image_model.dart';
import '../data/api_models/post_an_ad/step_three/save_pdf_model.dart';
import '../data/api_models/post_an_ad/step_two/step_two_save_details_model.dart';
import '../utils/constants.dart';
import '../view/widgets/location_access_permission.dart';
import '/data/api_models/post_an_ad/file_data.Dart';
import '../data/api_repo.dart';
import '../utils/api_url.dart';
import '../utils/size.dart';
import '../view/widgets/circular_progress.dart';
import '../view/widgets/custom_snackbar.dart';

class PostAnAdProvider extends ChangeNotifier {
  TextEditingController titleOfAdController = TextEditingController();
  TextEditingController livingSpaceController = TextEditingController();
  TextEditingController floorSpaceController = TextEditingController();
  TextEditingController plotAreaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController grossReturnController = TextEditingController();
  TextEditingController rentIncludeUtilitiesController =
      TextEditingController();
  TextEditingController utilitiesController = TextEditingController();
  TextEditingController rentExcludeUtilitiesController =
      TextEditingController();
  TextEditingController postCodeandCityController = TextEditingController();
  TextEditingController streetAndHouseNumberController =
      TextEditingController();
  TextEditingController roomHeightController = TextEditingController();
  TextEditingController hallHeightController = TextEditingController();
  TextEditingController cubageController = TextEditingController();
  TextEditingController numberOfFloorsController = TextEditingController();
  TextEditingController numberofBathroomsController = TextEditingController();
  TextEditingController certificateNumberController = TextEditingController();
  TextEditingController liftingCapacityOfTheCraneController =
      TextEditingController();
  TextEditingController loadingCapacityOfTheGoodsLiftController =
      TextEditingController();
  TextEditingController floorLoadCapacityController = TextEditingController();
  TextEditingController shopsController = TextEditingController();
  TextEditingController kindergartenController = TextEditingController();
  TextEditingController primarySchoolController = TextEditingController();
  TextEditingController secondarySchoolController = TextEditingController();
  TextEditingController publicTransportController = TextEditingController();
  TextEditingController motorwayController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController renovatedYearController = TextEditingController();
  TextEditingController constructionYearController = TextEditingController();
  TextEditingController editPdfNameController = TextEditingController();
  TextEditingController youtubeLink1Controller = TextEditingController();
  TextEditingController youtubeLink2Controller = TextEditingController();
  TextEditingController webLinkController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //Variables
  File? image;
  File? filePDF;
  bool? isImageUpdate;
  bool? isLoading;
  bool? isSecondScreenLoading;
  bool? isSaveLoading;
  bool? isSubCategoryLoading;
  // ignore: prefer_typing_uninitialized_variables
  var firstStepData;
  ApiRepo apiRepo = ApiRepo();
  List<String> placesList = ["Switzerland", "France"];
  List<String> citiesList = ["Zürich", "Paris"];
  bool isSubscriptionPackegeSelected = false;
  int? propertyAdId;
  //Models
  PropertyCategoryModel propertyCategoryModel = PropertyCategoryModel();
  PropertySubCategoryModel propertySubCategoryModel =
      PropertySubCategoryModel();
  NoOfRoomsModel noOfRoomsModel = NoOfRoomsModel();
  NoOfHousingUnitsModel noOfHousingUnitsModel = NoOfHousingUnitsModel();
  NoOfFloorsModel noOfFloorsModel = NoOfFloorsModel();
  CountriesModel countriesModel = CountriesModel();
  SavePropertiesModel savePropertiesModel = SavePropertiesModel();
  SaveDetailsModel saveDetailsModel = SaveDetailsModel();
  SaveImageModel saveImageModel = SaveImageModel();
  SavePdfModel savePdfModel = SavePdfModel();
  SaveDocModel saveDocModel = SaveDocModel();
  SaveContactFormModel saveContactFormModel = SaveContactFormModel();
  PublishadModel publishadModel = PublishadModel();
  DeleteFileModel deleteFileModel = DeleteFileModel();

  //File Save Lists
  List<FileData> imageModelList = [];
  List<FileData> pdfModelList = [];

  //Drop Down Lists
  List<String> prpoertyCategoryList = ["Flat", "House"];
  List<int> prpoertyCategoryIdList = [1, 12];
  List<String> prpoertySubCategoryList = ["Flat", "Attic Flat"];
  List<int> prpoertySubCategoryIdList = [2, 3];
  List<String> noOfRoomsList = ["0", "1"];
  List<String> noOfRoomsIdList = ["0", "1"];
  List<String> noOfHousingUnitsList = ["0", "1"];
  List<String> noOfHousingUnitsIdList = ["0", "1"];
  List<String> noOfFloorsList = ["0", "1"];
  List<String> noOfFloorsIdList = ["0", "1"];
  List<String> countriesList = ["Switzerland", "France"];
  List<int> countriesIdList = [212, 1];

  // Loacation Access Parameters
  double? selectedStreetLatitude;
  double? selectedStreetLongitude;
  double? selectedCityLatitude;
  double? selectedCityLongitude;
  Set<Marker> markers = {};
  double height = 0;
  double width = 0;
  String? address;
  //User Location Controller
  Completer<GoogleMapController> currentLocationController =
      Completer<GoogleMapController>();

  //Get and Set data from Draft Ad or Active Ad
  /*====================
  Step 1 (Main Details)
  ======================*/
  //Screen 1st Data
  setListData(value) {
    firstStepData = value;
    propertyAdId = value.id!;
    // Set Category Selected
    categoryListId = value.propertyCategory.id;
    categorySelectedValue = value.propertyCategory.title;
    getCategoryIndex(value);
    // Set Sub Category Selected
    if (categoryListId != 23) {
      subCategoryListId = value.propertySubCategory.id;
      subCategorySelectedValue = value.propertySubCategory.title;
      getSubCategoryIndex(value);
    }
    // Set Type of OwnerShip
    if (categoryListId == 23) {
      // Ctegory is Multi-family Residential(categoryListId == 23)
      currentIndexForPage1List = 0;
      radioListPage1 = [forSale];
    } else if (value.ownershipType == "for_rent") {
      currentIndexForPage1List = 0;
    } else if (value.ownershipType == "for_sale") {
      currentIndexForPage1List = 1;
    }
    /*===============
    Step 2 (Details)
    =================*/
    if (value.detail != null) {
      setdetailsScreenData(value.detail);
    }
    /*================
    Step 3 (Documents)
    ==================*/
    if (value.documents != null) {
      setDocumentScreenData(value.documents);
    }
    /*===============
    Step 4 (Contact)
    =================*/
    if (value.contact != null) {
      setContactScreenData(value.contact);
    }
  }

  //Second Screen
  setLoadSecondPadeData(bool value) {
    isSecondScreenLoading = value;
    notifyListeners();
  }

  setSecondScreenData() {
    if (categoryListId == firstStepData.propertyCategory.id) {
      // title of Ad
      titleOfAdController.text = firstStepData.title;
      // get number of rooms
      if (firstStepData.numberOfRooms != null) {
        noOfRoomSelectedValue = firstStepData.numberOfRooms.toString();
        noOfRoomListId = firstStepData.numberOfRooms.toString();
        getNumberOfRoomsIndex(firstStepData);
      }
      // get number of Housing Units
      if (firstStepData.numberOfHousingUnits != null) {
        noOfHousingUnitsSelectedValue =
            firstStepData.numberOfHousingUnits.toString();
        noOfHousingUnitsListId = firstStepData.numberOfHousingUnits.toString();
        noOfHousingUnitsSelected =
            int.parse((firstStepData.numberOfHousingUnits - 1).toString());
      }
      // Living Space of Ad
      if (firstStepData.livingSpace != null) {
        livingSpaceController.text = firstStepData.livingSpace.toString();
      }
      // plot area
      if (firstStepData.plotArea != null) {
        plotAreaController.text = firstStepData.plotArea.toString();
      }
      // floor space
      if (firstStepData.floorSpace != null) {
        floorSpaceController.text = firstStepData.floorSpace.toString();
      }
      // floors
      if (firstStepData.floor != null) {
        getFloorIndex(firstStepData);
        noOfFloorsSelectedValue = firstStepData.floor.toString();
        noOfFloorsListId = firstStepData.floor.toString();
      }
      // Availability
      if (firstStepData.availability == "for_date") {
        currentIndexVerticalRadioListPage2 = 0;
        dateController.text =
            '${firstStepData.date.day}/${firstStepData.date.month}/${firstStepData.date.year}';
      } else if (firstStepData.availability == "immediately") {
        currentIndexVerticalRadioListPage2 = 1;
      } else if (firstStepData.availability == "on_request") {
        currentIndexVerticalRadioListPage2 = 2;
      }
      // Description
      if (firstStepData.description != null) {
        descriptionController.text = firstStepData.description.toString();
      }
      // Currency
      if (firstStepData.currency == "chf") {
        currentIndexHorizontalRadioListPage2 = 0;
      } else if (firstStepData.currency == "eur") {
        currentIndexHorizontalRadioListPage2 = 1;
      } else if (firstStepData.currency == "usd") {
        currentIndexHorizontalRadioListPage2 = 2;
      }
      // rent Include Utilities Field
      if (firstStepData.rentIncludingUtilities != null) {
        rentIncludeUtilitiesController.text =
            firstStepData.rentIncludingUtilities.toString();
      }
      //  Utilities Field
      if (firstStepData.utilities != null) {
        utilitiesController.text = firstStepData.utilities.toString();
      }
      // rent exclude Utilities Field
      if (firstStepData.rentExcludingUtilities != null) {
        rentExcludeUtilitiesController.text =
            firstStepData.rentExcludingUtilities.toString();
      }
      // price on request
      if (firstStepData.priceOnRequest == 0) {
        checkValues[priceOnRequest] = false;
      } else if (firstStepData.priceOnRequest == 1) {
        checkValues[priceOnRequest] = true;
      }
      // Selling price
      if (firstStepData.sellingPrice != null) {
        sellingPriceController.text = firstStepData.sellingPrice.toString();
      }
      // Gross Rent
      if (firstStepData.grossReturn != null && categoryListId == 23) {
        grossReturnController.text = firstStepData.grossReturn.toString();
      }
      // Indication of price
      if (firstStepData.indicationOfPrice == "total_area_monthly") {
        currentIndexForIndicationPriceList = 0;
      } else if (firstStepData.indicationOfPrice == "per_m2_anually") {
        currentIndexForIndicationPriceList = 0;
      }
      //Country
      countrySelected = firstStepData.country.id - 1;
      countrySelectedValue = firstStepData.country.name;
      countryListId = firstStepData.country.id;
      // postcode and City
      postCodeandCityController.text = firstStepData.postcodeCity;
      // Street and House Number
      if (firstStepData.streetHouseNumber != null) {
        streetAndHouseNumberController.text = firstStepData.streetHouseNumber;
      }
      // Set Latitude and Longitude
      if (firstStepData.lat != null) {
        selectedCityLatitude = double.tryParse(firstStepData.lat);
      }
      if (firstStepData.lng != null) {
        selectedCityLongitude = double.tryParse(firstStepData.lng);
      }
      if (firstStepData.streetLat != null) {
        selectedStreetLatitude = double.tryParse(firstStepData.streetLat);
      }
      if (firstStepData.streetLng != null) {
        selectedStreetLongitude = double.tryParse(firstStepData.streetLng);
      }
    }
  }

  //Get Category Property List Index
  getCategoryIndex(value) {
    if (value.propertyCategory.id == 1) {
      categorySelected = 0;
    } else if (value.propertyCategory.id == 12) {
      categorySelected = 1;
    } else if (value.propertyCategory.id == 23) {
      categorySelected = 2;
    } else if (value.propertyCategory.id == 24) {
      categorySelected = 3;
    } else if (value.propertyCategory.id == 28) {
      categorySelected = 4;
    } else if (value.propertyCategory.id == 46) {
      categorySelected = 5;
    } else if (value.propertyCategory.id == 84) {
      categorySelected = 6;
    } else if (value.propertyCategory.id == 88) {
      categorySelected = 7;
    } else if (value.propertyCategory.id == 100) {
      categorySelected = 8;
    } else if (value.propertyCategory.id == 101) {
      categorySelected = 9;
    }
  }

  //Get Sub Category Property List Index
  getSubCategoryIndex(value) {
    if (value.propertySubCategory.id == 2 ||
        value.propertySubCategory.id == 13 ||
        value.propertySubCategory.id == 25 ||
        value.propertySubCategory.id == 29 ||
        value.propertySubCategory.id == 47 ||
        value.propertySubCategory.id == 85 ||
        value.propertySubCategory.id == 89 ||
        value.propertySubCategory.id == 102) {
      subCategorySelected = 0;
    } else if (value.propertySubCategory.id == 3 ||
        value.propertySubCategory.id == 14 ||
        value.propertySubCategory.id == 26 ||
        value.propertySubCategory.id == 30 ||
        value.propertySubCategory.id == 48 ||
        value.propertySubCategory.id == 86 ||
        value.propertySubCategory.id == 90 ||
        value.propertySubCategory.id == 103) {
      subCategorySelected = 1;
    } else if (value.propertySubCategory.id == 4 ||
        value.propertySubCategory.id == 15 ||
        value.propertySubCategory.id == 27 ||
        value.propertySubCategory.id == 31 ||
        value.propertySubCategory.id == 49 ||
        value.propertySubCategory.id == 87 ||
        value.propertySubCategory.id == 91 ||
        value.propertySubCategory.id == 104) {
      subCategorySelected = 2;
    } else if (value.propertySubCategory.id == 5 ||
        value.propertySubCategory.id == 16 ||
        value.propertySubCategory.id == 32 ||
        value.propertySubCategory.id == 50 ||
        value.propertySubCategory.id == 92) {
      subCategorySelected = 3;
    } else if (value.propertySubCategory.id == 6 ||
        value.propertySubCategory.id == 17 ||
        value.propertySubCategory.id == 33 ||
        value.propertySubCategory.id == 51 ||
        value.propertySubCategory.id == 93) {
      subCategorySelected = 4;
    } else if (value.propertySubCategory.id == 7 ||
        value.propertySubCategory.id == 18 ||
        value.propertySubCategory.id == 34 ||
        value.propertySubCategory.id == 52 ||
        value.propertySubCategory.id == 94) {
      subCategorySelected = 5;
    } else if (value.propertySubCategory.id == 8 ||
        value.propertySubCategory.id == 19 ||
        value.propertySubCategory.id == 35 ||
        value.propertySubCategory.id == 53 ||
        value.propertySubCategory.id == 95) {
      subCategorySelected = 6;
    } else if (value.propertySubCategory.id == 9 ||
        value.propertySubCategory.id == 20 ||
        value.propertySubCategory.id == 36 ||
        value.propertySubCategory.id == 54 ||
        value.propertySubCategory.id == 96) {
      subCategorySelected = 7;
    } else if (value.propertySubCategory.id == 10 ||
        value.propertySubCategory.id == 21 ||
        value.propertySubCategory.id == 37 ||
        value.propertySubCategory.id == 55 ||
        value.propertySubCategory.id == 97) {
      subCategorySelected = 8;
    } else if (value.propertySubCategory.id == 11 ||
        value.propertySubCategory.id == 22 ||
        value.propertySubCategory.id == 38 ||
        value.propertySubCategory.id == 56 ||
        value.propertySubCategory.id == 98) {
      subCategorySelected = 9;
    } else if (value.propertySubCategory.id == 39 ||
        value.propertySubCategory.id == 57 ||
        value.propertySubCategory.id == 99) {
      subCategorySelected = 10;
    } else if (value.propertySubCategory.id == 40 ||
        value.propertySubCategory.id == 58) {
      subCategorySelected = 11;
    } else if (value.propertySubCategory.id == 41 ||
        value.propertySubCategory.id == 59) {
      subCategorySelected = 12;
    } else if (value.propertySubCategory.id == 42 ||
        value.propertySubCategory.id == 60) {
      subCategorySelected = 13;
    } else if (value.propertySubCategory.id == 43 ||
        value.propertySubCategory.id == 61) {
      subCategorySelected = 14;
    } else if (value.propertySubCategory.id == 44 ||
        value.propertySubCategory.id == 62) {
      subCategorySelected = 15;
    } else if (value.propertySubCategory.id == 45 ||
        value.propertySubCategory.id == 63) {
      subCategorySelected = 16;
    } else if (value.propertySubCategory.id == 64) {
      subCategorySelected = 17;
    } else if (value.propertySubCategory.id == 65) {
      subCategorySelected = 18;
    } else if (value.propertySubCategory.id == 66) {
      subCategorySelected = 19;
    } else if (value.propertySubCategory.id == 67) {
      subCategorySelected = 20;
    } else if (value.propertySubCategory.id == 68) {
      subCategorySelected = 21;
    } else if (value.propertySubCategory.id == 69) {
      subCategorySelected = 22;
    } else if (value.propertySubCategory.id == 70) {
      subCategorySelected = 23;
    } else if (value.propertySubCategory.id == 71) {
      subCategorySelected = 24;
    } else if (value.propertySubCategory.id == 72) {
      subCategorySelected = 25;
    } else if (value.propertySubCategory.id == 73) {
      subCategorySelected = 26;
    } else if (value.propertySubCategory.id == 74) {
      subCategorySelected = 27;
    } else if (value.propertySubCategory.id == 75) {
      subCategorySelected = 28;
    } else if (value.propertySubCategory.id == 76) {
      subCategorySelected = 29;
    } else if (value.propertySubCategory.id == 77) {
      subCategorySelected = 30;
    } else if (value.propertySubCategory.id == 78) {
      subCategorySelected = 31;
    } else if (value.propertySubCategory.id == 79) {
      subCategorySelected = 32;
    } else if (value.propertySubCategory.id == 80) {
      subCategorySelected = 33;
    } else if (value.propertySubCategory.id == 81) {
      subCategorySelected = 34;
    } else if (value.propertySubCategory.id == 82) {
      subCategorySelected = 35;
    } else if (value.propertySubCategory.id == 83) {
      subCategorySelected = 36;
    }
  }

  //Get Number Rooms index
  getNumberOfRoomsIndex(value) {
    if (value.numberOfRooms == 1.0) {
      noOfRoomSelected = 0;
    } else if (value.numberOfRooms == 1.5) {
      noOfRoomSelected = 1;
    } else if (value.numberOfRooms == 2.0) {
      noOfRoomSelected = 2;
    } else if (value.numberOfRooms == 2.5) {
      noOfRoomSelected = 3;
    } else if (value.numberOfRooms == 3.0) {
      noOfRoomSelected = 4;
    } else if (value.numberOfRooms == 3.5) {
      noOfRoomSelected = 5;
    } else if (value.numberOfRooms == 4.0) {
      noOfRoomSelected = 6;
    } else if (value.numberOfRooms == 4.5) {
      noOfRoomSelected = 7;
    } else if (value.numberOfRooms == 5.0) {
      noOfRoomSelected = 8;
    } else if (value.numberOfRooms == 5.5) {
      noOfRoomSelected = 9;
    } else if (value.numberOfRooms == 6.0) {
      noOfRoomSelected = 10;
    } else if (value.numberOfRooms == 6.5) {
      noOfRoomSelected = 11;
    } else if (value.numberOfRooms == 7.0) {
      noOfRoomSelected = 12;
    } else if (value.numberOfRooms == 7.5) {
      noOfRoomSelected = 13;
    } else if (value.numberOfRooms == 8.0) {
      noOfRoomSelected = 14;
    } else if (value.numberOfRooms == 8.5) {
      noOfRoomSelected = 15;
    } else if (value.numberOfRooms == 9.0) {
      noOfRoomSelected = 16;
    } else if (value.numberOfRooms == 9.5) {
      noOfRoomSelected = 17;
    } else if (value.numberOfRooms == 10.0) {
      noOfRoomSelected = 18;
    } else if (value.numberOfRooms == 10.5) {
      noOfRoomSelected = 19;
    } else if (value.numberOfRooms == 11.0) {
      noOfRoomSelected = 20;
    } else if (value.numberOfRooms == 11.5) {
      noOfRoomSelected = 21;
    } else if (value.numberOfRooms == 12.0) {
      noOfRoomSelected = 22;
    } else if (value.numberOfRooms == 12.5) {
      noOfRoomSelected = 23;
    } else if (value.numberOfRooms == 13.0) {
      noOfRoomSelected = 24;
    } else if (value.numberOfRooms == 13.5) {
      noOfRoomSelected = 25;
    } else if (value.numberOfRooms == 14.0) {
      noOfRoomSelected = 26;
    } else if (value.numberOfRooms == 14.5) {
      noOfRoomSelected = 27;
    } else if (value.numberOfRooms == 15.0) {
      noOfRoomSelected = 28;
    } else if (value.numberOfRooms == 15.5) {
      noOfRoomSelected = 29;
    } else if (value.numberOfRooms == 16.0) {
      noOfRoomSelected = 30;
    } else if (value.numberOfRooms == 16.5) {
      noOfRoomSelected = 31;
    } else if (value.numberOfRooms == 17.0) {
      noOfRoomSelected = 32;
    } else if (value.numberOfRooms == 17.5) {
      noOfRoomSelected = 33;
    } else if (value.numberOfRooms == 18.0) {
      noOfRoomSelected = 34;
    } else if (value.numberOfRooms == 18.5) {
      noOfRoomSelected = 35;
    } else if (value.numberOfRooms == 19.0) {
      noOfRoomSelected = 36;
    } else if (value.numberOfRooms == 19.5) {
      noOfRoomSelected = 37;
    } else if (value.numberOfRooms == 20.0) {
      noOfRoomSelected = 38;
    }
  }

  // get floors index
  getFloorIndex(value) {
    if (value.floor == "4. Basement") {
      noOfFloorsSelected = 0;
    } else if (value.floor == "3. Basement") {
      noOfFloorsSelected = 1;
    } else if (value.floor == "2. Basement") {
      noOfFloorsSelected = 2;
    } else if (value.floor == "1. Basement") {
      noOfFloorsSelected = 3;
    } else if (value.floor == "Ground Floor") {
      noOfFloorsSelected = 4;
    } else if (value.floor == "1. Floor") {
      noOfFloorsSelected = 5;
    } else if (value.floor == "2. Floor") {
      noOfFloorsSelected = 6;
    } else if (value.floor == "3. Floor") {
      noOfFloorsSelected = 7;
    } else if (value.floor == "4. Floor") {
      noOfFloorsSelected = 8;
    } else if (value.floor == "5. Floor") {
      noOfFloorsSelected = 9;
    } else if (value.floor == "6. Floor") {
      noOfFloorsSelected = 10;
    } else if (value.floor == "7. Floor") {
      noOfFloorsSelected = 11;
    } else if (value.floor == "8. Floor") {
      noOfFloorsSelected = 12;
    } else if (value.floor == "9. Floor") {
      noOfFloorsSelected = 13;
    } else if (value.floor == "10. Floor") {
      noOfFloorsSelected = 14;
    } else if (value.floor == "11. Floor") {
      noOfFloorsSelected = 15;
    } else if (value.floor == "12. Floor") {
      noOfFloorsSelected = 16;
    } else if (value.floor == "13. Floor") {
      noOfFloorsSelected = 17;
    } else if (value.floor == "14. Floor") {
      noOfFloorsSelected = 18;
    } else if (value.floor == "15. Floor") {
      noOfFloorsSelected = 19;
    } else if (value.floor == "16. Floor") {
      noOfFloorsSelected = 20;
    } else if (value.floor == "17. Floor") {
      noOfFloorsSelected = 21;
    } else if (value.floor == "18. Floor") {
      noOfFloorsSelected = 22;
    } else if (value.floor == "19. Floor") {
      noOfFloorsSelected = 23;
    } else if (value.floor == "20. Floor") {
      noOfFloorsSelected = 24;
    } else if (value.floor == "21. Floor") {
      noOfFloorsSelected = 25;
    } else if (value.floor == "22. Floor") {
      noOfFloorsSelected = 26;
    } else if (value.floor == "23. Floor") {
      noOfFloorsSelected = 27;
    } else if (value.floor == "24. Floor") {
      noOfFloorsSelected = 28;
    } else if (value.floor == "25. Floor") {
      noOfFloorsSelected = 29;
    } else if (value.floor == "26. Floor") {
      noOfFloorsSelected = 30;
    } else if (value.floor == "27. Floor") {
      noOfFloorsSelected = 31;
    } else if (value.floor == "28. Floor") {
      noOfFloorsSelected = 32;
    } else if (value.floor == "29. Floor") {
      noOfFloorsSelected = 33;
    } else if (value.floor == "30. Floor") {
      noOfFloorsSelected = 34;
    } else if (value.floor == "31. Floor") {
      noOfFloorsSelected = 35;
    } else if (value.floor == "32. Floor") {
      noOfFloorsSelected = 36;
    } else if (value.floor == "33. Floor") {
      noOfFloorsSelected = 37;
    } else if (value.floor == "34. Floor") {
      noOfFloorsSelected = 38;
    } else if (value.floor == "35. Floor") {
      noOfFloorsSelected = 39;
    } else if (value.floor == "36. Floor") {
      noOfFloorsSelected = 40;
    } else if (value.floor == "37. Floor") {
      noOfFloorsSelected = 41;
    } else if (value.floor == "38. Floor") {
      noOfFloorsSelected = 42;
    } else if (value.floor == "39. Floor") {
      noOfFloorsSelected = 43;
    } else if (value.floor == "40. Floor") {
      noOfFloorsSelected = 44;
    }
  }

  /*===============
    Step 2 (Details)
    =================*/
  setdetailsScreenData(Detail detailsData) {
    /*========
    Dimensions
    =========*/

    // Room height
    if (detailsData.dimensions!.roomHeight != null) {
      roomHeightController.text = detailsData.dimensions!.roomHeight.toString();
    }
    // Hall Height
    if (detailsData.dimensions!.hallHeight != null) {
      hallHeightController.text = detailsData.dimensions!.hallHeight.toString();
    }
    // Cubage
    if (detailsData.dimensions!.cubage != null) {
      cubageController.text = detailsData.dimensions!.cubage.toString();
    }
    // Number of floors
    if (detailsData.dimensions!.numberOfFloors != null) {
      numberOfFloorsController.text =
          detailsData.dimensions!.numberOfFloors.toString();
    }
    /*======
    Interior
    =======*/
    // Check Boxes
    checkValues[view] = detailsData.interior!.view!;
    checkValues[attic] = detailsData.interior!.attic!;
    checkValues[cellar] = detailsData.interior!.cellar!;
    checkValues[toilets] = detailsData.interior!.toilets!;
    checkValues[firePlace] = detailsData.interior!.firePlace!;
    checkValues[storageRoom] = detailsData.interior!.storageRoom!;
    checkValues[petPermission] = detailsData.interior!.petsPermitted!;
    checkValues[wheelChairAccess] = detailsData.interior!.wheelchairAccessible!;
    // Number of bathrooms
    if (detailsData.interior!.numberOfBathrooms != null) {
      numberofBathroomsController.text =
          detailsData.interior!.numberOfBathrooms!.toString();
    }
    /*=======
    Equipment
    ========*/
    // Check Boxes
    checkValues[dishwasher] = detailsData.equipment!.dishwasher!;
    checkValues[gasSupply] = detailsData.equipment!.gasSupply!;
    checkValues[steamOven] = detailsData.equipment!.steamOven!;
    checkValues[waterSupply] = detailsData.equipment!.waterSupply!;
    if (detailsData.equipment!.liftingPlatform != null) {
      checkValues[liftingPlatform] = detailsData.equipment!.liftingPlatform!;
    }
    checkValues[ownDryer] = detailsData.equipment!.ownTumbleDryer!;
    checkValues[sewageConnection] = detailsData.equipment!.sewageConnection!;
    checkValues[electricitySupply] = detailsData.equipment!.electricitySupply!;
    checkValues[minergie] = detailsData.equipment!.minergieCertified!;
    checkValues[cableTV] = detailsData.equipment!.cableTvConnection!;
    checkValues[ownWashingMachine] = detailsData.equipment!.ownWashingMachine!;
    checkValues[energy] = detailsData.equipment!.energyEfficientConstruction!;
    // Minergie Certificate Number
    if (detailsData.equipment!.minergieCertificateNumber != null) {
      certificateNumberController.text =
          detailsData.equipment!.minergieCertificateNumber!;
    }
    // floor capacity
    if (detailsData.equipment!.floorLoadCapacity != null) {
      floorLoadCapacityController.text =
          detailsData.equipment!.floorLoadCapacity!.toString();
    }
    // Lifting Capacity of Crane
    if (detailsData.equipment!.liftingCapacityOfTheCrane != null) {
      liftingCapacityOfTheCraneController.text =
          detailsData.equipment!.liftingCapacityOfTheCrane!.toString();
    }
    // Loading Capacity of the good lift
    if (detailsData.equipment!.loadingCapacityOfTheGoodsLift != null) {
      loadingCapacityOfTheGoodsLiftController.text =
          detailsData.equipment!.loadingCapacityOfTheGoodsLift!.toString();
    }
    /*======
    Exterior
    =======*/
    // Check Boxes
    checkValues[lift] = detailsData.exterior!.lift!;
    checkValues[garage] = detailsData.exterior!.garage!;
    checkValues[playGround] = detailsData.exterior!.playGround!;
    checkValues[loadingRamp] = detailsData.exterior!.loadingRamp!;
    checkValues[parkingSpace] = detailsData.exterior!.parkingSpace!;
    checkValues[childFriendly] = detailsData.exterior!.childFriendly!;
    checkValues[railwaySiding] = detailsData.exterior!.railwaySiding ?? false;
    checkValues[balcony] = detailsData.exterior!.balconyTerracePatio!;
    /*==========
    Surroundings
    ===========*/
    // Shops
    if (detailsData.surroundings!.shops != null) {
      shopsController.text = detailsData.surroundings!.shops!.toString();
    }
    // Location
    if (detailsData.surroundings!.location != null) {
      locationController.text = detailsData.surroundings!.location!.toString();
    }
    // Kindergarten
    if (detailsData.surroundings!.kindergarten != null) {
      kindergartenController.text =
          detailsData.surroundings!.kindergarten!.toString();
    }
    // Primery School
    if (detailsData.surroundings!.primarySchool != null) {
      primarySchoolController.text =
          detailsData.surroundings!.primarySchool!.toString();
    }
    // Public transport
    if (detailsData.surroundings!.publicTransport != null) {
      publicTransportController.text =
          detailsData.surroundings!.publicTransport!.toString();
    }
    // Secondary School
    if (detailsData.surroundings!.secondarySchool != null) {
      secondarySchoolController.text =
          detailsData.surroundings!.secondarySchool!.toString();
    }
    // Motoraway
    if (detailsData.surroundings!.motorwayConnection != null) {
      motorwayController.text =
          detailsData.surroundings!.motorwayConnection!.toString();
    }
    /*============
    Other Features
    =============*/
    //building( New or Old)
    if (detailsData.otherFeatures!.building == "old_building") {
      currentIndexOtherFeatureRadioList == 0;
    } else if (detailsData.otherFeatures!.building == "new_building") {
      currentIndexOtherFeatureRadioList == 1;
    }
    // Costruction Year
    if (detailsData.constructionYear != null) {
      constructionYearController.text =
          detailsData.constructionYear!.toString();
    }
    // Last Year Renovated
    if (detailsData.lastYearRenovated != null) {
      renovatedYearController.text = detailsData.lastYearRenovated!.toString();
    }
    // Check Boxes
    checkValues[houseOrFlatShare] =
        detailsData.otherFeatures!.houseOrFlatShare!;
    checkValues[leaseHold] = detailsData.otherFeatures!.leaseHold!;
    checkValues[swimmingPool] = detailsData.otherFeatures!.swimmingPool!;
    checkValues[corneHouse] =
        detailsData.otherFeatures!.cornerHouseOrEndOfTerraceHouse!;
    checkValues[midTerraceHouse] = detailsData.otherFeatures!.midTerraceHouse!;
    checkValues[covered] = detailsData.otherFeatures!.covered!;
    checkValues[gardenHut] = detailsData.otherFeatures!.gardenHut!;
    checkValues[developed] = detailsData.otherFeatures!.developed!;
  }

  /*===============
    Step 3 (Documents)
    =================*/
  setDocumentScreenData(Documents documentsData) {
    // Image list
    if (documentsData.images!.isNotEmpty) {
      imageModelList = documentsData.images!;
    }
    // Youtube Links
    if (documentsData.youtubeVideos![0] != null) {
      // Youtube Link 1
      youtubeLink1Controller.text = documentsData.youtubeVideos![0];
    }
    if (documentsData.youtubeVideos![1] != null) {
      // Youtube Link 2
      youtubeLink2Controller.text = documentsData.youtubeVideos![1];
    }
    // Web Link
    if (documentsData.virtualTourLink != null) {
      webLinkController.text = documentsData.virtualTourLink!;
    }
    // Pdf list
    if (documentsData.pdfFiles!.isNotEmpty) {
      pdfModelList = documentsData.pdfFiles!;
    }
  }

  /*===============
    Step 4 (Contact)
    =================*/
  setContactScreenData(Contact contactData) {
    // Radio List
    if (contactData.contactFormType == "contact_form_and_telephone_number") {
      currentIndexVerticalRadioListPage5 = 0;
    } else if (contactData.contactFormType == "contact_form") {
      currentIndexVerticalRadioListPage5 = 1;
    } else if (contactData.contactFormType == "telephone_number") {
      currentIndexVerticalRadioListPage5 = 2;
    }
    // Email Address
    if (contactData.email != null) {
      emailController.text = contactData.email!;
    }
    // Telephone
    if (contactData.telephoneNumber != null) {
      telephoneController.text = _getFormattedValue(
          contactData.telephoneNumber!.toString().replaceFirst('+41', ''));
    }
    // Contact Person
    if (contactData.contactPerson != null) {
      contactPersonController.text = contactData.contactPerson!;
    }
    // Comment
    if (contactData.comment != null) {
      commentController.text = contactData.comment!;
    }
    notifyListeners();
  }

  //Phone Number formater
  String _getFormattedValue(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length <= 2) {
      return digitsOnly;
    } else if (digitsOnly.length <= 5) {
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2)}';
    } else if (digitsOnly.length <= 7) {
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 5)} ${digitsOnly.substring(5)}';
    } else {
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 5)} ${digitsOnly.substring(5, 7)} ${digitsOnly.substring(7)}';
    }
  }

  clearContactScreen() {
    currentIndexVerticalRadioListPage5 = 0;
    emailController.clear();
    telephoneController.clear();
    contactPersonController.clear();
    commentController.clear();
    notifyListeners();
  }

  // Clear text fields
  clearTextField() {
    titleOfAdController.clear();
    livingSpaceController.clear();
    floorSpaceController.clear();
    plotAreaController.clear();
    descriptionController.clear();
    sellingPriceController.clear();
    grossReturnController.clear;
    rentIncludeUtilitiesController.clear();
    utilitiesController.clear();
    rentExcludeUtilitiesController.clear();
    postCodeandCityController.clear();
    streetAndHouseNumberController.clear();
    cubageController.clear();
    numberOfFloorsController.clear();
    numberofBathroomsController.clear();
    certificateNumberController.clear();
    shopsController.clear();
    kindergartenController.clear();
    primarySchoolController.clear();
    secondarySchoolController.clear();
    publicTransportController.clear();
    motorwayController.clear();
    locationController.clear();
    renovatedYearController.clear();
    constructionYearController.clear();
    youtubeLink1Controller.clear();
    youtubeLink2Controller.clear();
    webLinkController.clear();
    emailController.clear();
    telephoneController.clear();
    contactPersonController.clear();
    commentController.clear();
    dateController.clear();
    roomHeightController.clear();
    hallHeightController.clear();
    liftingCapacityOfTheCraneController.clear();
    loadingCapacityOfTheGoodsLiftController.clear();
    floorLoadCapacityController.clear();
    notifyListeners();
  }

  // Clear Lists
  clearLists() {
    imageModelList.clear();
    pdfModelList.clear();
    notifyListeners();
  }

  //Clear Steps Fields
  clearFirstTwoStepsFields() {
    //Clear Text Fields
    titleOfAdController.clear();
    livingSpaceController.clear();
    floorSpaceController.clear();
    plotAreaController.clear();
    descriptionController.clear();
    sellingPriceController.clear();
    grossReturnController.clear();
    rentIncludeUtilitiesController.clear();
    utilitiesController.clear();
    rentExcludeUtilitiesController.clear();
    postCodeandCityController.clear();
    streetAndHouseNumberController.clear();
    cubageController.clear();
    numberOfFloorsController.clear();
    numberofBathroomsController.clear();
    certificateNumberController.clear();
    shopsController.clear();
    kindergartenController.clear();
    primarySchoolController.clear();
    secondarySchoolController.clear();
    publicTransportController.clear();
    motorwayController.clear();
    locationController.clear();
    renovatedYearController.clear();
    constructionYearController.clear();
    dateController.clear();
    roomHeightController.clear();
    hallHeightController.clear();
    liftingCapacityOfTheCraneController.clear();
    loadingCapacityOfTheGoodsLiftController.clear();
    floorLoadCapacityController.clear();
    //Clear CheckBoxes
    checkValues.updateAll((key, value) => false);

    currentIndexForPage1List = 0;
    currentIndexVerticalRadioListPage2 = 0;
    currentIndexHorizontalRadioListPage2 = 0;
    currentIndexForIndicationPriceList = 0;
    currentIndexOtherFeatureRadioList = 0;
    //clear index of sub category list
    subCategorySelected = 0;
    noOfRoomSelected = 0;
    noOfRoomSelectedValue = noOfRoomsList.first;
    noOfRoomListId = noOfRoomsIdList.first;
    noOfHousingUnitsSelected = 0;
    noOfHousingUnitsSelectedValue = noOfHousingUnitsList.first;
    noOfHousingUnitsListId = noOfHousingUnitsIdList.first;
    noOfFloorsSelected = 0;
    noOfFloorsSelectedValue = noOfFloorsList.first;
    noOfFloorsListId = noOfFloorsIdList.first;
    countrySelected = 0;
    countrySelectedValue = countriesList.first;
    countryListId = countriesIdList.first;
    // Loacation Access Parameters
    selectedStreetLatitude = 0.0;
    selectedStreetLongitude = 0.0;
    selectedCityLatitude = 0.0;
    selectedCityLongitude = 0.0;
    markers = {};
    height = 0;
    width = 0;
    address = "";
    //User Location Controller
    currentLocationController = Completer<GoogleMapController>();
    notifyListeners();
  }

  clearAllPostAdScreen() {
    //Clear first two screens
    clearFirstTwoStepsFields();
    propertyAdId = 0;
    //clear DropDownList
    categorySelected = 0;
    categorySelectedValue = prpoertyCategoryList.first;
    categoryListId = prpoertyCategoryIdList.first;
    subCategorySelectedValue = 'Flat';
    subCategoryListId = 2;
    //clear radio list Page 1
    radioListPage1 = [
      forRent,
      forSale,
    ];
    //Clear Image Model List
    imageModelList.clear();
    // Clear Pdf model List
    pdfModelList.clear();
    //Clear Document Step Fields
    youtubeLink1Controller.clear();
    youtubeLink2Controller.clear();
    webLinkController.clear();
    //clear step 4
    currentIndexVerticalRadioListPage5 = 0;
    emailController.clear();
    telephoneController.clear();
    contactPersonController.clear();
    commentController.clear();
    isSubscriptionPackegeSelected = false;
    // Stop Loading Second Screen
    isSecondScreenLoading = false;
    notifyListeners();
  }

  // Validation
  titleValidation(value) {
    if (value.isEmpty) {
      return enterTitle;
    }
  }

  priceValidationIncludeUtilities(value) {
    try {
      if (value.isEmpty) {
        return enterRentIncludingUtilities;
      } else if (int.parse(value) <= 0) {
        return validRentIncludingUtilities;
      }
    } catch (e) {
      return validRentIncludingUtilities;
    }
  }

  priceValidationUtilities(value) {
    try {
      if (value.isEmpty) {
        return enterUtilities;
      } else if (int.parse(value) <= 0) {
        return validUtilities;
      }
    } catch (e) {
      return validUtilities;
    }
  }

  priceValidationExcludeUtilities(value) {
    try {
      if (value.isEmpty) {
        return enterRentExcludingUtilities;
      } else if (int.parse(value) <= 0) {
        return validRentExcludingUtilities;
      }
    } catch (e) {
      return validRentExcludingUtilities;
    }
  }

  priceValidationSelling(value) {
    try {
      if (value.isEmpty) {
        return enterSellingPrice;
      } else if (int.parse(value) <= 0) {
        return validSellingPrice;
      }
    } catch (e) {
      return validSellingPrice;
    }
  }

  postcodeAndCityValidation(value) {
    if (value.isEmpty) {
      return enterPostcodeAnsdCity;
    }
  }

  youTubeLinkValidation(value) {
    if (value.isEmpty) {
      return null;
    } else if (!RegExp(
            r'^(?:https?:\/\/)?(?:www\.)?(?:m\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=|embed\/|v\/)?([a-zA-Z0-9\-_]{11})(?:\S+)?$')
        .hasMatch(value)) {
      return validYoutubeLink;
    }
  }

  webLinkValidation(value) {
    if (value.isEmpty) {
      return null;
    } else if (!RegExp(
            r'^(?:https?:\/\/)?(?:www\.)?(?:m\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=|embed\/|v\/)?([a-zA-Z0-9\-_]{11})(?:\S+)?$')
        .hasMatch(value))
    // (!RegExp(r'^(http|https):\/\/www\.[\w-]+\.\w{2,}\/?.*$')
    //     .hasMatch(value))
    {
      return validWebLink;
    }
  }

  emailValidation(value) {
    if (value.isEmpty) {
      return hintEmail;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return validEmail;
    }
    return null;
  }

  telephoneValidation(value) {
    String pattern = r'^\d{2}\s\d{3}\s\d{2}\s\d{2}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return enterTelephone;
    } else if (!regExp.hasMatch(value)) {
      return validTelephone;
    }
  }

  contactPersonValidation(value) {
    if (value.isEmpty) {
      return enterTitle;
    }
  }

  // Radio List

  //Post an ad Page 1 Radio List
  int currentIndexForPage1List = 0;
  List<String> radioListPage1 = [
    forRent,
    forSale,
  ];

  setCurrentIndexForPage1(int newIndex) {
    currentIndexForPage1List = newIndex;
    notifyListeners();
  }

  //Post an ad Page 2 Radio Lists
  int currentIndexVerticalRadioListPage2 = 0;
  List<String> verticalRadioListPage2 = [
    fromDate,
    immediately,
    onRequest,
  ];

  setCurrentIndexVerticalRadioListPage2(int newIndex) {
    currentIndexVerticalRadioListPage2 = newIndex;
    notifyListeners();
  }

  // Horizontal Radio List
  int currentIndexHorizontalRadioListPage2 = 0;
  List<String> horizontalRadioListPage2 = [
    chf,
    eur,
    usd,
  ];

  setCurrentIndexHorizontalRadioListPage2(int newIndex) {
    currentIndexHorizontalRadioListPage2 = newIndex;
    notifyListeners();
  }

  String priceVlaue() {
    return horizontalRadioListPage2[currentIndexHorizontalRadioListPage2];
  }

  // Indication of Price Radio List
  int currentIndexForIndicationPriceList = 0;
  List<String> radioListIndicationPrice = [
    totalAreaMonthly,
    perM2Annually,
  ];
  List<String> radioListIndicationPriceForSale = [
    totalArea,
    perM2,
  ];

  //Other Feature Radio List Page 3, Step 2
  setCurrentIndexForIndicationPrice(int newIndex) {
    currentIndexForIndicationPriceList = newIndex;
    notifyListeners();
  }

  int currentIndexOtherFeatureRadioList = 0;
  List<String> otherFeatureRadioList = [
    newBuilding,
    oldBuilding,
  ];
  setCurrentIndexForOtherFeatureRadioList(int newIndex) {
    currentIndexOtherFeatureRadioList = newIndex;
    notifyListeners();
  }

  //Post an ad Page 5 Radio Lists
  int currentIndexVerticalRadioListPage5 = 0;
  List<String> verticalRadioListPage5 = [
    contactFormAndTelephone,
    contactForm,
    telephoneNo,
  ];

  setCurrentIndexVerticalRadioListPage5(int newIndex) {
    currentIndexVerticalRadioListPage5 = newIndex;
    notifyListeners();
  }

  //Post an ad Page 7 Radio Lists
  int currentIndexContactFormListPage7 = 0;
  List<String> contactFormListPage7 = [];

  setCurrentIndexContactFormListPage7(int newIndex) {
    currentIndexContactFormListPage7 = newIndex;
    notifyListeners();
  }

  int currentIndexStandardListPage7 = 0;
  List<String> standardListPage7 = [
    standard,
  ];

  setCurrentIndexStandardListPage7(int newIndex) {
    currentIndexStandardListPage7 = newIndex;

    notifyListeners();
  }

  // CheckBoxes
  Map<String, bool> checkValues = {
    priceOnRequest: false, //0
    wheelChairAccess: false, //1
    petPermission: false, //2
    view: false, //3
    attic: false, //4
    cellar: false, //5
    storageRoom: false, //6
    firePlace: false, //7
    energy: false, //8
    minergie: false, //9
    steamOven: false, //10
    dishwasher: false, //11
    ownDryer: false, //12
    ownWashingMachine: false, //13
    cableTV: false, //14
    lift: false, //15
    balcony: false, //16
    childFriendly: false, //17
    playGround: false, //18
    parkingSpace: false, //19
    garage: false, //20
    houseOrFlatShare: false, //21
    leaseHold: false, //22
    swimmingPool: false, //23
    corneHouse: false, //24
    midTerraceHouse: false, //25
    waterSupply: false, //26
    loadingRamp: false, //27
    covered: false, //28
    gardenHut: false, //29
    sewageConnection: false, // 30
    electricitySupply: false, // 31
    gasSupply: false, // 32
    developed: false, // 33
    toilets: false, //34
    railwaySiding: false, //35
    liftingPlatform: false, //36
  };

  setCheckBoxValue(String key) {
    checkValues[key] == false
        ? checkValues[key] = true
        : checkValues[key] = false;
    if (key == priceOnRequest && checkValues[key] == true) {
      rentIncludeUtilitiesController.clear();
      rentExcludeUtilitiesController.clear();
      utilitiesController.clear();
      sellingPriceController.clear();
    }
    notifyListeners();
  }

  int categorySelected = 0;
  String? categorySelectedValue;
  int? categoryListId;

  int subCategorySelected = 0;
  String? subCategorySelectedValue;
  int? subCategoryListId;

  int noOfRoomSelected = 0;
  String? noOfRoomSelectedValue;
  String? noOfRoomListId;

  int noOfHousingUnitsSelected = 0;
  String? noOfHousingUnitsSelectedValue;
  String? noOfHousingUnitsListId;

  int noOfFloorsSelected = 0;
  String? noOfFloorsSelectedValue;
  String? noOfFloorsListId;

  int countrySelected = 0;
  String? countrySelectedValue;
  int? countryListId;

  setDropDownValue({
    required String title,
    required String value,
    required int index,
  }) {
    if (title == "flat") {
      categorySelected = index;
      categorySelectedValue = value;
    } else if (title == "home") {
      subCategorySelected = index;
      subCategorySelectedValue = value;
    } else if (title == "roomsList") {
      noOfRoomSelected = index;
      noOfRoomSelectedValue = value;
    } else if (title == "House") {
      noOfHousingUnitsSelected = index;
      noOfHousingUnitsSelectedValue = value;
    } else if (title == "floors") {
      noOfFloorsSelected = index;
      noOfFloorsSelectedValue = value;
    } else if (title == "country") {
      countrySelected = index;
      countrySelectedValue = value;
    }
    notifyListeners();
  }

  // Category List Id
  getCategoryIndexValue(newValue) {
    categoryListId = prpoertyCategoryIdList
        .elementAt(prpoertyCategoryList.indexOf(newValue!));
    subCategorySelected = 0;
    if (categoryListId == 23) {
      radioListPage1 = [
        forSale,
      ];
      currentIndexForPage1List = 0;
    } else {
      radioListPage1 = [
        forRent,
        forSale,
      ];
      currentIndexForPage1List = 0;
    }
    notifyListeners();
  }

  // Sub Category List Id
  getSubCategoryIndexValue(newValue) {
    subCategoryListId = prpoertySubCategoryIdList
        .elementAt(prpoertySubCategoryList.indexOf(newValue!));
    notifyListeners();
  }

  // No. of Rooms List Id
  getNoOfRoomsIndexValue(newValue) {
    noOfRoomListId =
        noOfRoomsIdList.elementAt(noOfRoomsIdList.indexOf(newValue!));
    notifyListeners();
  }

  // No. of Housing Units List Id
  getNoOfHousingUnitsIndexValue(newValue) {
    noOfHousingUnitsListId = noOfHousingUnitsIdList
        .elementAt(noOfHousingUnitsIdList.indexOf(newValue!));
    notifyListeners();
  }

  // No. of Floors List Id
  getNoOfFloorsIndexValue(newValue) {
    noOfFloorsListId =
        noOfFloorsIdList.elementAt(noOfFloorsList.indexOf(newValue!));
    notifyListeners();
  }

  // Country List Id
  getCountriesIndexValue(newValue) {
    countryListId = countriesIdList.elementAt(countriesList.indexOf(newValue!));
    notifyListeners();
  }

  // Date Picker
  // Date Variables
  String? setDate;
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2100));
    if (picked != null) {
      selectedDate = picked;
      dateController.text =
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
    }
    notifyListeners();
  }

  //Subscription Package Selected
  isPackageSelected() {
    isSubscriptionPackegeSelected = !isSubscriptionPackegeSelected;
    notifyListeners();
  }

  //Validation of Required Fields
  //Check Title Field
  bool isTitleEmpty() {
    if (titleOfAdController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //check Rent Include Utilities
  bool isRentIncludeUtilitiesShown() {
    if ((currentIndexForPage1List == 0 && categoryListId == 23) ||
        currentIndexForPage1List == 1 ||
        checkValues[priceOnRequest] == true) {
      return false;
    } else {
      return true;
    }
  }

  bool isRentIncludeUtilitiesEmpty() {
    if (rentIncludeUtilitiesController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Check rent Exclude Utilities
  bool isRentExcludeUtilitiesShown() {
    if (currentIndexForPage1List == 0 &&
            (categoryListId == 23 || categoryListId == 101) ||
        currentIndexForPage1List == 1 ||
        checkValues[priceOnRequest] == true) {
      return false;
    } else {
      return true;
    }
  }

  bool isRentExcludeUtilitiesEmpty() {
    if (rentExcludeUtilitiesController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Check Selling Price
  bool isSellingPriceShown() {
    if (categoryListId == 23) {
      if (currentIndexForPage1List == 0) {
        if (checkValues[priceOnRequest] == true) {
          return false;
        } else {
          return true;
        }
      }
    } else if (currentIndexForPage1List == 0) {
      return false;
    } else if (checkValues[priceOnRequest] == true) {
      return false;
    }
    return true;
  }

  bool isSellingPriceEmpaty() {
    if (sellingPriceController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isPostalCodeFieldeEmpaty() {
    if (postCodeandCityController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Check all required Fields
  bool isRequiredFieldsEmpty(context) {
    if (isTitleEmpty()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, pleaseFillTitleOfAd, 1));
      return true;
    }
    if (isRentIncludeUtilitiesShown() && isRentIncludeUtilitiesEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, pleaseFillRentIncludeUtilities, 1));
      return true;
    }
    if (isRentExcludeUtilitiesShown() && isRentExcludeUtilitiesEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, pleaseFillRentExcludeUtilities, 1));
      return true;
    }
    if (isSellingPriceShown() && isSellingPriceEmpaty()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, pleaseFillSellindPrice, 1));
      return true;
    }
    if (isPostalCodeFieldeEmpaty()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, pleaseFillPostCodeAndCity, 1));
      return true;
    }
    return false;
  }

  // Check Links Field null or have Invalid Value
  isYoutubeLinkValid(String value, context) {
    if (youTubeLinkValidation(value) == null) {
      return true;
    } else if (youTubeLinkValidation(value) == validWebLink) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, validYoutubeLink, 1));
      return false;
    }
  }

  isWebLinkValid(String value, context) {
    if (webLinkValidation(value) == null) {
      return true;
    } else if (webLinkValidation(value) == validWebLink) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, validWebLink, 1));
      return false;
    }
  }

  // Check Required value of Contat form valid
  // Contact Form Email Field
  isEmailShown() {
    if (currentIndexVerticalRadioListPage5 == 2) {
      return false;
    } else {
      return true;
    }
  }

  // Contact Form Telephone Field
  isTelephoneShown() {
    if (currentIndexVerticalRadioListPage5 == 1) {
      return false;
    } else {
      return true;
    }
  }

  //Check Contact form Requred Field empty
  bool isContactFormRequiredFieldsNotEmpty(context) {
    if (isEmailShown() && emailValidation(emailController.text) != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, pleaseFillEmail, 1));
      return false;
    }
    if (isTelephoneShown() &&
        telephoneValidation(telephoneController.text) != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, pleaseFilTelephone, 1));
      return false;
    }
    if (contactPersonValidation(contactPersonController.text) != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, pleaseFilContactPerson, 1));
      return false;
    }
    return true;
  }

  // Get Postal Code and city using google places Api

  tapOnPostalCodeTextField(String pattern) async {
    String request =
        '$placesBaseURL$pattern+in+$countrySelectedValue&types=geocode&key=$mapAPIKey';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      if (streetAndHouseNumberController.text.isNotEmpty) {
        streetAndHouseNumberController.clear();
      }
      if (citiesList.isNotEmpty) {
        citiesList.clear();
      }
      Map data = json.decode(response.body);
      List predictions = data['predictions']
          .map((prediction) => prediction['description'])
          .toList();

      for (var val in predictions) {
        if (val.toString().endsWith(countrySelectedValue!)) {
          // List splitedAddress = val.toString().split(' ');
          // if (splitedAddress.last.toString().endsWith(countrySelectedValue!)) {
          citiesList.add(val.toString());
          // }
        }
      }
      debugPrint('$citiesList');
    } else {
      throw Exception("Error Found ${response.statusCode}");
    }
    debugPrint("list=============================== $citiesList");
    return citiesList;
  }

  getPlacesAddress(String pattern) async {
    String request =
        '$placesTextSearchBaseURL$pattern+in+${getCityName()}&key=$mapAPIKey';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      if (placesList.isNotEmpty) {
        placesList.clear();
      }
      Map data = json.decode(response.body);
      List predictions = data['results']
          .map((prediction) => prediction['formatted_address'])
          .toList();
      for (var val in predictions) {
        if (val.toString().endsWith(countrySelectedValue!)) {
          placesList.add(val);
        }
      }
    } else {
      throw Exception("Error Found ${response.statusCode}");
    }
    debugPrint("list=============================== $placesList");
    return placesList;
  }

  // Get Selected City Name
  String getCityName() {
    return postCodeandCityController.text;
  }

  /* =============================
    Location Access through Map
  ================================ */
  // Selected City Latitude and Longitutde
  getCityLatLong(String pattern) async {
    try {
      String request = '$geocodingBaseURL$pattern&key=$mapAPIKey';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        if (placesList.isNotEmpty) {
          placesList.clear();
        }
        Map data = json.decode(response.body);
        List coordinatesList = data['results']
            .map((prediction) => prediction['geometry']['location'])
            .toList();
        for (Map<String, dynamic> latLang in coordinatesList) {
          debugPrint('Latlang===========================: $latLang');
          selectedCityLatitude = latLang.entries.first.value;
          selectedCityLongitude = latLang.entries.last.value;
          debugPrint(
              'Latitude: $selectedCityLatitude, Longitude: $selectedCityLongitude');
        }
      }
    } catch (e) {
      debugPrint('Error getting location from city name: $e');
    }
    notifyListeners();
  }

  //Check Location Access
  checkLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const AccessLocationPermission();
          });
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Camera Position
  getCurrentCameraPosition(context) async {
    await checkLocationPermission(context);
    if (streetAndHouseNumberController.text.isEmpty) {
      selectedStreetLatitude = selectedCityLatitude;
      selectedStreetLongitude = selectedCityLongitude;
    } else {
      try {
        List<Location> locations =
            await locationFromAddress(streetAndHouseNumberController.text);
        if (locations.isNotEmpty) {
          Location location = locations.first;
          selectedStreetLatitude = location.latitude;
          selectedStreetLongitude = location.longitude;
          debugPrint(
              'Latitude: $selectedStreetLatitude, Longitude: $selectedStreetLongitude');
        } else {
          debugPrint('No location found for the city name: $getCityName()');
        }
      } catch (e) {
        debugPrint('Error getting location from city name: $e');
      }
    }
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("Location"),
        position: LatLng(selectedStreetLatitude!, selectedStreetLongitude!),
        infoWindow: const InfoWindow(title: "Selected City"),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    notifyListeners();
  }

  //camera Postion
  currentLocationCameraPosition() {
    return CameraPosition(
      target: LatLng(selectedStreetLatitude!, selectedStreetLongitude!),
      zoom: streetAndHouseNumberController.text.isEmpty ? 11.0 : 18.0,
    );
  }

  // Map padding
  setPadding() {
    if (Platform.isAndroid) {
      height = setWidgetHeight(70);
    } else if (Platform.isIOS) {
      height = setWidgetHeight(80);
      width = setWidgetWidth(10);
    }

    notifyListeners();
  }

  EdgeInsets getPadding() {
    return Platform.isAndroid
        ? EdgeInsets.only(bottom: height)
        : Platform.isIOS
            ? EdgeInsets.only(bottom: setWidgetHeight(80), right: width)
            : EdgeInsets.zero;
  }

  setStreetLatlong(String pattern) async {
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
          selectedStreetLatitude = latLang.entries.first.value;
          selectedStreetLongitude = latLang.entries.last.value;
          debugPrint(
              'selectedStreetLatitude: $selectedStreetLatitude, selectedStreetLongitude: $selectedStreetLongitude');
        }
      }
    } catch (e) {
      debugPrint('Error getting location from city name: $e');
    }
    notifyListeners();
  }

  //Set Location
  setLocation(lat, long) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, long);
    if (placeMark.first.postalCode!.isNotEmpty) {
      address =
          "${placeMark.first.street}, ${placeMark.first.subLocality}, ${placeMark.first.locality}, ${placeMark.first.postalCode}, ${placeMark.first.country}";
    } else {
      address =
          "${placeMark.first.street}, ${placeMark.first.subLocality}, ${placeMark.first.locality}, ${placeMark.first.country}";
    }

    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("Location"),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: address),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    selectedStreetLatitude = lat;
    selectedStreetLongitude = long;
    notifyListeners();
  }

  clearMarker() {
    markers.clear();
    notifyListeners();
  }

  setLocationVariable() {
    if (address!.isNotEmpty) {
      streetAndHouseNumberController.text = address!;
    }
    notifyListeners();
  }

  //File Handling
  // =========================================================================
  // Image
  //Set Image
  setImage(File newImage) {
    image = newImage;
    debugPrint('$image');
    notifyListeners();
  }

  // PDF
  //Set PDF
  setPDFFile(File newPDF) {
    filePDF = newPDF;
    debugPrint('$newPDF');
    notifyListeners();
  }

  // Step 1 APIs Implementation ============================================
  //Loading
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Loading
  setSaveLoading(BuildContext context, bool value) {
    isSaveLoading = value;
    if (value == true) {
      loaderDialog(context);
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  setSubCategoryLoading(bool value) {
    isSubCategoryLoading = value;
    notifyListeners();
  }

  // GET Category
  getCategoryList(BuildContext context, String screen) async {
    setLoading(true);
    setSubCategoryLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Category  ==========================>>>");
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.getPropertyCategoriesUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      propertyCategoryModel = PropertyCategoryModel.fromJson(responseBody);
      if (propertyCategoryModel.error == false) {
        prpoertyCategoryList.clear();
        prpoertyCategoryIdList.clear();
        for (var element in propertyCategoryModel.data!) {
          prpoertyCategoryList.add(element.title);
          prpoertyCategoryIdList.add(element.id);
        }
      }
      debugPrint(
          "Elements===============================$prpoertyCategoryList");
      debugPrint("Id===============================$prpoertyCategoryIdList");

      await getSubCategoryList(context, screen);
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  // GET Sub Category
  getSubCategoryList(BuildContext context, String screen) async {
    setSubCategoryLoading(true);
    debugPrint("isLoading: $isSubCategoryLoading");
    debugPrint(" get Sub Category  ==========================>>>");
    if (categorySelectedValue == null) {
      getCategoryIndexValue(propertyCategoryModel.data!.first.title);
    }
    try {
      Response response = await apiRepo.getData(context, screen,
          "${ApiUrl.getPropertyCategoriesUrl}/$categoryListId", {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      propertySubCategoryModel =
          PropertySubCategoryModel.fromJson(responseBody);
      if (propertySubCategoryModel.error == false) {
        prpoertySubCategoryList.clear();
        prpoertySubCategoryIdList.clear();
        if (propertySubCategoryModel.data!.isEmpty) {
          prpoertySubCategoryList.add("Selected Value is Empty");
          prpoertySubCategoryIdList.add(2);
          prpoertySubCategoryList.add("Selected Value is Not Valid");
          prpoertySubCategoryIdList.add(3);
        } else {
          for (var element in propertySubCategoryModel.data!) {
            prpoertySubCategoryList.add(element.title);
            prpoertySubCategoryIdList.add(element.id);
          }
        }
        subCategoryListId = prpoertySubCategoryIdList.first;
      }

      debugPrint(
          "Elements===============================$prpoertySubCategoryList");
      debugPrint("Id===============================$prpoertySubCategoryIdList");
      setSubCategoryLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSubCategoryLoading(false);
      debugPrint("isLoading: $isLoading");
    }
    debugPrint(
        "Sub Category Id===============================   $subCategoryListId");
    debugPrint("Category Id===============================   $categoryListId");
    debugPrint(
        "Radio List value===============================   ${radioListPage1.elementAt(currentIndexForPage1List)}");
    notifyListeners();
  }

  // GET Number of Rooms
  getNoOfRoomsList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Category  ==========================>>>");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getNoOfRoomsUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      noOfRoomsModel = NoOfRoomsModel.fromJson(responseBody);
      if (noOfRoomsModel.error == false) {
        noOfRoomsList.clear();
        noOfRoomsIdList.clear();
        if (noOfRoomsModel.data != null) {
          for (var element in noOfRoomsModel.data!.entries) {
            noOfRoomsList.add(element.value);
            noOfRoomsIdList.add(element.key);
          }
        }
        noOfRoomListId = noOfRoomsIdList.first;
      }
      debugPrint("Elements===============================$noOfRoomsList");
      debugPrint("Elements===============================$noOfRoomsIdList");
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  // GET Number of Housing Units
  getNoOfHousingUnitsList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Category  ==========================>>>");
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.getNoOfHousingUnityUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      noOfHousingUnitsModel = NoOfHousingUnitsModel.fromJson(responseBody);
      if (noOfHousingUnitsModel.error == false) {
        noOfHousingUnitsList.clear();
        noOfHousingUnitsIdList.clear();
        if (noOfHousingUnitsModel.data != null) {
          for (var element in noOfHousingUnitsModel.data!.entries) {
            noOfHousingUnitsList.add(element.value);
            noOfHousingUnitsIdList.add(element.key);
          }
        }
        noOfHousingUnitsListId = noOfHousingUnitsIdList.first;
      }
      debugPrint(
          "Elements===============================$noOfHousingUnitsList");
      debugPrint(
          "Elements===============================$noOfHousingUnitsIdList");
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  // GET Number of Floors
  getNoOfFloorsList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Category  ==========================>>>");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getNoOfFloorsUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      noOfFloorsModel = NoOfFloorsModel.fromJson(responseBody);
      if (noOfFloorsModel.error == false) {
        noOfFloorsList.clear();
        noOfFloorsIdList.clear();
        if (noOfFloorsModel.data != null) {
          for (var element in noOfFloorsModel.data!.entries) {
            noOfFloorsList.add(element.value);
            noOfFloorsIdList.add(element.key);
          }
        }
        noOfFloorsListId = noOfFloorsIdList.first;
      }
      debugPrint("Elements===============================$noOfFloorsList");
      debugPrint("Elements===============================$noOfFloorsList");
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  // GET Countries
  getCountriesList(BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    debugPrint(" get Category  ==========================>>>");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getcountriesUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      countriesModel = CountriesModel.fromJson(responseBody);
      if (countriesModel.error == false) {
        countriesList.clear();
        countriesIdList.clear();
        if (countriesModel.data != null) {
          for (var element in countriesModel.data!) {
            countriesList.add(element.name!);
            countriesIdList.add(element.id!);
          }
        }
        countryListId = countriesIdList.first;
        countrySelectedValue = countriesList.first;
      }
      debugPrint(
          "countriesList===============================  $countriesList");
      debugPrint(
          "countriesIdList===============================  $countriesIdList");
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Post Step:1 Property
  saveProperty(BuildContext context, String screen) async {
    setSaveLoading(context, true);

    debugPrint("isLoading: $isSaveLoading");

    try {
      Response response =
          await apiRepo.postData(context, screen, ApiUrl.savePropertyStepUrl, {
        "id": isSecondScreenLoading == true ? propertyAdId : null,
        "property_category_id": categoryListId,
        "property_sub_category_id":
            categoryListId == 23 || categoryListId == 100
                ? null
                : subCategoryListId,
        "ownership_type": currentIndexForPage1List == 0 && categoryListId == 23
            ? 'for_sale'
            : currentIndexForPage1List == 0
                ? 'for_rent'
                : 'for_sale',
        "title": titleOfAdController.text,
        "number_of_rooms": categoryListId == 1 ||
                categoryListId == 12 ||
                categoryListId == 24 ||
                categoryListId == 28 ||
                categoryListId == 46 ||
                categoryListId == 84 ||
                categoryListId == 100
            ? double.tryParse(noOfRoomListId!)
            : null,
        "number_of_housing_units": categoryListId == 23
            ? double.tryParse(noOfHousingUnitsListId!)
            : null,
        "living_space":
            categoryListId == 1 || categoryListId == 12 || categoryListId == 23
                ? int.tryParse(livingSpaceController.text)
                : null,
        "plot_area": categoryListId == 12 ||
                categoryListId == 23 ||
                categoryListId == 24 ||
                categoryListId == 28 ||
                categoryListId == 46 ||
                categoryListId == 84 ||
                categoryListId == 100 ||
                categoryListId == 101
            ? int.tryParse(plotAreaController.text)
            : null,
        "floor_space": int.tryParse(floorSpaceController.text),
        "floor": categoryListId == 1 ||
                categoryListId == 24 ||
                categoryListId == 28 ||
                categoryListId == 46 ||
                categoryListId == 84 ||
                categoryListId == 88 ||
                categoryListId == 100
            ? noOfFloorsListId
            : null,
        "availability": currentIndexVerticalRadioListPage2 == 0
            ? 'for_date'
            : currentIndexVerticalRadioListPage2 == 1
                ? 'immediately'
                : 'on_request',
        'date': currentIndexVerticalRadioListPage2 == 0 ? selectedDate : null,
        "description": descriptionController.text,
        "currency": currentIndexHorizontalRadioListPage2 == 0
            ? 'chf'
            : currentIndexHorizontalRadioListPage2 == 1
                ? 'eur'
                : 'usd',
        "rent_including_utilities":
            currentIndexForPage1List == 0 && categoryListId == 23
                ? null
                : currentIndexForPage1List == 1
                    ? null
                    : checkValues[priceOnRequest] == true
                        ? null
                        : double.tryParse(rentIncludeUtilitiesController.text),
        "utilities": currentIndexForPage1List == 0 && categoryListId == 23
            ? null
            : currentIndexForPage1List == 0 && categoryListId == 101
                ? null
                : currentIndexForPage1List == 1
                    ? null
                    : checkValues[priceOnRequest] == true
                        ? null
                        : double.tryParse(utilitiesController.text),
        "rent_excluding_utilities": currentIndexForPage1List == 0 &&
                categoryListId == 23
            ? null
            : currentIndexForPage1List == 0 && categoryListId == 101
                ? null
                : currentIndexForPage1List == 1
                    ? null
                    : checkValues[priceOnRequest] == true
                        ? null
                        : double.tryParse(rentExcludeUtilitiesController.text),
        "selling_price":
            (currentIndexForPage1List == 0 && categoryListId != 23) ||
                    checkValues[priceOnRequest] == true
                ? null
                : double.tryParse(sellingPriceController.text),
        "gross_return": currentIndexForPage1List == 0 &&
                categoryListId == 23 &&
                checkValues[priceOnRequest] == false
            ? int.tryParse(grossReturnController.text)
            : null,
        "price_on_request": checkValues[priceOnRequest] == true ? 1 : 0,
        "indication_of_price": (((categoryListId == 28 ||
                            categoryListId == 46) &&
                        currentIndexForPage1List == 0) ||
                    (categoryListId == 101 && currentIndexForPage1List == 1)) &&
                currentIndexForIndicationPriceList == 0
            ? "total_area_monthly"
            : (((categoryListId == 28 || categoryListId == 46) &&
                            currentIndexForPage1List == 0) ||
                        (categoryListId == 101 &&
                            currentIndexForPage1List == 1)) &&
                    currentIndexForIndicationPriceList == 1
                ? "per_m2_anually"
                : null,
        "country_id": countryListId,
        "postcode_city": postCodeandCityController.text,
        "street_house_number": streetAndHouseNumberController.text,
        "lat": selectedCityLatitude,
        "lng": selectedCityLongitude,
        "street_house_number_lat":
            streetAndHouseNumberController.text.isNotEmpty
                ? selectedStreetLatitude
                : selectedCityLatitude,
        "street_house_number_lng":
            streetAndHouseNumberController.text.isNotEmpty
                ? selectedStreetLongitude
                : selectedCityLongitude,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      savePropertiesModel = SavePropertiesModel.fromJson(responseBody);
      if (savePropertiesModel.error == false) {
        propertyAdId = savePropertiesModel.data!.id;

        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, savePropertiesModel.message.toString(), 0));
      }

      setSaveLoading(context, false);

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("isLoading: ${e.toString()}");
      debugPrint("isLoading: $isSaveLoading");
    }

    notifyListeners();
  }

  //Post Step:2 Details
  saveDetails(BuildContext context, String screen) async {
    setSaveLoading(context, true);

    debugPrint("isLoading: $isSaveLoading");

    try {
      Response response = await apiRepo.postData(
          context, screen, '${ApiUrl.saveDetailsStepUrl}$propertyAdId', {
        "id": propertyAdId,
        "dimensions": {
          "room_height": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? double.tryParse(roomHeightController.text)
              : null,
          "hall_height": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? double.tryParse(hallHeightController.text)
              : null,
          "cubage": categoryListId == 88 || categoryListId == 101
              ? null
              : double.tryParse(cubageController.text),
          "number_of_floors": int.tryParse(numberOfFloorsController.text),
        },
        "interior": {
          "wheelchair_accessible": categoryListId == 88 || categoryListId == 101
              ? false
              : checkValues[wheelChairAccess],
          "pets_permitted": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[petPermission]
              : false,
          "view": categoryListId == 101 ? false : checkValues[view],
          "attic": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[attic]
              : false,
          "cellar": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[cellar]
              : false,
          "storage_room": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[storageRoom]
              : false,
          "fire_place": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[firePlace]
              : false,
          "toilets": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? checkValues[toilets]
              : false,
          "number_of_bathrooms": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? int.tryParse(numberofBathroomsController.text)
              : null,
        },
        "exterior": {
          "lift": categoryListId == 88 || categoryListId == 101
              ? false
              : checkValues[lift],
          "balcony_terrace_patio": categoryListId == 88 || categoryListId == 101
              ? false
              : checkValues[balcony],
          "child_friendly":
              categoryListId == 88 ? false : checkValues[childFriendly],
          "play_ground": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23 ||
                  categoryListId == 28
              ? checkValues[playGround]
              : false,
          "parking_space": categoryListId == 88 || categoryListId == 101
              ? false
              : checkValues[parkingSpace],
          "garage": categoryListId == 88 || categoryListId == 101
              ? false
              : checkValues[garage],
          "loading_ramp": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? checkValues[loadingRamp]
              : false,
        },
        "equipment": {
          "minergie_certificate_number": certificateNumberController.text,
          "energy_efficient_construction": checkValues[energy],
          "minergie_certified": checkValues[minergie],
          "sewage_connection":
              categoryListId == 101 ? checkValues[sewageConnection] : false,
          "electricity_supply":
              categoryListId == 101 ? checkValues[electricitySupply] : false,
          "gas_supply": categoryListId == 101 ? checkValues[gasSupply] : false,
          "steam_oven": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[steamOven]
              : false,
          "dishwasher": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[dishwasher]
              : false,
          "own_tumble_dryer":
              categoryListId == 1 ? checkValues[ownDryer] : false,
          "own_washing_machine":
              categoryListId == 1 ? checkValues[ownWashingMachine] : false,
          "cable_tv_connection": categoryListId == 88 || categoryListId == 101
              ? false
              : checkValues[cableTV],
          "water_supply": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? checkValues[waterSupply]
              : false,
          "lifting_capacity_of_the_crane": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? double.tryParse(liftingCapacityOfTheCraneController.text)
              : null,
          "loading_capacity_of_the_goods_lift": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? double.tryParse(loadingCapacityOfTheGoodsLiftController.text)
              : null,
          "floor_load_capacity": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? double.tryParse(floorLoadCapacityController.text)
              : null,
          "lifting_platform": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? checkValues[liftingPlatform]
              : false,
        },
        "surroundings": {
          "shops": categoryListId == 88 || categoryListId == 101
              ? null
              : double.tryParse(shopsController.text),
          "kindergarten": categoryListId == 88 || categoryListId == 101
              ? null
              : double.tryParse(kindergartenController.text),
          "primary_school": categoryListId == 88 || categoryListId == 101
              ? null
              : double.tryParse(primarySchoolController.text),
          "secondary_school": categoryListId == 88 || categoryListId == 101
              ? null
              : double.tryParse(secondarySchoolController.text),
          "railway_siding": categoryListId == 28 ||
                  categoryListId == 46 ||
                  categoryListId == 84
              ? checkValues[railwaySiding]
              : false,
          "public_transport": double.tryParse(publicTransportController.text),
          "motorway_connection": double.tryParse(motorwayController.text),
          "location": categoryListId == 100 || categoryListId == 101
              ? null
              : locationController.text,
        },
        "other_features": {
          "building": currentIndexOtherFeatureRadioList == 0
              ? "new_building"
              : "old_building",
          "house_or_flat_share":
              categoryListId == 1 ? checkValues[houseOrFlatShare] : false,
          "lease_hold": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23
              ? checkValues[leaseHold]
              : false,
          "swimming_pool": categoryListId == 1 ||
                  categoryListId == 12 ||
                  categoryListId == 23 ||
                  categoryListId == 46
              ? checkValues[swimmingPool]
              : false,
          "corner_house_or_end_of_terrace_house":
              categoryListId == 12 || categoryListId == 23
                  ? checkValues[corneHouse]
                  : false,
          "mid_terrace_house": categoryListId == 12 || categoryListId == 23
              ? checkValues[midTerraceHouse]
              : false,
          "covered": categoryListId == 88 ? checkValues[covered] : false,
          "garden_hut": categoryListId == 100 ? checkValues[gardenHut] : false,
          "developed": categoryListId == 101 ? checkValues[developed] : false,
        },
        "last_year_renovated": int.tryParse(renovatedYearController.text),
        "construction_year": int.tryParse(constructionYearController.text)
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      saveDetailsModel = SaveDetailsModel.fromJson(responseBody);

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(context,
          saveDetailsModel.message!, saveDetailsModel.error == false ? 0 : 1));

      setSaveLoading(context, false);

      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("isLoading: ${e.toString()}");
      debugPrint("isLoading: $isSaveLoading");
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

  //Save Image
  saveImage(BuildContext context, String screen) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");

    String? mimeType;
    String? fileName;
    String? mimee;
    String? type;

    if (image != null) {
      fileName = image!.path.substring(image!.path.lastIndexOf('/') + 1);
      mimeType = mime(image!.path);
      mimee = mimeType?.split('/')[0];
      type = mimeType?.split('/')[1];
      debugPrint("mimeType===================  $mimeType");
      debugPrint("mimee===================  $mimee");
      debugPrint("type===================  $type");
    }

    try {
      Response response = await apiRepo.postMultipartData(
          context, screen, "${ApiUrl.saveImageUrl}$propertyAdId", {
        "file": await MultipartFile.fromFile(image!.path,
            filename: image!.path.replaceFirst(RegExp(r'/'), ''),
            contentType: MediaType(mimee!, type!)),
        "name": fileName,
        "id": null,
        "is_main": imageModelList.isEmpty ? true : false,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      saveImageModel = SaveImageModel.fromJson(responseBody);
      if (saveImageModel.error == false) {
        imageModelList.add(saveImageModel.data!);
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          context,
          saveImageModel.message.toString(),
          saveImageModel.error == false ? 0 : 1));

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Update Image
  updateImage(BuildContext context, String screen, int id, int index) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");

    String? mimeType;
    String? fileName;
    String? mimee;
    String? type;

    if (image != null) {
      fileName = image!.path.substring(image!.path.lastIndexOf('/') + 1);
      mimeType = mime(image!.path);
      mimee = mimeType?.split('/')[0];
      type = mimeType?.split('/')[1];
      debugPrint("mimeType===================  $mimeType");
      debugPrint("mimee===================  $mimee");
      debugPrint("type===================  $type");
    }

    try {
      Response response = await apiRepo.postMultipartData(
          context, screen, "${ApiUrl.saveImageUrl}$propertyAdId", {
        "file": await MultipartFile.fromFile(image!.path,
            filename: image!.path.replaceFirst(RegExp(r'/'), ''),
            contentType: MediaType(mimee!, type!)),
        "name": fileName,
        "id": id,
        "is_main": imageModelList.length == 1 ? true : false,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      saveImageModel = SaveImageModel.fromJson(responseBody);
      if (saveImageModel.error == false) {
        imageModelList[index] = saveImageModel.data!;
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          context,
          saveImageModel.message.toString(),
          saveImageModel.error == false ? 0 : 1));

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Save PDF
  savePDF(BuildContext context, String screen) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");

    String? mimeType;
    String? fileName;
    String? mimee;
    String? type;

    if (filePDF != null) {
      fileName = filePDF!.path.substring(filePDF!.path.lastIndexOf('/') + 1);
      mimeType = mime(filePDF!.path);
      mimee = mimeType?.split('/')[0];
      type = mimeType?.split('/')[1];
      debugPrint("mimeType===================  $mimeType");
      debugPrint("mimee===================  $mimee");
      debugPrint("type===================  $type");
    }

    try {
      Response response = await apiRepo.postMultipartData(
          context, screen, "${ApiUrl.savePdfUrl}$propertyAdId", {
        "file": await MultipartFile.fromFile(filePDF!.path,
            filename: filePDF!.path.replaceFirst(RegExp(r'/'), ''),
            contentType: MediaType(mimee!, type!)),
        "name": fileName,
        "id": null,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      savePdfModel = SavePdfModel.fromJson(responseBody);
      if (savePdfModel.error == false) {
        pdfModelList.add(savePdfModel.data!);
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          context,
          savePdfModel.message.toString(),
          savePdfModel.error == false ? 0 : 1));

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Update PDF
  updatePDF(BuildContext context, String screen, int fileID) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");

    try {
      Response response = await apiRepo
          .postData(context, screen, "${ApiUrl.updatePdfUrl}$fileID", {
        "name": "${editPdfNameController.text}.pdf",
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      savePdfModel = SavePdfModel.fromJson(responseBody);
      if (savePdfModel.error == false) {
        for (var pdffile in pdfModelList) {
          if (pdffile.id == savePdfModel.data!.id) {
            int index = pdfModelList.indexOf(pdffile);
            pdfModelList[index] = savePdfModel.data!;
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          context,
          savePdfModel.message.toString(),
          savePdfModel.error == false ? 0 : 1));

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Delete File
  deleteFile(BuildContext context, String screen, String fileType, int id,
      int index) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");

    try {
      Response response = await apiRepo
          .getData(context, screen, "${ApiUrl.deleteFiledUrl}$id", {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      deleteFileModel = DeleteFileModel.fromJson(responseBody);
      if (deleteFileModel.error == false) {
        if (fileType.contains('image')) {
          imageModelList.removeAt(index);
        }
        if (fileType.contains('pdf')) {
          pdfModelList.removeAt(index);
        }

        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            context,
            deleteFileModel.message.toString(),
            deleteFileModel.error == false ? 0 : 1));
      }

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Save 3rd Step (Documents)
  saveDocuments(BuildContext context, String screen) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");
    try {
      Response response = await apiRepo
          .postData(context, screen, "${ApiUrl.saveDocUrl}$propertyAdId", {
        "youtube_videos[0]": youtubeLink1Controller.text,
        "youtube_videos[1]": youtubeLink2Controller.text,
        "virtual_tour_link": webLinkController.text,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      saveDocModel = SaveDocModel.fromJson(responseBody);

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          context,
          saveDocModel.message.toString(),
          saveDocModel.error == false ? 0 : 1));

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Save 4th Step (Contact Form)
  saveContactForm(BuildContext context, String screen) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");

    try {
      Response response = await apiRepo.postData(
          context, screen, "${ApiUrl.saveContactFormUrl}$propertyAdId", {
        "contact_form_type": currentIndexVerticalRadioListPage5 == 0
            ? 'contact_form_and_telephone_number'
            : currentIndexVerticalRadioListPage5 == 1
                ? 'contact_form'
                : 'telephone_number',
        "email": currentIndexVerticalRadioListPage5 == 2
            ? null
            : emailController.text,
        "telephone_number": currentIndexVerticalRadioListPage5 == 1
            ? null
            : "+41 ${telephoneController.text}",
        "contact_person": contactPersonController.text,
        "comment": commentController.text,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      saveContactFormModel = SaveContactFormModel.fromJson(responseBody);
      if (contactFormListPage7.isNotEmpty) {
        contactFormListPage7.clear();
        contactFormListPage7.add(verticalRadioListPage5
            .elementAt(currentIndexVerticalRadioListPage5));
      } else {
        contactFormListPage7.add(verticalRadioListPage5
            .elementAt(currentIndexVerticalRadioListPage5));
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          context,
          saveContactFormModel.message.toString(),
          saveContactFormModel.error == false ? 0 : 1));

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }

  //Publish Ad
  publishAd(BuildContext context, String screen) async {
    setSaveLoading(context, true);
    debugPrint("isLoading: $isLoading");

    try {
      Response response = await apiRepo
          .getData(context, screen, "${ApiUrl.publishAdUrl}$propertyAdId", {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      publishadModel = PublishadModel.fromJson(responseBody);

      setSaveLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setSaveLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }

    notifyListeners();
  }
}
