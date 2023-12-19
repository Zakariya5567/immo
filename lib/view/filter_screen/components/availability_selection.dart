import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/view/widgets/from_to_container.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/radio_list_view.dart';

class Availability extends StatelessWidget {
  const Availability(
      {super.key, required this.controller, required this.scaffoldKey});
  final FilterScreenProvider controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

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
                    Images.iconAvailability,
                    width: setWidgetWidth(24),
                    height: setWidgetHeight(24),
                  ),
                  SizedBox(
                    width: setWidgetWidth(15),
                  ),
                  Text(translate(context, language.languageCode, availability)!,
                      style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiMedium)),
                ],
              ),
              SizedBox(
                height: setWidgetHeight(17),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Future.delayed(Duration.zero, () {
                          controller.setFromDateCurrentIndexRadioList(
                              0, scaffoldKey.currentContext!);
                          controller.getFromDateMonthYearFromCurrent();
                        });

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
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: FilterRadioSelectionView(
                                list: controller.fromDateRadioList,
                                isCurrency: 0,
                                controller: controller,
                                isFrom: 1,
                                scaffoldKey: scaffoldKey,
                              ),
                            );
                          },
                        );
                      },
                      child: FromToWidget(
                        title: controller.fromDateRadioList.length == 1
                            ? from
                            : controller.getFromDateCurrentValueRadioList(),
                      )),
                  InkWell(
                      onTap: () {
                        Future.delayed(Duration.zero, () {
                          controller.setToDateCurrentIndexRadioList(
                              0, scaffoldKey.currentContext!);
                          controller.getToDateMonthYearFromCurrent();
                        });

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
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: 
                              FilterRadioSelectionView(
                                list: controller.toDateRadioList,
                                isCurrency: 0,
                                controller: controller,
                                isFrom: 0,
                                scaffoldKey: scaffoldKey,
                              ),
                            );
                          },
                        );
                      },
                      child: FromToWidget(
                        title: controller.toDateRadioList.length == 1
                            ? to
                            : controller.getToDateCurrentValueRadioList(),
                      ))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
