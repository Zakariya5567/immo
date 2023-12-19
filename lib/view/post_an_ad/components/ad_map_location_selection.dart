import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:immo/provider/post_an_ad_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:provider/provider.dart';

import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';

class PostAdLocation extends StatelessWidget {
  const PostAdLocation({super.key});

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
      body: Consumer<PostAnAdProvider>(
        builder: (context, postAdProviderController, child) {
          return GoogleMap(
            padding: postAdProviderController.getPadding(),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition:
                postAdProviderController.currentLocationCameraPosition(),
            onMapCreated: (GoogleMapController controller) {
              if (!postAdProviderController
                  .currentLocationController.isCompleted) {
                postAdProviderController.currentLocationController
                    .complete(controller);
              }
              postAdProviderController.setPadding();
            },
            markers: postAdProviderController.markers,
            onTap: ((latLang) {
              postAdProviderController.setLocation(
                  latLang.latitude, latLang.longitude);
            }),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<PostAnAdProvider>(
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
                Navigator.pop(
                    context, RouterHelper.postAdMainDetailSecondScreen);
              });
            },
          ),
        ],
      ),
    );
  }
}
