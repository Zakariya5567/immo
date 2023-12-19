import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:provider/provider.dart';

import '../../../data/api_models/filter_model/filter_floor_list_model.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/Shimmer/property_type_shimmer.dart';

class FloorSelection extends StatelessWidget {
  const FloorSelection({Key? key, required this.list, required this.controller})
      : super(key: key);
  final List<FloorSelectedData> list;
  final FilterScreenProvider controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: setWidgetWidth(24), top: setWidgetHeight(24)),
              child: Row(
                children: [
                  Image.asset(
                    Images.iconFloor,
                    width: setWidgetWidth(24),
                    height: setWidgetHeight(24),
                  ),
                  SizedBox(
                    width: setWidgetWidth(15),
                  ),
                  Text(translate(context, language.languageCode, floor)!,
                      style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiMedium)),
                  SizedBox(
                    width: setWidgetWidth(10),
                  ),
                  Text(
                      translate(
                          context, language.languageCode, canSelectMultiple)!,
                      style: textStyle(
                          fontSize: 12,
                          color: blackLight,
                          fontFamily: satoshiMedium)),
                ],
              ),
            ),
            SizedBox(
              height: setWidgetHeight(17),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: setWidgetHeight(24)),
              child: SizedBox(
                height: setWidgetHeight(40),
                child: controller.isLoading == true
                    ? const PropertyTypeShimmer()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, position) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: setWidgetWidth(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: list[position].isSelected!
                                    ? blueShadow
                                    : greyShadow,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: list[position].isSelected!
                                      ? bluePrimary
                                      : greyShadow,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: setWidgetWidth(15),
                                  vertical: setWidgetHeight(5),
                                ),
                                child: Center(
                                  child: Text(
                                    list[position].value!,
                                    style: textStyle(
                                      fontSize: 12,
                                      color: list[position].isSelected!
                                          ? bluePrimary
                                          : greyLight,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ).onPress(() {
                              controller.setFilterFloorSelectedIndex(
                                  position, context);
                            }),
                          );
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
