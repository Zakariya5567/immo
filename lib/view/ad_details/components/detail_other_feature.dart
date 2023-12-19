import 'package:flutter/material.dart';
import 'package:immo/view/ad_details/components/key_value_item.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import 'facility_item.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class OtherFeatures extends StatelessWidget {
  OtherFeatures({super.key, required this.controller, required this.language});
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
        Row(
          children: [
            getHeading(
                translate(context, language.languageCode, otherFeatures)!),
          ],
        ),
        marginHeight(15),
        data.detail != null
            ? Column(
                children: [
                  getKeyValueItem(
                    translate(context, language.languageCode, newBuilding)!,
                    data.detail!.otherFeatures!.building == null
                        ? "_"
                        : data.detail!.otherFeatures!.building.toString() ==
                                'new_building'
                            ? translate(context, language.languageCode, yes)!
                            : translate(context, language.languageCode, no)!,
                  ),
                  getKeyValueItem(
                      translate(
                          context, language.languageCode, lastRenovation)!,
                      data.detail!.lastYearRenovated == null
                          ? "_"
                          : data.detail!.lastYearRenovated.toString()),
                  getKeyValueItem(
                      translate(
                          context, language.languageCode, constructionYear)!,
                      data.detail!.constructionYear == null
                          ? "_"
                          : data.detail!.constructionYear.toString()),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, houseOrFlatShare)!,
                      data.detail!.otherFeatures!.houseOrFlatShare),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, houseOrFlatShare)!,
                      data.detail!.otherFeatures!.houseOrFlatShare),
                  getListFacilityItem(
                      translate(context, language.languageCode, leaseHold)!,
                      data.detail!.otherFeatures!.leaseHold),
                  getListFacilityItem(
                      translate(context, language.languageCode, swimmingPool)!,
                      data.detail!.otherFeatures!.swimmingPool),
                  getListFacilityItem(
                      translate(context, language.languageCode, corneHouse)!,
                      data.detail!.otherFeatures!
                          .cornerHouseOrEndOfTerraceHouse),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, midTerraceHouse)!,
                      data.detail!.otherFeatures!.midTerraceHouse),
                  getListFacilityItem(
                      translate(context, language.languageCode, covered)!,
                      data.detail!.otherFeatures!.covered),
                  getListFacilityItem(
                      translate(context, language.languageCode, gardenHut)!,
                      data.detail!.otherFeatures!.gardenHut),
                  getListFacilityItem(
                      translate(context, language.languageCode, developed)!,
                      data.detail!.otherFeatures!.developed),
                ],
              )
            : const Text("_")
      ],
    );
  }
}
