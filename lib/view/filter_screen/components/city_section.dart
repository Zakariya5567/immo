import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/filter_screen_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import 'select_city_dialog.dart';

// ignore: must_be_immutable
class CitySection extends StatelessWidget {
  CitySection({super.key, required this.scaffoldKey, required this.controller});
  final GlobalKey<ScaffoldState> scaffoldKey;
  FilterScreenProvider controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    Images.iconLocationOrange,
                    width: setWidgetWidth(24),
                    height: setWidgetHeight(24),
                  ),
                  SizedBox(
                    width: setWidgetWidth(15),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(translate(context, language.languageCode, city)!,
                          style: textStyle(
                              fontSize: 16,
                              color: blackLight,
                              fontFamily: satoshiMedium)),
                      SizedBox(
                        width: setWidgetWidth(300),
                        child: Text(
                            controller.selectedCity == null
                                ? translate(context, language.languageCode, selectCity)!
                                : controller.selectedCity!,
                            style: textStyle(
                                fontSize: 14,
                                color: bluePrimary,
                                fontFamily: satoshiMedium)),
                      )
                    ],
                  )
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
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.vertical,
                          ),
                          child: SelectCityDialog(
                            isHome: 0,
                            scaffoldKey: scaffoldKey,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Image.asset(
                  Images.iconNextOrange,
                  width: setWidgetWidth(18.2),
                  height: setWidgetHeight(18.2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
