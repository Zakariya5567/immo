import 'package:flutter/material.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import 'facility_item.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class ExteriorData extends StatelessWidget {
  ExteriorData({super.key, required this.controller, required this.language});

  HomePageProvider controller;
  LanguageProvider language;

  @override
  Widget build(BuildContext context) {
    final data = controller.propertiesDetailModel.data!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        marginHeight(20),
        getHeading(translate(context, language.languageCode, exterior)!),
        marginHeight(15),
        data.detail == null
            ? Text(
                "_",
                style: textStyle(
                    fontSize: 14,
                    color: blackLight,
                    fontFamily: satoshiRegular),
              )
            : data.detail!.exterior == null
                ? Text(
                    "_",
                    style: textStyle(
                        fontSize: 14,
                        color: blackLight,
                        fontFamily: satoshiRegular),
                  )
                : data.detail!.exterior!.lift == false &&
                        data.detail!.exterior!.balconyTerracePatio == false &&
                        data.detail!.exterior!.childFriendly == false &&
                        data.detail!.exterior!.playGround == false &&
                        data.detail!.exterior!.parkingSpace == false &&
                        data.detail!.exterior!.garage == false &&
                        data.detail!.exterior!.loadingRamp == false
                    ? Text(
                        "_",
                        style: textStyle(
                            fontSize: 14,
                            color: blackLight,
                            fontFamily: satoshiRegular),
                      )
                    : Column(
                        children: [
                          getListFacilityItem(
                              translate(context, language.languageCode, lift)!,
                              data.detail!.exterior!.lift!),
                          getListFacilityItem(
                              translate(
                                  context, language.languageCode, balcony)!,
                              data.detail!.exterior!.balconyTerracePatio!),
                          getListFacilityItem(
                              translate(context, language.languageCode,
                                  childFriendly)!,
                              data.detail!.exterior!.childFriendly!),
                          getListFacilityItem(
                              translate(
                                  context, language.languageCode, playGround)!,
                              data.detail!.exterior!.playGround!),
                          getListFacilityItem(
                              translate(context, language.languageCode,
                                  parkingSpace)!,
                              data.detail!.exterior!.parkingSpace!),
                          getListFacilityItem(
                              translate(
                                  context, language.languageCode, garage)!,
                              data.detail!.exterior!.garage!),
                          getListFacilityItem(
                              translate(
                                  context, language.languageCode, loadingRamp)!,
                              data.detail!.exterior!.loadingRamp),
                        ],
                      ),
      ],
    );
  }
}
