// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:immo/data/api_models/user_profile/currtent_user_model.dart';
import 'package:immo/data/api_models/user_profile/update_user_model.dart';
import 'package:immo/utils/app_constant.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/view/widgets/location_access_permission.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api_models/user_profile/delete_account_model.dart';
import '../data/api_repo.dart';
import '../utils/api_url.dart';
import '../utils/size.dart';
import '../view/widgets/circular_progress.dart';
import '../view/widgets/custom_snackbar.dart';

class UserProfileProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  //User Location Controller
  final Completer<GoogleMapController> currentLocationController =
      Completer<GoogleMapController>();
  //Variables
  bool? isLoading;
  ApiRepo apiRepo = ApiRepo();
  File? image;
  // String? selectedLocation;
  double height = 0;
  double width = 0;
  String? address;
  double? latitude;
  double? longitude;
  double? initiallatitude;
  double? initiallogitude;
  Set<Marker> markers = {};
  //Models
  CurrentUserModel currentUserModel = CurrentUserModel();
  UpdateUserModel updateUserModel = UpdateUserModel();
  DeleteAccountModel deleteAccountModel = DeleteAccountModel();

  clearTextField() {
    userNameController.clear();
    emailController.clear();
    addressController.clear();
    phoneNumberController.clear();
    websiteController.clear();
    locationController.clear();
    notifyListeners();
  }

  // Validation
  usernNameValidation(value) {
    if (value.isEmpty) {
      return hintUserName;
    }
  }

  phoneValidation(value) {
    String pattern = r'^\d{2}\s\d{3}\s\d{2}\s\d{2}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return;
    } else if (!regExp.hasMatch(value)) {
      return validPhoneNumber;
    }
  }

  bool validaPhoneNumber(value) {
    String pattern = r'^\d{2}\s\d{3}\s\d{2}\s\d{2}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return true;
    } else if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  //Clear Fields
  clearDataFields() {
    // Clear Text Fields
    userNameController.clear();
    emailController.clear();
    addressController.clear();
    phoneNumberController.clear();
    websiteController.clear();
    locationController.clear();
    // Clear Markers
    markers.clear();
    // Clear Image
    image = null;
    notifyListeners();
  }

  //Check Location Access
  Future<Position> _getGeoLocationPosition(context) async {
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
    latitude = lat;
    longitude = long;
    notifyListeners();
  }

  clearMarker() {
    markers.clear();
    notifyListeners();
  }

  setLocationVariable() {
    if (address == null) {
      setLocation(initiallatitude, initiallogitude);
      locationController.text = address!;
    }
    if (address!.isNotEmpty) {
      locationController.text = address!;
    }

    notifyListeners();
  }

  Future<void> getCurrentCameraPosition(context) async {
    try {
      setProfileLoading(context, true);
      Position position = await _getGeoLocationPosition(context);
      initiallatitude = position.latitude;
      initiallogitude = position.longitude;
      setProfileLoading(context, false);
    } catch (e) {
      setProfileLoading(context, false);
      debugPrint("error==========> $e");
    }
    notifyListeners();
  }

  currentLocationCameraPosition() {
    if (markers.isEmpty) {
      return CameraPosition(
        target: LatLng(initiallatitude!, initiallogitude!),
        zoom: 11.0,
      );
    } else {
      return CameraPosition(
        target: LatLng(latitude!, longitude!),
        zoom: 11.0,
      );
    }
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

  //Loading
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Loading
  setProfileLoading(BuildContext context, bool value) {
    isLoading = value;
    if (value == true) {
      loaderDialog(context);
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  //Set Profile Image
  setImage(File newImage) {
    image = newImage;
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

  //=================================================================================
  //Api

  // GET PROFILE
  getProfile(BuildContext context, String screen, int value) async {
    if (value == 0) {
      setLoading(true);
      debugPrint("isLoading: $isLoading");
    } else {
      setProfileLoading(context, true);
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.currentUserUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      currentUserModel = CurrentUserModel.fromJson(responseBody);
      if (currentUserModel.error == false) {
        if (currentUserModel.data!.username != null) {
          userNameController.text = currentUserModel.data!.username!;
        }
        if (currentUserModel.data!.email != null) {
          emailController.text = currentUserModel.data!.email!;
        }
        if (currentUserModel.data!.address != null) {
          addressController.text = currentUserModel.data!.address!;
        }
        if (currentUserModel.data!.phoneNumber != null) {
          phoneNumberController.text = _getFormattedValue(currentUserModel
              .data!.phoneNumber!
              .toString()
              .replaceFirst('+41', ''));
        }
        if (currentUserModel.data!.website != null) {
          websiteController.text = currentUserModel.data!.website!;
        }
        if (currentUserModel.data!.location != null) {
          locationController.text = currentUserModel.data!.location!;
        }
        if (currentUserModel.data!.isCompany != null) {
          sharedPreferences.setInt(
              AppConstant.isCompany, currentUserModel.data!.isCompany!);
          if (currentUserModel.data!.isCompany! == 1) {
            if (currentUserModel.data!.companyName != null) {
              userNameController.text = currentUserModel.data!.companyName!;
            }
          }
        }
      }
      if (value == 0) {
        setLoading(false);
        debugPrint("isLoading: $isLoading");
      } else {
        setProfileLoading(context, false);
      }
    } catch (e) {
      if (value == 0) {
        setLoading(false);
        debugPrint("isLoading: $isLoading");
      } else {
        setProfileLoading(context, false);
      }
    }

    notifyListeners();
  }

  //UPDATE PROFILE
  updateProfile(BuildContext context, String screen) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("${sharedPreferences.getInt(AppConstant.isCompany)}");

    setProfileLoading(context, true);
    debugPrint("isLoading: $isLoading");
    debugPrint("update profile ==========================>>>");

    String? mimeType;
    String? mimee;
    String? type;

    if (image != null) {
      mimeType = mime(image!.path);
      mimee = mimeType?.split('/')[0];
      type = mimeType?.split('/')[1];
      debugPrint("mimeType===================  $mimeType");
      debugPrint("mimee===================  $mimee");
      debugPrint("type===================  $type");
    }
    try {
      Response response = await apiRepo.postMultipartData(
          context,
          screen,
          ApiUrl.updateProfileUrl,
          sharedPreferences.getInt(AppConstant.isCompany) == 1
              ? {
                  'profile_picture': image == null
                      ? null
                      : await MultipartFile.fromFile(image!.path,
                          filename: image!.path.replaceFirst(RegExp(r'/'), ''),
                          contentType: MediaType(mimee!, type!)),
                  "company_name": userNameController.text,
                  "email": emailController.text,
                  "phone_number": phoneNumberController.text.isEmpty
                      ? ''
                      : "+41 ${phoneNumberController.text}",
                  "address": addressController.text,
                  "location": address,
                  "website": websiteController.text,
                  "longitude": longitude,
                  "latitude": latitude,
                  "is_company": 1,
                }
              : {
                  'profile_picture': image == null
                      ? null
                      : await MultipartFile.fromFile(image!.path,
                          filename: image!.path.replaceFirst(RegExp(r'/'), ''),
                          contentType: MediaType(mimee!, type!)),
                  "username": userNameController.text,
                  "email": emailController.text,
                  "phone_number": phoneNumberController.text.isEmpty
                      ? ''
                      : "+41 ${phoneNumberController.text}",
                  "address": addressController.text,
                  "location": address,
                  "website": websiteController.text,
                  "longitude": longitude,
                  "latitude": latitude,
                  "is_company": 0,
                });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      updateUserModel = UpdateUserModel.fromJson(responseBody);

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          context,
          updateUserModel.message.toString(),
          updateUserModel.error == false ? 0 : 1));

      setProfileLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setProfileLoading(context, false);
      debugPrint("Error: $e");
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  // Delete Account
  deleteAccount(BuildContext context, String screen) async {
    setProfileLoading(context, true);
    debugPrint("isLoading: $isLoading");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString(AppConstant.userId);
    debugPrint("${sharedPreferences.getInt(AppConstant.isCompany)}");

    try {
      Response response = await apiRepo.deleteData(
          context, screen, "${ApiUrl.deleteAccountUrl}/$userId", {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      deleteAccountModel = DeleteAccountModel.fromJson(responseBody);

      if (deleteAccountModel.error == false) {
        sharedPreferences.setBool(AppConstant.isLogin, false);
        sharedPreferences.setString(AppConstant.bearerToken, "");
        sharedPreferences.setString(AppConstant.userEmail, "");
        sharedPreferences.setString(AppConstant.userId, "");
        sharedPreferences.setString(AppConstant.userName, "");
        sharedPreferences.setInt(AppConstant.isCompany, 0);

        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, deleteAccountModel.message.toString(), 0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, deleteAccountModel.message.toString(), 1));
      }

      setProfileLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setProfileLoading(context, false);
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, deleteAccountModel.message.toString(), 1));
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
