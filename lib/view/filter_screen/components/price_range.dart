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
import '../../widgets/radio_list_view.dart';

class PriceRangeSlider extends StatelessWidget {
  const PriceRangeSlider(
      {super.key,
      required this.title,
      required this.controller,
      required this.scaffoldKey});
  final String title;
  final FilterScreenProvider controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (_, language, child) {
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
                        Images.iconPriceRange,
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
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: whitePrimary,
                        // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                        clipBehavior: Clip.antiAlias,
                        // set shape to make top corners rounded
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        context: scaffoldKey.currentContext!,
                        builder: (_) {
                          return SingleChildScrollView(
                              child: FilterRadioSelectionView(
                            list: controller.currencyRadioList,
                            isCurrency: 1,
                            controller: controller,
                            isFrom: 0,
                            scaffoldKey: scaffoldKey,
                          ));
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                            translate(context, language.languageCode,
                                controller.getCurrencyCurrentValueRadioList())!,
                            style: textStyle(
                                fontSize: 16,
                                color: blackLight,
                                fontFamily: satoshiMedium)),
                        SizedBox(
                          width: setWidgetWidth(11),
                        ),
                        Image.asset(
                          Images.iconArrowDown,
                          width: setWidgetWidth(11),
                          height: setWidgetHeight(7),
                        ),
                      ],
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
                    decoration: BoxDecoration(
                      color: greyShadow,
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                              controller: controller.minPriceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.done,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    controller.minimumPrice.round().toString(),
                                border: InputBorder.none,
                              ),
                              onChanged: ((value) {
                                controller.setMinPriceRange(value, context);
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
                    decoration: BoxDecoration(
                      color: greyShadow,
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                              controller: controller.maxPriceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.done,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    controller.maximumPrice.round().toString(),
                                border: InputBorder.none,
                              ),
                              onChanged: ((value) {
                                controller.setMaxPriceRange(value, context);
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
                      min: controller.minimumPrice,
                      max: controller.maximumPrice,
                      values: controller.priceValues,
                      onChanged: (newValues) {
                        controller.setRangeValues(
                            rangeTitle: title,
                            rangeValues: newValues,
                            context: context);
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
