import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
// ignore: library_prefixes
import 'dart:math' as Math;

import '../data/api_models/properties/drawn_map.dart';
import '../data/api_models/properties/property_list_model.dart';
import '../data/api_repo.dart';
import '../utils/api_url.dart';
import '../view/filter_screen/components/ad_preview_on_map.dart';
import '../view/widgets/circular_progress.dart';
import '../view/widgets/location_access_permission.dart';

class SearchMapProvider extends ChangeNotifier {
  TextEditingController searchLocationController = TextEditingController();
  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  int? isAlreadyDrawn;
  BuildContext? context;
  String? screen;

  setContext(BuildContext newContext, String newScreen) {
    context = newContext;
    screen = newScreen;
    notifyListeners();
  }

  setIsAleadyDrawn(int value) {
    isAlreadyDrawn = value;
    notifyListeners();
  }

  bool? isLoading;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Variables
  double height = 0;
  double width = 0;
  double? latitude;
  double? longitude;
  final Set<Polygon> polygons = <Polygon>{};
  final Set<Polyline> polyLines = <Polyline>{};

  bool drawPolygonEnabled = false;
  final List<LatLng> userPolyLinesLatLngList = <LatLng>[];
  bool clearDrawing = false;
  int? _lastXCoordinate, _lastYCoordinate;

  clearTextField() {
    searchLocationController.clear();
    notifyListeners();
  }

  clearDrawPolygon() {
    googleMapController = Completer<GoogleMapController>();
    clearPolygons();
    zoom = 11;
    controller = null;
    drawPolygonEnabled = false;
    markers = [];
    drawnMapList = [];
    notifyListeners();
  }

