import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';

class BedroomSelection extends StatelessWidget {
  const BedroomSelection(
      {super.key, required this.totalItems, required this.isBedroom});
  final int totalItems;
  final int isBedroom;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    isBedroom == 1? Images.iconBedroomOrange : Images.iconBathroomOrange,
                    width: setWidgetWidth(24),
                    height: setWidgetHeight(24),
                  ),
                  SizedBox(
                    width: setWidgetWidth(15),
                  ),
                  Text(translate(context, language.languageCode, isBedroom == 1? bedrooms : bathrooms)!,
                      style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiMedium)),
                ],
              ),
              SizedBox(
                height: setWidgetHeight(17),
              ),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: setWidgetWidth(20),
                  crossAxisSpacing: setWidgetHeight(10),
                  mainAxisExtent: setWidgetHeight(50),
                ),
                itemCount: totalItems,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, position) =>
                    Consumer<FilterScreenProvider>(
                  builder: (context, controller, child) {
                    return Container(
                      height: setWidgetHeight(45),
                      decoration: BoxDecoration(
                          color: isBedroom == 1 &&
                                      controller.bedRoomIndex == position ||
                                  isBedroom == 0 &&
                                      controller.bathRoomIndex == position
                              ? blueLight
                              : greyShadow,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isBedroom == 1 &&
                                        controller.bedRoomIndex == position ||
                                    isBedroom == 0 &&
                                        controller.bathRoomIndex == position
                                ? bluePrimary
                                : greyShadow,
                          )),
                      child: Center(
                        child: Text(
                          position == (totalItems - 1)
                              ? "${position + 1}+"
                              : "${position + 1}",
                          style: textStyle(
                              fontSize: 14,
                              color: isBedroom == 1 &&
                                          controller.bedRoomIndex == position ||
                                      isBedroom == 0 &&
                                          controller.bathRoomIndex == position
                                  ? bluePrimary
                                  : greyLight,
                              fontFamily: satoshiMedium),
                        ),
                      ).onPress(() {
                        if (isBedroom == 1) {
                          controller.setBedRoomCurrentIndex(position, context);
                        } else {
                          controller.setBathRoomCurrentIndex(position, context);
                        }
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
