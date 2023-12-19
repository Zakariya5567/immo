import 'package:flutter/material.dart';
import 'package:immo/view/ad_details/components/key_value_item.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class DetailDimension extends StatelessWidget {
  DetailDimension(
      {super.key, required this.controller, required this.language});
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
        getHeading(translate(context, language.languageCode, dimentions)!),
        marginHeight(15),
        data.detail != null
            ? Column(
                children: [
                  data.propertyCategory!.id == 28 ||
                          data.propertyCategory!.id == 46 ||
                          data.propertyCategory!.id == 84
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getKeyValueItem(
                                translate(context, language.languageCode,
                                    roomHeight)!,
                                data.detail!.dimensions!.roomHeight == null
                                    ? "_"
                                    : "${data.detail!.dimensions!.roomHeight.toString()} m"),
                            getKeyValueItem(
                                translate(context, language.languageCode,
                                    hallHeight)!,
                                data.detail!.dimensions!.hallHeight == null
                                    ? "_"
                                    : "${data.detail!.dimensions!.hallHeight.toString()} m"),
                          ],
                        )
                      : const SizedBox(),
                  getKeyValueItem(
                      translate(context, language.languageCode, cubage)!,
                      data.detail!.dimensions!.cubage == null
                          ? "_"
                          : "${data.detail!.dimensions!.cubage.toString()} m\u00B3"),
                  getKeyValueItem(
                      translate(context, language.languageCode, noOfFloors)!,
                      data.detail!.dimensions!.numberOfFloors == null
                          ? "_"
                          : data.detail!.dimensions!.numberOfFloors.toString()),
                  data.detail == null
                      ? Text(
                          "_",
                          style: textStyle(
                              fontSize: 14,
                              color: blackLight,
                              fontFamily: satoshiRegular),
                        )
                      : getKeyValueItem(
                          translate(
                              context, language.languageCode, noOfFloors)!,
                          data.detail!.dimensions!.numberOfFloors == null
                              ? "_"
                              : data.detail!.dimensions!.numberOfFloors
                                  .toString()),
                ],
              )
            : const Text("_")
      ],
    );
  }
}