  setGoogleCompleter() {
    googleMapController = Completer<GoogleMapController>();
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

  // Map
  getCurrentCameraPosition(context) async {
    Position position = await _getGeoLocationPosition(context);
    if (isAlreadyDrawn == 1) {
      latitude = userPolyLinesLatLngList[0].latitude;
      longitude = userPolyLinesLatLngList[0].longitude;
    } else {
      latitude = position.latitude;
      longitude = position.longitude;
    }
    notifyListeners();
  }

  currentLocationCameraPosition() {
    return CameraPosition(
      target: LatLng(latitude!, longitude!),
      zoom: 11.0,
    );
  }

  GoogleMapController? controller;
  initGoogleController(GoogleMapController firstController) {
    controller = firstController;
    notifyListeners();
  }

  double zoom = 11;
  onZoom() async {
    final getZoom = await controller!.getZoomLevel();
    if (zoom != getZoom) {
      zoom = getZoom;
    }
    if (zoom < 20) {
      zoom = zoom + 0.5;
      controller!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(latitude!, longitude!), // new camera position
          zoom,
        ),
      );
      if (!googleMapController.isCompleted) {
        googleMapController.complete(controller);
      }
    }
    notifyListeners();
  }

  offZoom() async {
    final getZoom = await controller!.getZoomLevel();
    if (zoom != getZoom) {
      zoom = getZoom;
    }
    if (zoom > 0) {
      zoom = zoom - 0.5;
      controller!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(latitude!, longitude!), // new camera position
          zoom,
        ),
      );
      if (!googleMapController.isCompleted) {
        googleMapController.complete(controller);
      }
    }
    notifyListeners();
  }

  //==============================================================================
  // Map Marker
  List<Marker> markers = [];

  // Select Area

  toggleDrawing() {
    polyLines.clear();
    polygons.clear();
    userPolyLinesLatLngList.clear();
    markers = [];
    drawPolygonEnabled = !drawPolygonEnabled;
    notifyListeners();
  }

  onPanUpdate(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (clearDrawing) {
      clearDrawing = false;
      clearPolygons();
    }

    if (drawPolygonEnabled) {
      double? x, y;
      if (Platform.isAndroid) {
        // It times in 3 without any meaning,
        // We think it's an issue with GoogleMaps package.
        x = details.globalPosition.dx *
            MediaQuery.of(context!).devicePixelRatio /
            1.2;
        // * 2.18;
        // * 1.5;
        y = details.globalPosition.dy *
            MediaQuery.of(context!).devicePixelRatio /
            1.2;
        //  * 2.18;
        // * 1.5;
      } else if (Platform.isIOS) {
        x = details.globalPosition.dx * 0.8;
        y = details.globalPosition.dy * 0.8;
      }

      // Round the x and y.
      int xCoordinate = x!.round();
      int yCoordinate = y!.round();

      // Check if the distance between last point is not too far.
      // to prevent two fingers drawing.
      if (_lastXCoordinate != null && _lastYCoordinate != null) {
        var distance = Math.sqrt(Math.pow(xCoordinate - _lastXCoordinate!, 2) +
            Math.pow(yCoordinate - _lastYCoordinate!, 2));
        // Check if the distance of point and point is large.
        if (distance > 80.0) return;
      }

      // Cached the coordinate.
      _lastXCoordinate = xCoordinate;
      _lastYCoordinate = yCoordinate;

      ScreenCoordinate screenCoordinate =
          ScreenCoordinate(x: xCoordinate, y: yCoordinate);

      final GoogleMapController controller = await googleMapController.future;
      LatLng latLng = await controller.getLatLng(screenCoordinate);
      try {
        // Add new point to list.
        userPolyLinesLatLngList.add(latLng);

        polyLines.removeWhere(
            (polyline) => polyline.polylineId.value == 'user_polyline');
        polyLines.add(
          Polyline(
            polylineId: const PolylineId('user_polyline'),
            points: userPolyLinesLatLngList,
            width: 3,
            color: bluePrimary,
          ),
        );
        debugPrint("Update : $userPolyLinesLatLngList");
      } catch (e) {
        debugPrint(" error painting $e");
      }
      notifyListeners();
    }
  }

  onPanEnd(dragEndDetails) async {
    // Reset last cached coordinate
    _lastXCoordinate = null;
    _lastYCoordinate = null;

    if (drawPolygonEnabled) {
      polygons
          .removeWhere((polygon) => polygon.polygonId.value == 'user_polygon');
      polygons.add(
        Polygon(
          polygonId: const PolygonId('user_polygon'),
          points: userPolyLinesLatLngList,
          strokeWidth: 3,
          strokeColor: bluePrimary,
          fillColor: Colors.transparent,
        ),
      );
      clearDrawing = true;
      debugPrint("END : $userPolyLinesLatLngList");
      getPropertiesByCoordinates();
      notifyListeners();
    }
  }

  clearPolygons() {
    polyLines.clear();
    polygons.clear();
    userPolyLinesLatLngList.clear();
    markers = [];
    notifyListeners();
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

  PropertiesListModel propertiesListModel = PropertiesListModel();
  ApiRepo apiRepo = ApiRepo();

  DrawnMapModel drawnMapModel = DrawnMapModel();
  List drawnMapList = [];

  getPropertiesByCoordinates() async {
    setFilterLoading(context, true);

    for (var element in userPolyLinesLatLngList) {
      drawnMapList.add(drawnMapModel.toJson(
          newLat: element.latitude, newLng: element.longitude));
    }

    debugPrint("isLoading: $isLoading");
    try {
      Response response = await apiRepo.postData(context!, screen!,
          ApiUrl.getCoordinatesUrl, {"coordinates": drawnMapList});
      final responseBody = response.data;
      debugPrint("Coordinates response body ===============>>> $responseBody");
      propertiesListModel = PropertiesListModel.fromJson(responseBody);

      if (propertiesListModel.error == false) {
        markers.clear();

        propertiesListModel.data!.asMap().forEach((index, element) {
          if (element.published == 1) {
            double? newLat = double.tryParse(element.lat);
            double? newLang = double.tryParse(element.lng);
            markers.add(
              Marker(
                markerId: MarkerId(element.id.toString()),
                position: LatLng(newLat!, newLang!),
                infoWindow: InfoWindow(
                  title: element.title,
                  onTap: () {
                    showModal(element);
                  },
                ),
              ),
            );
          }
        });
      }

      setFilterLoading(context, false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setFilterLoading(context, false);
      debugPrint("isLoading: $isLoading");
    }
  }

  void showModal(PropertiesData element) {
    // ignore: unused_local_variable
    Future<void> future = showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: whitePrimary,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: AdPreview(
              data: element,
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // LOADING DIALOG

  setFilterLoading(context, bool value) {
    isLoading = value;
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
