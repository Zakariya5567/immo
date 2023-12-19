// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/provider/search_map_provider.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/view/filter_screen/components/age_of_ad.dart';
import 'package:immo/view/filter_screen/components/availability_selection.dart';
import 'package:immo/view/filter_screen/components/characteristics_selection.dart';
import 'package:immo/view/filter_screen/components/city_section.dart';
import 'package:immo/view/filter_screen/components/create_alert.dart';
import 'package:immo/view/filter_screen/components/property_type.dart';
import 'package:immo/view/filter_screen/components/set_location.dart';
import 'package:immo/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import '../../utils/theme.dart';
import '../authentication_screen/components/custom_build_button.dart';
import '../widgets/divider_line.dart';
import 'components/area_range.dart';
import 'components/bedroom_selection.dart';
import 'components/filter_check_boxes.dart';
import 'components/floor_selection.dart';
import 'components/price_range.dart';
import 'components/rent_buy_toggle.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    callingApi();
  }

  callingApi() {
    Future.delayed(Duration.zero, () async {
      final filterProvider =
          Provider.of<FilterScreenProvider>(context, listen: false);
      filterProvider.resetFiler(context, 0);
      filterProvider.setFilterLoading(context, true);
      List<Future> apiFutures = [
        // Future.delayed(Duration.zero,(){
        filterProvider.getCharacteristicsList(
            context, RouterHelper.filterScreen),
        // });
        // Future.delayed(Duration.zero,(){
        filterProvider.getAgeOfAdList(context, RouterHelper.filterScreen),
        // });
        // Future.delayed(Duration.zero,(){
        filterProvider.getAdsWithList(context, RouterHelper.filterScreen),
        // });
        // Future.delayed(Duration.zero,(){
        filterProvider.getFilterFloorsList(context, RouterHelper.filterScreen),
        // });
      ];
      // Wait for all the API calls to complete
      await Future.wait(apiFutures);
      filterProvider.setFilterLoading(context, false);
      if (filterProvider.isEdit == 1) {
        filterProvider.editAlertData(context);
        filterProvider.getFilterData(context, 0, 1, RouterHelper.filterScreen);
      } else {
        filterProvider.getFilterData(context, 0, 1, RouterHelper.filterScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider =
        Provider.of<FilterScreenProvider>(context, listen: false);
    final searchMapProvide =
        Provider.of<SearchMapProvider>(context, listen: false);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: WillPopScope(
          onWillPop: () {
            searchMapProvide.setIsAleadyDrawn(0);
            filterProvider.clearAlertTextField();
            return Future.value(true);
          },
          child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                elevation: 0.0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    filterProvider.clearAlertTextField();
                    searchMapProvide.setIsAleadyDrawn(0);
                    Navigator.pop(context);
                  },
                  icon: const ImageIcon(
                    AssetImage(Images.arrowBackIcon),
                    size: 23,
                  ),
                ),
                title: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    return Text(
                      translate(context, language.languageCode, filters)!,
                      style: textStyle(
                          fontSize: 18,
                          color: whitePrimary,
                          fontFamily: satoshiMedium),
                    );
                  },
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      showCreateAlertDialog(context);
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: setWidgetWidth(10),
                        ),
                        child: Consumer<LanguageProvider>(
                          builder: (context, language, child) {
                            return Text(
                              translate(
                                  context, language.languageCode, saveAsAlert)!,
                              style: textStyle(
                                  fontSize: 12,
                                  color: whitePrimary,
                                  fontFamily: satoshiMedium),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  marginWidth(24),
                ],
              ),
              body: Consumer<LanguageProvider>(
                builder: (context, language, child) {
                  return Consumer<FilterScreenProvider>(
                    builder: (context, controller, child) {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const RentBuyToggle(),
                                  const DividerLine(),
                                  CitySection(
                                    scaffoldKey: scaffoldKey,
                                    controller: controller,
                                  ),
                                  const DividerLine(),
                                  const SetLocation(),
                                  const DividerLine(),
                                  PropertyTypeFilter(
                                    list:
                                        controller.propertyCategoryModel.data!,
                                    controller: controller,
                                  ),
                                  const DividerLine(),
                                  PriceRangeSlider(
                                    title: priceRange,
                                    controller: controller,
                                    scaffoldKey: scaffoldKey,
                                  ),
                                  const DividerLine(),
                                  AreaRangeSlider(
                                    title: areaRange,
                                    controller: controller,
                                    scaffoldKey: scaffoldKey,
                                  ),
                                  const DividerLine(),
                                  FloorSelection(
                                    list: controller.filterFloorList,
                                    controller: controller,
                                  ),
                                  const DividerLine(),
                                  Availability(
                                    controller: controller,
                                    scaffoldKey: scaffoldKey,
                                  ),
                                  const DividerLine(),
                                  CharacteristicsSelection(
                                    list: controller.characteristicsList,
                                    controller: controller,
                                  ),
                                  const DividerLine(),
                                  AgeOfAdSelection(
                                      list: controller.ageOfAdList,
                                      controller: controller),
                                  const DividerLine(),

                                  // Bedroom section
                                  const BedroomSelection(
                                    totalItems: 10,
                                    isBedroom: 1,
                                  ),

                                  const DividerLine(),

                                  const BedroomSelection(
                                    totalItems: 6,
                                    isBedroom: 0,
                                  ),

                                  const DividerLine(),

                                  //Ads with Check Boxes
                                  Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: FilterCheckBoxes(
                                      list: controller.adsWithList,
                                      controller: controller,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: setWidgetHeight(80),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: whitePrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: greyShadow,
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, -1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Future.delayed(Duration.zero, () {
                                        controller.resetFiler(context, 1);
                                      }).then((value) async {
                                        controller.getFilterData(context, 0, 1,
                                            RouterHelper.filterScreen);
                                      });
                                    },
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.refresh_rounded,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: setWidgetWidth(5),
                                          ),
                                          Text(
                                              translate(
                                                  context,
                                                  language.languageCode,
                                                  reset)!,
                                              style: textStyle(
                                                  fontSize: 16,
                                                  color: blackLight,
                                                  fontFamily: satoshiMedium)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CustomBuildButton(
                                    buttonName:
                                        "${controller.propertiesListModel.data == null ? 0 : controller.propertiesListModel.meta!.total} ${translate(context, language.languageCode, results)!}",
                                    buttonColor: bluePrimary,
                                    buttonTextColor: whitePrimary,
                                    onPressed: () {
                                      if (controller.propertiesListModel.data ==
                                              null ||
                                          controller.propertiesListModel.data!
                                              .isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(customSnackBar(
                                                context, resultEmpty, 1));
                                      } else {
                                        Navigator.of(context).pushNamed(
                                            RouterHelper.searchedListScreen);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              )),
        ),
      ),
    );
  }

  void showCreateAlertDialog(BuildContext context) {
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
            child: CreateAlert(
              formKey: formKey,
              scaffoldKey: scaffoldKey,
            ),
          ),
        );
      },
    );
  }
}
