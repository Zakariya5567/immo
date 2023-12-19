// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:provider/provider.dart';

import '../../../data/api_models/location.dart';
import '../../../helper/debouncer.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/detail_on_map_provider.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/button_with_icon.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class DetailAddress extends StatelessWidget {
  DetailAddress({
    super.key,
    required this.controller,
    required this.language,
  });
  HomePageProvider controller;
  LanguageProvider language;

  @override
  Widget build(BuildContext context) {
    final data = controller.propertiesDetailModel.data!;
    final debouncer = DeBouncer(milliseconds: 300);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        marginHeight(20),
        getHeading(translate(context, language.languageCode, address)!),
        marginHeight(20),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                width: setWidgetWidth(25),
                height: setWidgetHeight(25),
                image: const AssetImage(Images.iconLocationColored)),
            marginWidth(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.postcodeCity == null ? "_" : data.postcodeCity!,
                    style: textStyle(
                        fontSize: 14,
                        color: greyLight,
                        fontFamily: satoshiRegular),
                  ),
                  Text(
                    translate(context, language.languageCode, fullAddressMsg)!,
                    style: textStyle(
                        fontSize: 14,
                        color: greyLight,
                        fontFamily: satoshiRegular),
                  ),
                  marginHeight(10),
                  FittedBox(
                      child: ButtonWithIcon(
                          translate(context, language.languageCode, showOnMap)!,
                          Images.iconMapWhite,
                          iconSize: 20, () {
                    debouncer.run(() {
                      Future.delayed(Duration.zero, () async {
                        final detailMapProvider =
                            Provider.of<DetailAdOnMapProvider>(context,
                                listen: false);
                        Position position = await detailMapProvider
                            .getGeoLocationPosition(context);
                        detailMapProvider.setLoading(true);
                        await detailMapProvider
                            .getlocation(context, data.postcodeCity!)
                            .then((value) {
                          if (position.isMocked == false) {
                            Navigator.pushNamed(
                              context,
                              RouterHelper.detailAdOnMapScreen,
                              arguments: LocationPoints(
                                double.tryParse(data.streetHouseNumberLat
                                            .toString())! ==
                                        0
                                    ? double.tryParse(data.lat.toString())!
                                    : double.tryParse(
                                        data.streetHouseNumberLat.toString())!,
                                double.tryParse(data.streetHouseNumberLng
                                            .toString())! ==
                                        0
                                    ? double.tryParse(data.lng.toString())!
                                    : double.tryParse(
                                        data.streetHouseNumberLng.toString())!,
                                data.postcodeCity!,
                              ),
                            );
                          }
                        });
                      });
                    });
                  }))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
