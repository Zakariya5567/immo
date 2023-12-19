import 'package:flutter/material.dart';
import 'package:immo/view/ad_details/components/key_value_item.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class SurroundingDetail extends StatelessWidget {
  SurroundingDetail(
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
          Row(
            children: [
              getHeading(
                  translate(context, language.languageCode, surroundings)!),
            ],
          ),
          marginHeight(15),
          data.detail != null
              ? Column(
                  children: [
                    // Shops
                    getKeyValueItem(
                        translate(context, language.languageCode, shops)!,
                        data.detail!.surroundings!.shops == null
                            ? "_"
                            : "${translate(context, language.languageCode, approx)!} ${data.detail!.surroundings!.shops} ${translate(context, language.languageCode, meter)!}"),
                    // Kindergarten
                    getKeyValueItem(
                        translate(
                            context, language.languageCode, kindergarten)!,
                        data.detail!.surroundings!.kindergarten == null
                            ? "_"
                            : "${translate(context, language.languageCode, approx)!} ${data.detail!.surroundings!.kindergarten} ${translate(context, language.languageCode, meter)!}"),
                    // Primerary School
                    getKeyValueItem(
                        translate(
                            context, language.languageCode, primearySchool)!,
                        data.detail!.surroundings!.primarySchool == null
                            ? "_"
                            : "${translate(context, language.languageCode, approx)!}  ${data.detail!.surroundings!.primarySchool} ${translate(context, language.languageCode, meter)!}"),
                    // Secondary School
                    getKeyValueItem(
                        translate(
                            context, language.languageCode, secondarySchool)!,
                        data.detail!.surroundings!.secondarySchool == null
                            ? "_"
                            : "${translate(context, language.languageCode, approx)!}  ${data.detail!.surroundings!.secondarySchool} ${translate(context, language.languageCode, meter)!}"),
                    // Public Transport
                    getKeyValueItem(
                        translate(
                            context, language.languageCode, publicTransport)!,
                        data.detail!.surroundings!.publicTransport == null
                            ? "_"
                            : "${translate(context, language.languageCode, approx)!}  ${data.detail!.surroundings!.publicTransport} ${translate(context, language.languageCode, meter)!}"),
                    // Railway Siding
                    getKeyValueItem(
                        translate(
                            context, language.languageCode, railwaySiding)!,
                        data.detail!.surroundings!.railwaySiding == null
                            ? "_"
                            : data.detail!.surroundings!.railwaySiding == true
                                ? translate(
                                    context, language.languageCode, yes)!
                                : translate(
                                    context, language.languageCode, no)!),
                    // Motorway
                    getKeyValueItem(
                        translate(context, language.languageCode, motorway)!,
                        data.detail!.surroundings!.motorwayConnection == null
                            ? "_"
                            : "${translate(context, language.languageCode, approx)!}  ${data.detail!.surroundings!.motorwayConnection} ${translate(context, language.languageCode, meter)!}"),
                    // Location
                    getKeyValueItem(
                        translate(context, language.languageCode, location)!,
                        data.detail!.surroundings!.location == null ||
                                data.detail!.surroundings!.location == ""
                            ? "_"
                            : "${data.detail!.surroundings!.location}"),
                  ],
                )
              : const Text("_")
        ]);
  }
}
