import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/constants.dart';
import '../utils/size.dart';
import '../view/widgets/location_access_permission.dart';

class DetailAdOnMapProvider extends ChangeNotifier {
  // Variables
  double height = 0;
  double width = 0;
  bool? isLoading;
  double? latitude;
  double? longitude;
  // Location Controller
  Completer<GoogleMapController> locationController =
      Completer<GoogleMapController>();

  clearScreen() {
    markers = [];
    latitude = null;
    longitude = null;
    locationController = Completer<GoogleMapController>();
    notifyListeners();
  }

  // Map Marker
  List<Marker> markers = [];

  // Map padding
  setPadding() {
    if (Platform.isAndroid) {
      height = setWidgetHeight(0);
    } else if (Platform.isIOS) {
      height = setWidgetHeight(70);
    }
    width = setWidgetWidth(10);
    notifyListeners();
  }

  EdgeInsets getPadding() {
    return Platform.isAndroid
        ? EdgeInsets.only(top: height, right: width)
        : Platform.isIOS
            ? EdgeInsets.only(bottom: height, right: width)
            : EdgeInsets.zero;
  }

  //Check Location Access
  Future<Position> getGeoLocationPosition(context) async {
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

  // get Location from address
  Future<void> getlocation(BuildContext context, String address) async {
      // List<Location> locations = await locationFromAddress(address);
      // latitude = locations[0].latitude;
      // longitude = locations[0].longitude;
      // setLoading(false);
      try {
      String request = '$geocodingBaseURL$address&key=$mapAPIKey';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        List coordinatesList = data['results']
            .map((prediction) => prediction['geometry']['location'])
            .toList();
        for (Map<String, dynamic> latLang in coordinatesList) {
          debugPrint('Latlang===========================: $latLang');
          latitude = latLang.entries.first.value;
          longitude = latLang.entries.last.value;
          debugPrint(
              'Latitude: $latitude, Longitude: $longitude');
        }
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      debugPrint('Error getting location from city name: $e');
    }
    notifyListeners();
      
  }

  // Set Marker and Camera position
  currentLocationCameraPosition(LatLng latLng, String address) {
    markers.clear();
    if (latLng.latitude == 0 || latLng.longitude == 0) {
      if (latitude != null) {
        markers.add(Marker(
          markerId: MarkerId(address),
          infoWindow: InfoWindow(title: address),
          position: LatLng(latitude!, longitude!),
        ));
      }
    } else {
      markers.add(Marker(
        markerId: MarkerId(address),
        infoWindow: InfoWindow(title: address),
        position: latLng,
      ));
    }
    return CameraPosition(
      target: latLng.latitude == 0 || latLng.longitude == 0
          ? LatLng(latitude!, longitude!)
          : latLng,
      zoom: 14.0,
    );
  }

  //Loading
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
