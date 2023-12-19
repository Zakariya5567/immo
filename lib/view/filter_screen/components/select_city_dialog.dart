import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../../db/hive_boxes.dart';
import '../../../db/search_history.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class SelectCityDialog extends StatelessWidget {
  SelectCityDialog({super.key, required this.isHome, required this.scaffoldKey});
  int isHome;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Consumer2<HomePageProvider, FilterScreenProvider>(
            builder: (context, homeController, filterProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate(context, language.languageCode, selectCity)!,
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
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Text(
                    isHome == 1
                        ? "${translate(context, language.languageCode, current)!}: ${homeController.selectedCity ?? ""}"
                        : "${translate(context, language.languageCode, current)!}: ${filterProvider.selectedCity ?? ""}",
                    style: textStyle(
                        fontSize: 14,
                        color: bluePrimary,
                        fontFamily: satoshiMedium),
                  ),
                  SizedBox(
                    height: setWidgetHeight(25),
                  ),
                  //========================
                  TypeAheadField(
                    animationStart: 0,
                    animationDuration: Duration.zero,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: isHome == 1
                          ? homeController.searchCityController
                          : filterProvider.searchCityController,
                      textInputAction: TextInputAction.done,
                      obscureText: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        errorStyle: const TextStyle(fontSize: 12),
                        fillColor: greyShadow,
                        filled: true,
                        hintText: translate(
                            context, language.languageCode, searchHere)!,
                        hintStyle: textStyle(
                            fontSize: 14,
                            color: greyPrimary,
                            fontFamily: satoshiRegular),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.00,
                          horizontal: MediaQuery.of(context).size.width * 0.022,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: greyShadow),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: greyShadow),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: greyShadow),
                        ),
                      ),
                    ),
                    suggestionsBoxDecoration:
                        const SuggestionsBoxDecoration(color: whitePrimary),
                    suggestionsCallback: (pattern) async {
                      if (isHome == 1) {
                        if (homeController
                            .searchCityController.text.isNotEmpty) {
                          return await homeController.getCitiesList(pattern);
                        } else {
                          return [translate(
                            context, language.languageCode, enterCityName)!,];
                        }
                      } else if (isHome == 0) {
                        if (filterProvider
                            .searchCityController.text.isNotEmpty) {
                          return await filterProvider.getCitiesList(pattern);
                        } else {
                          return [translate(
                            context, language.languageCode, enterCityName)!,];
                        }
                      } else {
                        return [translate(
                            context, language.languageCode, enterCityName)!,];
                      }
                    },
                    itemBuilder: (context, cityName) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(cityName.toString()),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      if (isHome == 1) {
                        if (homeController.citiesModel.status == "OK") {
                          homeController.searchCityController.text =
                              suggestion.toString();
                          homeController
                              .getPlace(
                                  homeController.searchCityController.text)
                              .then((value) {
                            if (homeController.placesModel.status == "OK") {
                              Navigator.of(context).pop();
                              homeController.getPropertyList(
                                  context,0,1, RouterHelper.homeScreen);
                              homeController.setCity(suggestion.toString());
                              final history = SearchHistory(
                                  text: suggestion.toString(),
                                  date: DateTime.now(),
                                  latitude: homeController.latitude!,
                                  longitude: homeController.langitude!);

                              final box = Boxes.getSearchHistory();

                              if (box.length > 20) {
                                box
                                    .deleteAt(box.length - box.length)
                                    .then((value) => box.add(history));
                              } else {
                                if (history.text.isNotEmpty) {
                                  box.add(history);
                                }
                              }
                            }
                          });
                        }
                      } else if (isHome == 0) {
                        if (filterProvider.citiesModel.status == "OK") {
                          filterProvider.searchCityController.text =
                              suggestion.toString();
                          filterProvider
                              .getPlace(
                                  filterProvider.searchCityController.text)
                              .then((value) {
                            if (filterProvider.placesModel.status == "OK") {
                              Navigator.of(scaffoldKey.currentContext!).pop();
                              filterProvider.getFilterData(
                                  scaffoldKey.currentContext!,0,1,
                                  RouterHelper.homeScreen);
                              filterProvider.setCity(suggestion.toString());
                              final history = SearchHistory(
                                  text: suggestion.toString(),
                                  date: DateTime.now(),
                                  latitude: filterProvider.latitude!,
                                  longitude: filterProvider.langitude!);

                              final box = Boxes.getSearchHistory();

                              if (box.length > 20) {
                                box
                                    .deleteAt(box.length - box.length)
                                    .then((value) => box.add(history));
                              } else {
                                if (history.text.isNotEmpty) {
                                  box.add(history);
                                }
                              }
                            }
                          });
                        }
                      }
                    },
                  ),

                  SizedBox(
                    height: setWidgetHeight(20),
                  ),
                  Text(
                    translate(context, language.languageCode, allCities)!,
                    style: textStyle(
                        fontSize: 20,
                        color: blackLight,
                        fontFamily: satoshiMedium),
                  ),
                  SizedBox(
                    height: setWidgetHeight(15),
                  ),
                  ValueListenableBuilder<Box<SearchHistory>>(
                      valueListenable: Boxes.getSearchHistory().listenable(),
                      builder: (context, box, _) {
                        final search =
                            box.values.toList().cast<SearchHistory>();
                        return SizedBox(
                          height: setWidgetHeight(200),
                          child: ListView.builder(
                              itemCount: search.length,
                              itemBuilder: (context, position) {
                                final searchData = search[position];
                                return GestureDetector(
                                  onTap: () {
                                    if (isHome == 1) {
                                      homeController.setLatLng(
                                          searchData.latitude,
                                          searchData.longitude);
                                      homeController.searchCityController.text =
                                          searchData.text;
                                      homeController
                                          .getPlace(homeController
                                              .searchCityController.text)
                                          .then((value) {
                                        if (homeController.placesModel.status ==
                                            "OK") {
                                          Navigator.of(context).pop();
                                          homeController.getPropertyList(
                                              context,0,1, RouterHelper.homeScreen);
                                          homeController.setCity(
                                              searchData.text.toString());
                                        }
                                      });
                                    }
                                    if (isHome == 0) {
                                      filterProvider.setLatLng(
                                          searchData.latitude,
                                          searchData.longitude);
                                      filterProvider.searchCityController.text =
                                          searchData.text;
                                      filterProvider
                                          .getPlace(filterProvider
                                              .searchCityController.text)
                                          .then((value) {
                                        if (filterProvider.placesModel.status ==
                                            "OK") {
                                          Navigator.of(
                                                  scaffoldKey.currentContext!)
                                              .pop();
                                          filterProvider.getFilterData(
                                              scaffoldKey.currentContext!,0,1,
                                              RouterHelper.homeScreen);
                                          filterProvider.setCity(
                                              searchData.text.toString());
                                        }
                                      });
                                    }
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: setWidgetHeight(14)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: setWidgetWidth(330),
                                            child: Text(
                                              searchData.text,
                                              style: textStyle(
                                                  fontSize: 18,
                                                  color: blackLight,
                                                  fontFamily: satoshiMedium),
                                            ).onPress(() {
                                              if (isHome == 1) {
                                                homeController.setLatLng(
                                                    searchData.latitude,
                                                    searchData.longitude);
                                                homeController
                                                    .searchCityController
                                                    .text = searchData.text;
                                                homeController
                                                    .getPlace(homeController
                                                        .searchCityController
                                                        .text)
                                                    .then((value) {
                                                  if (homeController
                                                          .placesModel.status ==
                                                      "OK") {
                                                    Navigator.of(context).pop();
                                                    homeController
                                                        .getPropertyList(
                                                            context,0,1,
                                                            RouterHelper
                                                                .homeScreen);
                                                    homeController.setCity(
                                                        searchData.text
                                                            .toString());
                                                  }
                                                });
                                              }
                                              if (isHome == 0) {
                                                filterProvider.setLatLng(
                                                    searchData.latitude,
                                                    searchData.longitude);
                                                filterProvider
                                                    .searchCityController
                                                    .text = searchData.text;
                                                filterProvider
                                                    .getPlace(filterProvider
                                                        .searchCityController
                                                        .text)
                                                    .then((value) {
                                                  if (filterProvider
                                                          .placesModel.status ==
                                                      "OK") {
                                                    Navigator.of(scaffoldKey
                                                            .currentContext!)
                                                        .pop();
                                                    filterProvider.getFilterData(
                                                        scaffoldKey
                                                            .currentContext!,0,1,
                                                        RouterHelper
                                                            .homeScreen);
                                                    filterProvider.setCity(
                                                        searchData.text
                                                            .toString());
                                                  }
                                                });
                                              }
                                            }),
                                          ),
                                          Image.asset(
                                            Images.iconClose,
                                            width: setWidgetWidth(18),
                                            height: setWidgetHeight(18),
                                          ).onPress(
                                            () {
                                              final box =
                                                  Boxes.getSearchHistory();
                                              box.delete(searchData.key);
                                            },
                                          )
                                        ],
                                      )),
                                );
                              }),
                        );
                      })
                ],
              );
            },
          ),
        );
      },
    );
  }
}
