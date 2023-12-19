import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:provider/provider.dart';

import '../../../helper/debouncer.dart';
import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../provider/search_map_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';

class SetLocation extends StatelessWidget {
  const SetLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final debouncer = DeBouncer(milliseconds: 300);
    return Consumer3<LanguageProvider, FilterScreenProvider, SearchMapProvider>(
      builder: (context, language, filterProvider, searchMapProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Images.iconSetLocation,
                        width: setWidgetWidth(24),
                        height: setWidgetHeight(24),
                      ),
                      SizedBox(
                        width: setWidgetWidth(15),
                      ),
                      Text(
                              translate(
                                  context,
                                  language.languageCode,
                                  searchMapProvider
                                          .userPolyLinesLatLngList.isEmpty
                                      ? setLocation
                                      : drawnAreas)!,
                              style: textStyle(
                                  fontSize: 16,
                                  color: blackLight,
                                  fontFamily: satoshiMedium))
                          .onPress(
                        () {
                          debouncer.run(() {
                            Future.delayed(Duration.zero, () async {
                              if (searchMapProvider
                                  .userPolyLinesLatLngList.isEmpty) {
                                searchMapProvider.setIsAleadyDrawn(0);
                              } else {
                                searchMapProvider.setIsAleadyDrawn(1);
                              }
                              await searchMapProvider
                                  .getCurrentCameraPosition(context)
                                  .then(
                                (value) {
                                  Navigator.of(context)
                                      .pushNamed(RouterHelper.mapSearchScreen);
                                },
                              );
                            });
                          });
                        },
                      ),
                      searchMapProvider.userPolyLinesLatLngList.isEmpty
                          ? const SizedBox()
                          : Row(
                              children: [
                                SizedBox(
                                  width: setWidgetWidth(15),
                                ),
                                Image.asset(
                                  Images.iconClose,
                                  width: setWidgetWidth(20),
                                  height: setWidgetHeight(20),
                                ).onPress(
                                  () {
                                    Future.delayed(Duration.zero, () {
                                      searchMapProvider.clearDrawPolygon();
                                    });
                                  },
                                )
                              ],
                            )
                    ],
                  ),
                  Container(
                    height: setWidgetHeight(50),
                    width: setWidgetWidth(99),
                    decoration: BoxDecoration(
                        color: blueShadow,
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.iconMap,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: setWidgetWidth(7),
                        ),
                        Text(
                          translate(context, language.languageCode, map)!,
                          style: textStyle(
                              fontSize: 16,
                              color: bluePrimary,
                              fontFamily: satoshiMedium),
                        ),
                      ],
                    ),
                  ).onPress(
                    () {
                      debouncer.run(() {
                        Future.delayed(Duration.zero, () async {
                          if (searchMapProvider
                              .userPolyLinesLatLngList.isEmpty) {
                            searchMapProvider.setIsAleadyDrawn(0);
                          } else {
                            searchMapProvider.setIsAleadyDrawn(1);
                          }
                          await searchMapProvider
                              .getCurrentCameraPosition(context)
                              .then(
                            (value) {
                              Navigator.of(context)
                                  .pushNamed(RouterHelper.mapSearchScreen);
                            },
                          );
                        });
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: setWidgetHeight(17),
              ),
            ],
          ),
        );
      },
    );
  }
}
