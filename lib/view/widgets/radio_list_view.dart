import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';

class FilterRadioSelectionView extends StatelessWidget {
  const FilterRadioSelectionView({
    super.key,
    required this.controller,
    required this.list,
    required this.isCurrency,
    required this.isFrom,
    required this.scaffoldKey,
  });
  final List<String> list;
  final FilterScreenProvider controller;
  final int isCurrency;
  final int isFrom;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Consumer<FilterScreenProvider>(
            builder: (_, controller, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate(context, language.languageCode,
                            isCurrency == 1 ? selectCurrency : selectDate)!,
                        style: textStyle(
                            fontSize: 22,
                            color: blackLight,
                            fontFamily: satoshiBold),
                      ),
                      Image.asset(
                        Images.iconClose,
                        width: setWidgetWidth(24),
                        height: setWidgetHeight(24),
                      ).onPress(
                        () {
                          Navigator.of(scaffoldKey.currentContext!).pop();
                        },
                      ),
                    ],
                  ),
                  Text(
                    "${translate(context, language.languageCode, current)!}: ${translate(context, language.languageCode, isCurrency == 1 ? controller.getCurrencyCurrentValueRadioList() : controller.getFromDateCurrentValueRadioList())!}",
                    style: textStyle(
                        fontSize: 14,
                        color: bluePrimary,
                        fontFamily: satoshiMedium),
                  ),
                  SizedBox(
                    height: setWidgetHeight(30),
                  ),
                  ListView.builder(
                    itemExtent: setWidgetHeight(40),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      String value = list[index];
                      return GestureDetector(
                        onTap: (() {
                          if (isCurrency == 1) {
                            Navigator.of(scaffoldKey.currentContext!).pop();
                            controller.setCurrencyCurrentIndexRadioList(
                                index, scaffoldKey.currentContext!);
                          } else if (isCurrency == 0 &&
                                  isFrom == 1 &&
                                  controller.toDateRadioListIndex! < index ||
                              isCurrency == 0 &&
                                  isFrom == 0 &&
                                  controller.fromDateRadioListIndex! < index) {
                            Navigator.of(scaffoldKey.currentContext!).pop();
                            if (isCurrency == 0 && isFrom == 1) {
                              controller.setFromDateCurrentIndexRadioList(
                                  index, scaffoldKey.currentContext!);
                            } else if (isCurrency == 0 && isFrom == 0) {
                              controller.setToDateCurrentIndexRadioList(
                                  index, scaffoldKey.currentContext!);
                            }
                          }
                        }),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<LanguageProvider>(
                              builder: (context, language, child) {
                                return Text(
                                  translate(
                                      context, language.languageCode, value)!,
                                  style: textStyle(
                                      fontSize: 20,
                                      color: isCurrency == 1 ||
                                              isCurrency == 0 &&
                                                  isFrom == 1 &&
                                                  controller
                                                          .toDateRadioListIndex! <
                                                      index ||
                                              isCurrency == 0 &&
                                                  isFrom == 0 &&
                                                  controller
                                                          .fromDateRadioListIndex! <
                                                      index
                                          ? blackLight
                                          : greyLight,
                                      fontFamily: satoshiRegular),
                                );
                              },
                            ),
                            Container(
                              width: setWidgetWidth(24),
                              height: setWidgetHeight(24),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: isCurrency == 1 &&
                                                controller
                                                        .currencyRadioListIndex ==
                                                    index ||
                                            isCurrency == 0 &&
                                                isFrom == 1 &&
                                                controller
                                                        .fromDateRadioListIndex ==
                                                    index ||
                                            isCurrency == 0 &&
                                                isFrom == 0 &&
                                                controller
                                                        .toDateRadioListIndex ==
                                                    index
                                        ? bluePrimary
                                        : greyLight,
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
