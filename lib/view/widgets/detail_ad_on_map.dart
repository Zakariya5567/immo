import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:immo/data/api_models/location.dart';
import 'package:immo/provider/detail_on_map_provider.dart';
import 'package:immo/provider/language_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../utils/images.dart';
import 'circular_progress.dart';

class ShowDetailAdOnMap extends StatelessWidget {
  const ShowDetailAdOnMap({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as LocationPoints;
    return Consumer<DetailAdOnMapProvider>(
      builder: (context, detailOnMapController, child) {
        return Consumer<LanguageProvider>(
          builder: (context, language, child) {
            return WillPopScope(
              onWillPop: () {
                detailOnMapController.clearScreen();
                return Future.value(true);
              },
              child: SafeArea(
                top: Platform.isAndroid ? true : false,
                bottom: Platform.isAndroid ? true : false,
                child: Scaffold(
                  appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        translate(context, language.languageCode, map)!,
                        textAlign: TextAlign.center,
                        style: textStyle(
                          fontSize: 20,
                          color: whitePrimary,
                          fontFamily: satoshiBold,
                        ),
                      ),
                      backgroundColor: bluePrimary,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const ImageIcon(
                          AssetImage(Images.arrowBackIcon),
                          color: whitePrimary,
                          size: 23,
                        ),
                      )),
                  body: detailOnMapController.isLoading == false
                      ? GoogleMap(
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: detailOnMapController
                              .currentLocationCameraPosition(
                                  LatLng(args.lat, args.long), args.address),
                          padding: detailOnMapController.getPadding(),
                          myLocationEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            if (!detailOnMapController
                                .locationController.isCompleted) {
                              detailOnMapController.locationController
                                  .complete(controller);
                            }
                            detailOnMapController.setPadding();
                          },
                          markers: Set.from(detailOnMapController.markers),
                        )
                      : Container(
                          color: whitePrimary,
                          child: const CircularProgress(),
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
