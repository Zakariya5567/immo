import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/search_map_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import '../../utils/theme.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  @override
  void initState() {
    callingAPI();
    super.initState();
  }

  callingAPI() {
    Future.delayed(Duration.zero, () async {
      final searchMapProvider =
          Provider.of<SearchMapProvider>(context, listen: false);
      if (searchMapProvider.isAlreadyDrawn == 0) {
        searchMapProvider.clearDrawPolygon();
      } else {
        searchMapProvider.setGoogleCompleter();
        searchMapProvider.getPropertiesByCoordinates();
      }
    });
  }

  void showModal() {
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
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const SingleChildScrollView(),
        );
      },
    );
  }

  TextEditingController searchController = TextEditingController();

  final heightPadding = setWidgetHeight(70);

  final widthPadding = setWidgetHeight(70);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const ImageIcon(
                AssetImage(Images.arrowBackIcon),
                size: 23,
              ),
            ),
            title: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Text(
                  translate(context, language.languageCode, searchLocation)!,
                  style: textStyle(
                      fontSize: 18,
                      color: whitePrimary,
                      fontFamily: satoshiMedium),
                );
              },
            ),
          ),
          body: SafeArea(
            top: Platform.isAndroid ? true : false,
            bottom: Platform.isAndroid ? true : false,
            child: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Consumer<SearchMapProvider>(
                  builder: (context, searchMapProvider, child) {
                    Future.delayed(Duration.zero, () {
                      searchMapProvider.setContext(
                          context, RouterHelper.mapSearchScreen);
                    });
                    return Stack(
                      children: [
                        GestureDetector(
                          onPanUpdate: (searchMapProvider.drawPolygonEnabled)
                              ? searchMapProvider.onPanUpdate
                              : null,
                          onPanEnd: (searchMapProvider.drawPolygonEnabled)
                              ? searchMapProvider.onPanEnd
                              : null,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            polygons: searchMapProvider
                                    .userPolyLinesLatLngList.isEmpty
                                ? <Polygon>{}
                                : searchMapProvider.polygons,
                            polylines: searchMapProvider
                                    .userPolyLinesLatLngList.isEmpty
                                ? <Polyline>{}
                                : searchMapProvider.polyLines,
                            initialCameraPosition: searchMapProvider
                                .currentLocationCameraPosition(),
                            onMapCreated: (GoogleMapController controller) {
                              if (!searchMapProvider
                                  .googleMapController.isCompleted) {
                                searchMapProvider.googleMapController
                                    .complete(controller);
                              }
                              searchMapProvider
                                  .initGoogleController(controller);
                              searchMapProvider.setPadding();
                            },
                            padding: searchMapProvider.getPadding(),
                            myLocationEnabled: true,
                            markers: Set.from(searchMapProvider.markers),
                            minMaxZoomPreference:
                                const MinMaxZoomPreference(0, 20),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(
                            top: setWidgetHeight(10),
                            left: setWidgetWidth(10),
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Container(
                                height: setWidgetHeight(45),
                                width: setWidgetHeight(45),
                                decoration: BoxDecoration(
                                  color: whitePrimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ImageIcon(
                                    const AssetImage(Images.plus),
                                    size: 12,
                                    color:
                                        const Color.fromARGB(255, 96, 100, 106)
                                            .withOpacity(0.7),
                                  ),
                                ),
                              ).onPress(() {
                                searchMapProvider.onZoom();
                              }),
                              Container(
                                height: setWidgetHeight(5),
                                color: Colors.transparent,
                              ),
                              Container(
                                height: setWidgetHeight(45),
                                width: setWidgetHeight(45),
                                decoration: BoxDecoration(
                                  color: whitePrimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ImageIcon(
                                    const AssetImage(Images.minus),
                                    size: 12,
                                    color:
                                        const Color.fromARGB(255, 96, 100, 106)
                                            .withOpacity(0.7),
                                  ),
                                ),
                              ).onPress(() {
                                searchMapProvider.offZoom();
                              }),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin:
                                EdgeInsets.only(bottom: setWidgetHeight(30)),
                            height: setWidgetHeight(40),
                            width: setWidgetWidth(115),
                            decoration: BoxDecoration(
                                color: whitePrimary,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: Text(
                              !searchMapProvider.drawPolygonEnabled
                                  ? translate(
                                      context, language.languageCode, draw)!
                                  : translate(
                                      context, language.languageCode, reset)!,
                              style: textStyle(
                                  fontSize: 14,
                                  color: blackLight,
                                  fontFamily: satoshiMedium),
                            )),
                          ).onPress(
                            () {
                              Future.delayed(Duration.zero, () {
                                searchMapProvider.toggleDrawing();
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
