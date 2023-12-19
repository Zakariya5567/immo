import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/localization/app_localizations.dart';
import 'package:immo/provider/user_profile_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: // Back Button
              IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const ImageIcon(
              AssetImage(Images.arrowBackIcon),
              color: whitePrimary,
              size: 23,
            ),
          ),
          centerTitle: true,
          title: Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Text(
                translate(context, language.languageCode, setLocation)!,
                style: textStyle(
                  fontSize: 16,
                  color: whitePrimary,
                  fontFamily: satoshiBold,
                ),
              );
            },
          )),
      body: Consumer<UserProfileProvider>(
        builder: (context, profileProviderController, child) {
          return GoogleMap(
            padding: profileProviderController.getPadding(),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            initialCameraPosition:
                profileProviderController.currentLocationCameraPosition(),
            onMapCreated: (GoogleMapController controller) {
              if (!profileProviderController
                  .currentLocationController.isCompleted) {
                profileProviderController.currentLocationController
                    .complete(controller);
              }
              profileProviderController.setPadding();
            },
            myLocationEnabled: true,
            markers: profileProviderController.markers,
            onTap: ((latLang) {
              profileProviderController.setLocation(
                  latLang.latitude, latLang.longitude);
            }),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<UserProfileProvider>(
            builder: (context, controller, child) {
              return Container(
                margin: EdgeInsets.only(left: setWidgetWidth(30)),
                height: setWidgetHeight(50),
                width: setWidgetWidth(380),
                decoration: BoxDecoration(
                  color: bluePrimary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    return Center(
                      child: Text(
                        translate(context, language.languageCode, select)!,
                        style: textStyle(
                          fontSize: 16,
                          color: whitePrimary,
                          fontFamily: satoshiMedium,
                        ),
                      ),
                    );
                  },
                ),
              ).onPress(() {
                controller.setLocationVariable();
                Navigator.pop(context, RouterHelper.setProfile);
              });
            },
          ),
        ],
      ),
    );
  }
}
