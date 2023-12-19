import 'package:flutter/material.dart';
import 'package:immo/view/ad_details/components/key_value_item.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class DetailPrice extends StatelessWidget {
  DetailPrice({super.key, required this.controller, required this.language});
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
        getHeading(translate(context, language.languageCode, price)!),
        marginHeight(15),
        data.ownershipType == 'for_rent'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    data.propertyCategory!.id == 28 ||
                            data.propertyCategory!.id == 46
                        ? getKeyValueItem(
                            translate(context, language.languageCode,
                                indicationOfPrice)!,
                            data.indicationOfPrice == null
                                ? "_"
                                : data.indicationOfPrice == 'total_area_monthly'
                                    ? translate(context, language.languageCode,
                                        totalAreaMonthly)!
                                    : translate(context, language.languageCode,
                                        perM2Annually)!,
                          )
                        : const SizedBox(),
                    getKeyValueItem(
                      translate(
                          context, language.languageCode, grossRentMonth)!,
                      data.rentIncludingUtilities == null
                          ? "_"
                          : "${data.currency!.toUpperCase()} ${data.rentIncludingUtilities.toString()}",
                    ),
                    getKeyValueItem(
                      translate(
                          context, language.languageCode, utilitiesMonth)!,
                      data.utilities == null
                          ? "_"
                          : "${data.currency!.toUpperCase()} ${data.utilities.toString()}",
                    ),
                    getKeyValueItem(
                      translate(context, language.languageCode, netRentMonth)!,
                      data.rentExcludingUtilities == null
                          ? "_"
                          : "${data.currency!.toUpperCase()} ${data.rentExcludingUtilities.toString()}",
                    ),
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data.propertyCategory!.id == 101
                      ? getKeyValueItem(
                          translate(context, language.languageCode,
                              indicationOfPrice)!,
                          data.indicationOfPrice == null
                              ? "_"
                              : data.indicationOfPrice == 'total_area_monthly'
                                  ? translate(context, language.languageCode,
                                      totalArea)!
                                  : translate(
                                      context, language.languageCode, perM2)!,
                        )
                      : const SizedBox(),
                  getKeyValueItem(
                    translate(context, language.languageCode, sellingPrice)!,
                    data.sellingPrice == null
                        ? "_"
                        : "${data.currency!.toUpperCase()} ${data.sellingPrice.toString()}",
                  ),
                  data.propertyCategory!.id == 23
                      ? getKeyValueItem(
                          translate(
                              context, language.languageCode, grossReturn)!,
                          data.grossReturn == null
                              ? "_"
                              : "${data.grossReturn.toString()} %",
                        )
                      : const SizedBox(),
                ],
              ),
      ],
    );
  }
}
