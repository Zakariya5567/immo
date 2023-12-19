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
import 'key_value_item.dart';

// ignore: must_be_immutable
class TechnicsData extends StatelessWidget {
  TechnicsData({super.key, 
    required this.controller,
    required this.language,
  });
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
        getHeading(translate(context, language.languageCode, equipment)!),
        marginHeight(15),
        data.detail == null
            ? Text(
                "_",
                style: textStyle(
                    fontSize: 14,
                    color: blackLight,
                    fontFamily: satoshiRegular),
              )
            : Column(
                children: [
                  getKeyValueItem(
                      translate(context, language.languageCode, certificateNO)!,
                      data.detail!.equipment!.minergieCertificateNumber == null
                          ? "_"
                          : data.detail!.equipment!.minergieCertificateNumber
                              .toString()),
                  getListFacilityItem(
                      translate(context, language.languageCode,
                          energy)!,
                      data.detail!.equipment!.energyEfficientConstruction!),
                  getListFacilityItem(
                      translate(context, language.languageCode,
                          minergie)!,
                      data.detail!.equipment!.minergieCertified!),
                  getListFacilityItem(
                      translate(context, language.languageCode, sewageConnection)!,
                      data.detail!.equipment!.sewageConnection!),
                  getListFacilityItem(
                      translate(context, language.languageCode, electricitySupply)!,
                      data.detail!.equipment!.electricitySupply!),
                  getListFacilityItem(
                      translate(context, language.languageCode, gasSupply)!,
                      data.detail!.equipment!.gasSupply!),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, steamOven)!,
                      data.detail!.equipment!.steamOven!),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, dishwasher)!,
                      data.detail!.equipment!.dishwasher!),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, ownDryer)!,
                      data.detail!.equipment!.ownTumbleDryer!),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, ownWashingMachine)!,
                      data.detail!.equipment!.ownWashingMachine!),
                  getListFacilityItem(
                      translate(context, language.languageCode,
                          cableTV)!,
                      data.detail!.equipment!.cableTvConnection!),
                  getListFacilityItem(
                      translate(context, language.languageCode,
                          waterSupply)!,
                      data.detail!.equipment!.waterSupply!),
                  getKeyValueItem(
                      translate(context, language.languageCode, liftingCapacityOfTheCrane)!,
                      data.detail!.equipment!.liftingCapacityOfTheCrane == null
                          ? "_"
                          : "${data.detail!.equipment!.liftingCapacityOfTheCrane.toString()} kg"),
                  getKeyValueItem(
                      translate(context, language.languageCode, loadingCapacityOfTheGoodsLift)!,
                      data.detail!.equipment!.loadingCapacityOfTheGoodsLift == null
                          ? "_"
                          : "${data.detail!.equipment!.loadingCapacityOfTheGoodsLift.toString()} kg"),
                  getKeyValueItem(
                      translate(context, language.languageCode, floorLoadCapacity)!,
                      data.detail!.equipment!.floorLoadCapacity == null
                          ? "_"
                          : "${data.detail!.equipment!.floorLoadCapacity.toString()} kg/m²"),
                  getListFacilityItem(
                      translate(context, language.languageCode,
                          liftingPlatform)!,
                      data.detail!.equipment!.liftingPlatform),
                  
                ],
              ),
      ],
    );
  }
}
