import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';

class AreaRangeSlider extends StatelessWidget {
  const AreaRangeSlider({
    Key? key,
    required this.title,
    required this.controller,
    required this.scaffoldKey,
  }) : super(key: key);
  final String title;
  final FilterScreenProvider controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Images.iconAreaRange,
                        width: setWidgetWidth(24),
                        height: setWidgetHeight(24),
                      ),
                      SizedBox(
                        width: setWidgetWidth(15),
                      ),
                      Text(
                        translate(context, language.languageCode, title)!,
                        style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiMedium,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    translate(context, language.languageCode, meterSq)!,
                    style: textStyle(
                      fontSize: 14,
                      color: greyLight,
                      fontFamily: satoshiBold,
                    ),
                  ),
                ],
              ),
              marginHeight(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: setWidgetHeight(45),
                    width: setWidgetWidth(167),
                    decoration: const BoxDecoration(
                        color: greyShadow,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: setWidgetWidth(10),
                            top: setWidgetHeight(18),
                          ),
                          child: SizedBox(
                            width: setWidgetWidth(88),
                            child: TextFormField(
                              controller: controller.minAreaController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.done,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    controller.minimumArea.round().toString(),
                                border: InputBorder.none,
                              ),
                              onChanged: ((value) {
                                controller.setMinAreaRange(
                                    value, scaffoldKey.currentContext!);
                              }),
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: setWidgetWidth(10),
                            ),
                            child: Text(
                              translate(context, language.languageCode, min)!,
                              style: textStyle(
                                  fontSize: 12,
                                  color: greyLight,
                                  fontFamily: satoshiBold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: setWidgetHeight(45),
                    width: setWidgetWidth(167),
                    decoration: const BoxDecoration(
                        color: greyShadow,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: setWidgetWidth(10),
                            top: setWidgetHeight(18),
                          ),
                          child: SizedBox(
                            width: setWidgetWidth(88),
                            child: TextFormField(
                              controller: controller.maxAreaController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.done,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    controller.maximumArea.round().toString(),
                                border: InputBorder.none,
                              ),
                              onChanged: ((value) {
                                controller.setMaxAreaRange(
                                    value, scaffoldKey.currentContext!);
                              }),
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            translate(context, language.languageCode, max)!,
                            style: textStyle(
                                fontSize: 12,
                                color: greyLight,
                                fontFamily: satoshiBold),
                          ),
                        ),
                        marginWidth(10),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: setWidgetHeight(25),
                    horizontal: setWidgetWidth(10)),
                child: SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noThumb,
                    thumbColor: bluePrimary,
                    inactiveTrackColor: greyPrimary,
                    activeTrackColor: bluePrimary,
                    trackHeight: 3.0,
                    rangeThumbShape: const RoundRangeSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: RangeSlider(
                      min: controller.minimumArea,
                      max: controller.maximumArea,
                      values: controller.areaValues,
                      onChanged: (newValues) {
                        controller.setRangeValues(
                            rangeTitle: title,
                            rangeValues: newValues,
                            context: scaffoldKey.currentContext!);
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
