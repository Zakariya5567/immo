// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/data/api_models/properties/property_list_model.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/post_an_ad/components/ad_steps_details.dart';
import 'package:immo/view/post_an_ad/components/ads_app_bar.dart';
import 'package:immo/view/widgets/ads_bottom_buttons.dart';
import 'package:immo/view/post_an_ad/components/ads_screen_information_title.dart';
import 'package:immo/view/post_an_ad/components/ads_border_view.dart';
import 'package:immo/view/widgets/radio_list_horizontal.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';
import '../widgets/Shimmer/post_an_ad/property_dropdown_list.dart';

class MainInformationFirstScreen extends StatefulWidget {
  const MainInformationFirstScreen({super.key});

  @override
  State<MainInformationFirstScreen> createState() =>
      _MainInformationFirstScreenState();
}

class _MainInformationFirstScreenState
    extends State<MainInformationFirstScreen> {
  @override
  void initState() {
    super.initState();
    callingProfileAPI();
  }

  callingProfileAPI() {
    final postAnAdProvider =
        Provider.of<PostAnAdProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((value) async {
      postAnAdProvider.setLoadSecondPadeData(false);
      
      await postAnAdProvider.getCategoryList(
          context, RouterHelper.postAdMainDetailFirstScreen);
      
      if (ModalRoute.of(context)!.settings.arguments != null) {
        postAnAdProvider.setLoadSecondPadeData(true);
        if (postAnAdProvider.isSubCategoryLoading == false) {
          
          await postAnAdProvider.getCategoryList(
              context, RouterHelper.postAdMainDetailFirstScreen);
          final args =
              
              ModalRoute.of(context)!.settings.arguments as PropertiesData;
          postAnAdProvider.setListData(args);
          
          await postAnAdProvider.getCategoryList(
              context, RouterHelper.postAdMainDetailFirstScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: Consumer<PostAnAdProvider>(
        builder: (context, controller, child) {
          return WillPopScope(
            onWillPop: () {
              controller.clearAllPostAdScreen();
              return Future.value(true);
            },
            child: SafeArea(
              top: Platform.isAndroid ? true : false,
              bottom: Platform.isAndroid ? true : false,
              child: Scaffold(
                appBar: AdsAppBar(
                  appBar: AppBar(),
                  isSaveQuitHidden: true,
                  screen: propertyDetails,
                ),
                body: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: setWidgetWidth(30),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AdsStepsDetails(
                                      steps: 1,
                                      stepTitle: translate(context,
                                          language.languageCode, property)!,
                                      stepDescription:
                                          '${translate(context, language.languageCode, nextText)!}: ${translate(context, language.languageCode, propertyDetails)!}'),

                                  marginHeight(28),
                                  InformationTitle(
                                      information: translate(
                                          context,
                                          language.languageCode,
                                          mainInformation)!),
                                  marginHeight(7),
                                  const InformationDetails(),
                                  marginHeight(28),
                                  controller.isLoading == false
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${translate(context, language.languageCode, category)!} *',
                                              style: textStyle(
                                                fontSize: 10,
                                                color: blackPrimary,
                                                fontFamily: satoshiMedium,
                                              ),
                                            ),
                                            marginHeight(8),
                                            BorderView(
                                              height: 50,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        setWidgetWidth(15)),
                                                // Type of Category DropDown Button
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                      menuMaxHeight:
                                                          setWidgetHeight(300),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      hint: Text(
                                                        translate(
                                                            context,
                                                            language
                                                                .languageCode,
                                                            selectCategory)!,
                                                        style: textStyle(
                                                            fontSize: 14,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiRegular),
                                                      ),
                                                      isExpanded: true,
                                                      value: controller
                                                              .prpoertyCategoryList[
                                                          controller
                                                              .categorySelected],
                                                      icon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        size: 25,
                                                      ),
                                                      items: controller
                                                          .prpoertyCategoryList
                                                          .map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                              (itemValue) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: itemValue,
                                                          child: Text(
                                                            translate(
                                                                context,
                                                                language
                                                                    .languageCode,
                                                                itemValue)!,
                                                            style: textStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    blackPrimary,
                                                                fontFamily:
                                                                    satoshiRegular),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (String?
                                                          newValue) async {
                                                        await controller
                                                            .getCategoryIndexValue(
                                                                newValue);
                                                        Future.delayed(
                                                            Duration.zero,
                                                            (() async {
                                                          await controller
                                                              .getSubCategoryList(
                                                                  context,
                                                                  RouterHelper
                                                                      .postAdMainDetailFirstScreen);
                                                          controller
                                                              .clearLists();
                                                        })).then((value) {
                                                          controller
                                                              .clearFirstTwoStepsFields();
                                                          controller
                                                              .clearContactScreen();
                                                        });

                                                        controller.setDropDownValue(
                                                            title: "flat",
                                                            value: newValue
                                                                .toString(),
                                                            index: controller
                                                                .prpoertyCategoryList
                                                                .indexOf(
                                                                    newValue!));
                                                      }),
                                                ),
                                              ),
                                            ),
                                            marginHeight(19),
                                          ],
                                        )
                                      : const PropertyDropdownListShimmer(
                                          textWidth: 50,
                                        ),
                                  controller.isSubCategoryLoading == true
                                      ? const PropertyDropdownListShimmer(
                                          textWidth: 80,
                                        )
                                      //If Property selected is Multi Family Residential(categoryListId == 23) or
                                      //is Allotment(categoryListId == 100) then
                                      //Sub Category Lis will be null Otherwise Loading Sub Category List
                                      : controller.categoryListId == 23 ||
                                              controller.categoryListId == 100
                                          ? const SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      translate(
                                                          context,
                                                          language.languageCode,
                                                          typeOfProperty)!,
                                                      style: textStyle(
                                                          fontSize: 10,
                                                          color: blackPrimary,
                                                          fontFamily:
                                                              satoshiMedium),
                                                    ),
                                                  ],
                                                ),
                                                marginHeight(8),
                                                BorderView(
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                setWidgetWidth(
                                                                    15)),
                                                    // Sub Category DropDown Button
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        menuMaxHeight:
                                                            setWidgetHeight(
                                                                300),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        isExpanded: true,
                                                        value: controller
                                                                .prpoertySubCategoryList[
                                                            controller
                                                                .subCategorySelected],
                                                        icon: const Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 25,
                                                        ),
                                                        items: controller
                                                            .prpoertySubCategoryList
                                                            .map<
                                                                    DropdownMenuItem<
                                                                        String>>(
                                                                (itemValue) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: itemValue,
                                                            child: Text(
                                                              translate(
                                                                  context,
                                                                  language
                                                                      .languageCode,
                                                                  itemValue)!,
                                                              style: textStyle(
                                                                  fontSize: 14,
                                                                  color:
                                                                      blackPrimary,
                                                                  fontFamily:
                                                                      satoshiRegular),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (String?
                                                            newValue) async {
                                                          await controller
                                                              .getSubCategoryIndexValue(
                                                                  newValue);
                                                          controller.setDropDownValue(
                                                              title: "home",
                                                              value: newValue
                                                                  .toString(),
                                                              index: controller
                                                                  .prpoertySubCategoryList
                                                                  .indexOf(
                                                                      newValue!));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                marginHeight(19),
                                              ],
                                            ),
                                  Row(
                                    children: [
                                      Text(
                                        '${translate(context, language.languageCode, typeOfOwnership)!} *',
                                        style: textStyle(
                                            fontSize: 10,
                                            color: blackPrimary,
                                            fontFamily: satoshiMedium),
                                      ),
                                    ],
                                  ),
                                  marginHeight(15),
                                  SizedBox(
                                    height: setWidgetHeight(30),
                                    child: RadioListHorizontal(
                                      controller.radioListPage1,
                                      fontSize: 14,
                                      selectedIndex:
                                          controller.categoryListId == 23
                                              ? 0
                                              : controller
                                                  .currentIndexForPage1List,
                                    ),
                                  ),

                                  //Bottom Padding
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: setWidgetHeight(30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        BottomButtons(
                          screen: translate(
                              context, language.languageCode, propertyDetails)!,
                          leftButtonName: translate(
                              context, language.languageCode, cancel)!,
                          rightButtonName:
                              translate(context, language.languageCode, apply)!,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
