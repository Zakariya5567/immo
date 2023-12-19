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
class InteriorData extends StatelessWidget {
  InteriorData({super.key, required this.controller, required this.language});
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
        getHeading(translate(context, language.languageCode, interior)!),
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
                  getListFacilityItem(
                      translate(context, language.languageCode,
                          wheelChairAccess)!,
                      data.detail!.interior!.wheelchairAccessible!),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, petPermission)!,
                      data.detail!.interior!.petsPermitted!),
                  getListFacilityItem(
                      translate(context, language.languageCode, toilets)!,
                      data.detail!.interior!.toilets!),
                  getKeyValueItem(
                      translate(context, language.languageCode, noOfBathRooms)!,
                      data.detail!.interior!.numberOfBathrooms == null
                          ? "_"
                          : data.detail!.interior!.numberOfBathrooms
                              .toString()),
                  getListFacilityItem(
                      translate(context, language.languageCode, view)!,
                      data.detail!.interior!.view!),
                  getListFacilityItem(
                      translate(context, language.languageCode,attic)!,
                      data.detail!.interior!.attic!),
                  getListFacilityItem(
                      translate(context, language.languageCode, cellar)!,
                      data.detail!.interior!.cellar!),
                  getListFacilityItem(
                      translate(
                          context, language.languageCode, storageRoom)!,
                      data.detail!.interior!.storageRoom!),
                  getListFacilityItem(
                      translate(context, language.languageCode, firePlace)!,
                      data.detail!.interior!.firePlace!),
                ],
              ),
      ],
    );
  }
}
