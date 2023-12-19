// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/post_an_ad_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/post_an_ad/components/ad_steps_details.dart';
import 'package:immo/view/post_an_ad/components/ads_app_bar.dart';
import 'package:immo/view/widgets/ads_bottom_buttons.dart';
import 'package:immo/view/post_an_ad/components/ads_screen_information_title.dart';
import 'package:immo/view/widgets/radio_list.dart';
import 'package:immo/view/widgets/radio_list_horizontal.dart';
import 'package:provider/provider.dart';

import '../../helper/debouncer.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../../utils/images.dart';
import '../widgets/Shimmer/post_an_ad/date_shimmer.dart';
import '../widgets/Shimmer/post_an_ad/property_dropdown_list.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/input_field.dart';
import 'components/ad_checkbox.dart';
import 'components/ads_border_view.dart';

class MainInformationSecondScreen extends StatefulWidget {
  const MainInformationSecondScreen({super.key});

  @override
  State<MainInformationSecondScreen> createState() =>
      _MainInformationSecondScreenState();
}

class _MainInformationSecondScreenState
    extends State<MainInformationSecondScreen> {
  final debouncer = DeBouncer(milliseconds: 300);
  @override
  void initState() {
    super.initState();
    callingAPI();
  }

  callingAPI() {
    final postAnAdProvider =
        Provider.of<PostAnAdProvider>(context, listen: false);
    Future.delayed(Duration.zero, (() async {
      fetchMultipleApis(postAnAdProvider);
      // Future.delayed(Duration.zero, () {
      //   if (postAnAdProvider.categoryListId == 23) {
      //     postAnAdProvider.getNoOfHousingUnitsList(
      //         context, RouterHelper.postAdMainDetailSecondScreen);
      //   } else {
      //     postAnAdProvider.getNoOfRoomsList(
      //         context, RouterHelper.postAdMainDetailSecondScreen);
      //   }
      // });
      // Future.delayed(Duration.zero, () {
      //   postAnAdProvider.getNoOfFloorsList(
      //       context, RouterHelper.postAdMainDetailSecondScreen);
      // });
      // Future.delayed(Duration.zero, () {
      //   postAnAdProvider.getCountriesList(
      //       context, RouterHelper.postAdMainDetailSecondScreen);
      // });
      // if (postAnAdProvider.dateController.text.isEmpty) {
      //   postAnAdProvider.dateController.text =
      //       '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
      // }
    })).then((value) {
      if (postAnAdProvider.isSecondScreenLoading == true) {
        postAnAdProvider.setSecondScreenData();
      }
    });
  }

  Future<void> fetchMultipleApis(PostAnAdProvider postAnAdProvider) async {
    // Create a list of futures for each API call
    List<Future> apiFutures = [
      getHouseOrRoomList(postAnAdProvider),
      getFloorsList(postAnAdProvider),
      getCountriesList(postAnAdProvider),
    ];
    // Wait for all the API calls to complete
    await Future.wait(apiFutures);
  }

  Future<void> getHouseOrRoomList(postAnAdProvider) async {
    if (postAnAdProvider.categoryListId == 23) {
      postAnAdProvider.getNoOfHousingUnitsList(
          context, RouterHelper.postAdMainDetailSecondScreen);
    } else {
      postAnAdProvider.getNoOfRoomsList(
          context, RouterHelper.postAdMainDetailSecondScreen);
    }
  }

  Future<void> getFloorsList(postAnAdProvider) async {
    postAnAdProvider.getNoOfFloorsList(
        context, RouterHelper.postAdMainDetailSecondScreen);
  }

  Future<void> getCountriesList(postAnAdProvider) async {
    postAnAdProvider.getCountriesList(
        context, RouterHelper.postAdMainDetailSecondScreen);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AdsAppBar(
            appBar: AppBar(),
            screen: details,
          ),
          body: Consumer<PostAnAdProvider>(
            builder: (context, controller, child) {
              return Consumer<LanguageProvider>(
                builder: (context, language, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: setWidgetWidth(30)),
                            child: Column(
                              children: [
                                AdsStepsDetails(
                                    steps: 1,
                                    stepTitle: translate(
                                        context,
                                        language.languageCode,
                                        propertyDetails)!,
                                    stepDescription:
                                        '${translate(context, language.languageCode, nextText)}: ${translate(context, language.languageCode, details)!}'),
                                marginHeight(28),
                                InformationTitle(
                                    information: translate(
                                        context,
                                        language.languageCode,
                                        mainInformation)!),
                                marginHeight(7),
                                const InformationDetails(),
                                marginHeight(28),
                                Row(
                                  children: [
                                    Text(
                                      '${translate(context, language.languageCode, titleOfTheAd)!} *',
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    )
                                  ],
                                ),
                                marginHeight(8),
                                // Title of ad Text Field
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      enterTitle)!,
                                  TextInputType.text,
                                  controller.titleOfAdController,
                                ),
                                marginHeight(19),
                                //No of Rooms Drop Down List & Housing Units
                                //If Property Category Selected is Parking(categoryListId == 88) or
                                //is Plot(categoryListId == 101) then Hide these Number of Rooms and Housing Units Field
                                controller.categoryListId == 88 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          controller.isLoading == false
                                              ? Column(
                                                  children: [
                                                    //If Property Category Selected is not Multi Family Residential(categoryListId != 23) then
                                                    // Show Number of rooms Field
                                                    controller.categoryListId !=
                                                            23
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${translate(context, language.languageCode, numberOfRooms)!} *',
                                                                style:
                                                                    textStyle(
                                                                  fontSize: 10,
                                                                  color:
                                                                      blackPrimary,
                                                                  fontFamily:
                                                                      satoshiMedium,
                                                                ),
                                                              ),
                                                              marginHeight(8),
                                                              BorderView(
                                                                height: 50,
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          setWidgetWidth(
                                                                              15)),
                                                                  // Type of Rooms DropDown Button
                                                                  child:
                                                                      DropdownButtonHideUnderline(
                                                                    child: DropdownButton<
                                                                        String>(
                                                                      menuMaxHeight:
                                                                          setWidgetHeight(
                                                                              300),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      isExpanded:
                                                                          true,
                                                                      value: controller
                                                                              .noOfRoomsList[
                                                                          controller
                                                                              .noOfRoomSelected],
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      items: controller
                                                                          .noOfRoomsList
                                                                          .map<DropdownMenuItem<String>>(
                                                                              (itemValue) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              itemValue,
                                                                          child:
                                                                              Text(
                                                                            itemValue,
                                                                            style: textStyle(
                                                                                fontSize: 14,
                                                                                color: blackPrimary,
                                                                                fontFamily: satoshiRegular),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) async {
                                                                        await controller
                                                                            .getNoOfRoomsIndexValue(newValue);
                                                                        controller.setDropDownValue(
                                                                            title:
                                                                                "roomsList",
                                                                            value:
                                                                                newValue.toString(),
                                                                            index: controller.noOfRoomsList.indexOf(newValue!));
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${translate(context, language.languageCode, numberOfHousingUnits)!} *',
                                                                style:
                                                                    textStyle(
                                                                  fontSize: 10,
                                                                  color:
                                                                      blackPrimary,
                                                                  fontFamily:
                                                                      satoshiMedium,
                                                                ),
                                                              ),
                                                              marginHeight(8),
                                                              BorderView(
                                                                height: 50,
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          setWidgetWidth(
                                                                              15)),
                                                                  // Type of Housing Units DropDown Button
                                                                  child:
                                                                      DropdownButtonHideUnderline(
                                                                    child: DropdownButton<
                                                                        String>(
                                                                      menuMaxHeight:
                                                                          setWidgetHeight(
                                                                              300),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      isExpanded:
                                                                          true,
                                                                      value: controller
                                                                              .noOfHousingUnitsList[
                                                                          controller
                                                                              .noOfHousingUnitsSelected],
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      items: controller
                                                                          .noOfHousingUnitsList
                                                                          .map<DropdownMenuItem<String>>(
                                                                              (itemValue) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              itemValue,
                                                                          child:
                                                                              Text(
                                                                            itemValue,
                                                                            style: textStyle(
                                                                                fontSize: 14,
                                                                                color: blackPrimary,
                                                                                fontFamily: satoshiRegular),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) async {
                                                                        await controller
                                                                            .getNoOfHousingUnitsIndexValue(newValue);
                                                                        controller.setDropDownValue(
                                                                            title:
                                                                                "House",
                                                                            value:
                                                                                newValue.toString(),
                                                                            index: controller.noOfHousingUnitsList.indexOf(newValue!));
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                    marginHeight(19),
                                                  ],
                                                )
                                              : const PropertyDropdownListShimmer(
                                                  textWidth: 130),
                                        ],
                                      ),
                                //If Property Category Selected is Additional(categoryListId == 24) or
                                //is Property Category Selected is Gastronomy(categoryListId == 28) or
                                //is Property Category Selected is Commercial(categoryListId == 46) or
                                //is Property Category Selected is Agriculture(categoryListId == 84) or
                                //is Property Category Selected is Parking(categoryListId == 88) or
                                //is Property Category Selected is Allotment(categoryListId == 100) or
                                //is Property Category Selected is Plot(categoryListId == 101) then
                                //hide Living Space Field
                                controller.categoryListId == 24 ||
                                        controller.categoryListId == 28 ||
                                        controller.categoryListId == 46 ||
                                        controller.categoryListId == 84 ||
                                        controller.categoryListId == 88 ||
                                        controller.categoryListId == 100 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translate(context, language.languageCode, livingSpace)!} (m²)',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Living Space Text Field
                                          CustomInputFormField(
                                            translate(
                                                context,
                                                language.languageCode,
                                                livingSpace)!,
                                            TextInputType.number,
                                            controller.livingSpaceController,
                                          ),
                                          marginHeight(19),
                                        ],
                                      ),
                                //If Property Category Selected is House(categoryListId == 12) or
                                //If Property Category Selected is Multi Family Residential(categoryListId == 23) or
                                //If Property Category Selected is Additional(categoryListId == 24) or
                                //is Property Category Selected is Gastronomy(categoryListId == 28) or
                                //is Property Category Selected is Commercial(categoryListId == 46) or
                                //is Property Category Selected is Agriculture(categoryListId == 84) or
                                //is Property Category Selected is Allotment(categoryListId == 100) or
                                //is Property Category Selected is Plot(categoryListId == 101) then
                                //Show Plot Area Field
                                controller.categoryListId == 12 ||
                                        controller.categoryListId == 23 ||
                                        controller.categoryListId == 24 ||
                                        controller.categoryListId == 28 ||
                                        controller.categoryListId == 46 ||
                                        controller.categoryListId == 84 ||
                                        controller.categoryListId == 100 ||
                                        controller.categoryListId == 101
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translate(context, language.languageCode, plotArea)!}  (m²)',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          //Plot Area Text Field
                                          CustomInputFormField(
                                            translate(
                                                context,
                                                language.languageCode,
                                                plotArea)!,
                                            TextInputType.number,
                                            controller.plotAreaController,
                                          ),
                                          marginHeight(19),
                                        ],
                                      )
                                    : const SizedBox(),
                                Row(
                                  children: [
                                    Text(
                                      '${translate(context, language.languageCode, floorSpace)!}  (m²)',
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                //Floor Space Text Field
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      floorSpace)!,
                                  TextInputType.number,
                                  controller.floorSpaceController,
                                ),
                                marginHeight(19),
                                //If Property Category Selected is House(categoryListId == 12) or
                                //If Property Category Selected is Multi Family Residential(categoryListId == 23) or
                                //is Property Category Selected is Plot(categoryListId == 101) then
                                //Hide Floors Field
                                controller.categoryListId == 12 ||
                                        controller.categoryListId == 23 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : controller.isLoading == false
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                translate(
                                                    context,
                                                    language.languageCode,
                                                    floors)!,
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
                                                  // Type of Floors DropDown Button
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton<String>(
                                                      menuMaxHeight:
                                                          setWidgetHeight(300),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      isExpanded: true,
                                                      value: controller
                                                              .noOfFloorsList[
                                                          controller
                                                              .noOfFloorsSelected],
                                                      icon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        size: 25,
                                                      ),
                                                      items: controller
                                                          .noOfFloorsList
                                                          .map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                              (itemValue) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: itemValue,
                                                          child: Text(
                                                            itemValue,
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
                                                            .getNoOfFloorsIndexValue(
                                                                newValue);
                                                        controller.setDropDownValue(
                                                            title: "floors",
                                                            value: newValue
                                                                .toString(),
                                                            index: controller
                                                                .noOfFloorsList
                                                                .indexOf(
                                                                    newValue!));
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              marginHeight(19),
                                            ],
                                          )
                                        : const PropertyDropdownListShimmer(
                                            textWidth: 50),
                                Row(
                                  children: [
                                    Text(
                                      "${translate(context, language.languageCode, availability)!} *",
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Radio Button From Date
                                // Radio Button Immidiately
                                // Radio Button On Request
                                RadioList(
                                  controller.verticalRadioListPage2,
                                  fontSize: 14,
                                  heightSpace: 40,
                                  isLeftSideRadio: true,
                                  currentIndex: controller
                                      .currentIndexVerticalRadioListPage2,
                                ),
                                marginHeight(19),
                                //If Only From Date is Selected
                                //then show calender
                                controller.currentIndexVerticalRadioListPage2 ==
                                        0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translate(context,
                                                language.languageCode, date)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          Row(
                                            children: [
                                              controller.isLoading == false
                                                  ? Container(
                                                      height:
                                                          setWidgetHeight(50),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: greyLight,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        setWidgetHeight(
                                                                            7)),
                                                            child: SizedBox(
                                                              width:
                                                                  setWidgetWidth(
                                                                      150),
                                                              child:
                                                                  TextFormField(
                                                                style:
                                                                    textStyle(
                                                                  fontSize: 18,
                                                                  color:
                                                                      blackPrimary,
                                                                  fontFamily:
                                                                      satoshiRegular,
                                                                ),
                                                                textAlignVertical:
                                                                    TextAlignVertical
                                                                        .top,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                enabled: false,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                controller:
                                                                    controller
                                                                        .dateController,
                                                                onSaved: (val) {
                                                                  controller
                                                                          .setDate =
                                                                      val!;
                                                                },
                                                              ),
                                                            ).onPress(
                                                              () {
                                                                controller
                                                                    .selectDate(
                                                                        context);
                                                              },
                                                            ),
                                                          ),
                                                          const ImageIcon(
                                                            AssetImage(Images
                                                                .iconArrowDown),
                                                            size: 13,
                                                          ),
                                                          marginWidth(10),
                                                        ],
                                                      ),
                                                    )
                                                  : const DateShimmer(),
                                              marginWidth(20),
                                              // Calender Icon
                                              Image(
                                                image: const AssetImage(
                                                    Images.iconCalendar),
                                                width: setWidgetWidth(40),
                                                height: setWidgetHeight(40),
                                              ).onPress(
                                                () {
                                                  controller
                                                      .selectDate(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          marginHeight(19),
                                        ],
                                      )
                                    : const SizedBox(),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          description)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      writeHere)!,
                                  TextInputType.text,
                                  controller.descriptionController,
                                  lines: 5,
                                ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          currency)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(15),
                                // Radio Buttion CHF
                                // Radio Button EUR
                                // Radio Button USD
                                SizedBox(
                                  height: setWidgetHeight(30),
                                  child: RadioListHorizontal(
                                    controller.horizontalRadioListPage2,
                                    fontSize: 14,
                                    selectedIndex: controller
                                        .currentIndexHorizontalRadioListPage2,
                                  ),
                                ),
                                //If Property Category Selected is Gastronomy(categoryListId == 28) or
                                //is Property Category Selected is commercialcategoryListId == 46) and
                                //if Type of ownership is For rent(currentIndexForPage1List == 0) is Selected then
                                //Show  Radio Buttions Indication Price
                                (controller.categoryListId == 28 ||
                                            controller.categoryListId == 46) &&
                                        controller.currentIndexForPage1List == 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          marginHeight(19),
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                indicationOfPrice)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(15),
                                          // Radio Buttions Indication Price
                                          SizedBox(
                                            height:
                                                language.languageCode != 'en' ||
                                                        language.languageCode !=
                                                            'fr'
                                                    ? setWidgetHeight(40)
                                                    : setWidgetHeight(30),
                                            child: RadioListHorizontal(
                                              controller
                                                  .radioListIndicationPrice,
                                              fontSize: 14,
                                              selectedIndex: controller
                                                  .currentIndexForIndicationPriceList,
                                            ),
                                          ),
                                        ],
                                      )
                                    //If Property Category Selected is Plot(categoryListId == 101) and
                                    //if Type of ownership is For sale(currentIndexForPage1List == 1) is Selected then
                                    //Show  Radio Buttions Indication Price
                                    : controller.categoryListId == 101 &&
                                            controller
                                                    .currentIndexForPage1List ==
                                                1
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              marginHeight(19),
                                              Text(
                                                translate(
                                                    context,
                                                    language.languageCode,
                                                    indicationOfPrice)!,
                                                style: textStyle(
                                                  fontSize: 10,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiMedium,
                                                ),
                                              ),
                                              marginHeight(15),
                                              // Radio Buttions Indication Price
                                              SizedBox(
                                                height: setWidgetHeight(30),
                                                child: RadioListHorizontal(
                                                  controller
                                                      .radioListIndicationPriceForSale,
                                                  fontSize: 14,
                                                  selectedIndex: controller
                                                      .currentIndexForIndicationPriceList,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                //If Property Category Selected is Gastronomy(categoryListId == 28) or
                                //is Property Category Selected is commercialcategoryListId == 46) and
                                //if Type of ownership is For rent(currentIndexForPage1List == 0) is Selected then
                                //Show  Radio Buttions Indication Price
                                controller.currentIndexForPage1List == 0 &&
                                        controller.categoryListId == 23
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          marginHeight(19),
                                          //if Price on request check box not selected then
                                          //show Selling Price Field & Gross Return
                                          !controller
                                                  .checkValues[priceOnRequest]!
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${translate(context, language.languageCode, sellingPrice)!} *',
                                                      style: textStyle(
                                                        fontSize: 10,
                                                        color: blackPrimary,
                                                        fontFamily:
                                                            satoshiMedium,
                                                      ),
                                                    ),
                                                    marginHeight(8),
                                                    CustomInputFormField(
                                                      translate(
                                                          context,
                                                          language.languageCode,
                                                          controller
                                                              .priceVlaue())!,
                                                      const TextInputType
                                                          .numberWithOptions(),
                                                      controller
                                                          .sellingPriceController,
                                                    ),
                                                    marginHeight(19),
                                                    Text(
                                                      translate(
                                                          context,
                                                          language.languageCode,
                                                          grossReturn)!,
                                                      style: textStyle(
                                                        fontSize: 10,
                                                        color: blackPrimary,
                                                        fontFamily:
                                                            satoshiMedium,
                                                      ),
                                                    ),
                                                    marginHeight(8),
                                                    CustomInputFormField(
                                                      '%',
                                                      const TextInputType
                                                          .numberWithOptions(),
                                                      controller
                                                          .grossReturnController,
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          marginHeight(19),
                                          // Price on request is on keys.elementAt(0)
                                          AdCheckBox(name: priceOnRequest),
                                        ],
                                      )
                                    //if Type of ownership is For rent(currentIndexForPage1List == 0) is Selected then
                                    //Show  Rent Include Utilities & Utilities & Rent Exclude Utilities Field
                                    : controller.currentIndexForPage1List == 0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //if Price on request check box not selected then
                                              //show Rent Include Utilities Field
                                              !controller.checkValues[
                                                      priceOnRequest]!
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        marginHeight(19),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              translate(
                                                                  context,
                                                                  language
                                                                      .languageCode,
                                                                  rentIncludeUtilities)!,
                                                              style: textStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    blackPrimary,
                                                                fontFamily:
                                                                    satoshiMedium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        marginHeight(8),
                                                        // Text Field of Rent including utilities
                                                        // Hint Text will be dynamic according to currency radio buttons value
                                                        CustomInputFormField(
                                                          translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              controller
                                                                  .priceVlaue())!,
                                                          const TextInputType
                                                              .numberWithOptions(),
                                                          controller
                                                              .rentIncludeUtilitiesController,
                                                        ),
                                                        //If Property Category Selected is Plot(categoryListId == 101)
                                                        //then only show Rent Include Utilities
                                                        controller.categoryListId ==
                                                                101
                                                            ? const SizedBox()
                                                            : Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  marginHeight(
                                                                      19),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        translate(
                                                                            context,
                                                                            language.languageCode,
                                                                            utilities)!,
                                                                        style:
                                                                            textStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              blackPrimary,
                                                                          fontFamily:
                                                                              satoshiMedium,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  marginHeight(
                                                                      8),
                                                                  // Text Field of Utilities
                                                                  // Hint Text will be dynamic according to currency radio buttons value
                                                                  CustomInputFormField(
                                                                    translate(
                                                                        context,
                                                                        language
                                                                            .languageCode,
                                                                        controller
                                                                            .priceVlaue())!,
                                                                    const TextInputType
                                                                        .numberWithOptions(),
                                                                    controller
                                                                        .utilitiesController,
                                                                  ),
                                                                  marginHeight(
                                                                      19),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        translate(
                                                                            context,
                                                                            language.languageCode,
                                                                            rentExcludeUtilities)!,
                                                                        style:
                                                                            textStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              blackPrimary,
                                                                          fontFamily:
                                                                              satoshiMedium,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  marginHeight(
                                                                      8),
                                                                  // Text Field of Rent excluding utilities
                                                                  // Hint Text will be dynamic according to currency radio buttons value
                                                                  CustomInputFormField(
                                                                    translate(
                                                                        context,
                                                                        language
                                                                            .languageCode,
                                                                        controller
                                                                            .priceVlaue())!,
                                                                    const TextInputType
                                                                        .numberWithOptions(),
                                                                    controller
                                                                        .rentExcludeUtilitiesController,
                                                                  ),
                                                                ],
                                                              ),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              marginHeight(19),
                                              // Price on request is on keys.elementAt(0)
                                              AdCheckBox(
                                                name: priceOnRequest,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //if Price on request check box not selected then
                                              //show Selling Price Field
                                              !controller.checkValues[
                                                      priceOnRequest]!
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        marginHeight(19),
                                                        Text(
                                                          '${translate(context, language.languageCode, sellingPrice)!} *',
                                                          style: textStyle(
                                                            fontSize: 10,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiMedium,
                                                          ),
                                                        ),
                                                        marginHeight(8),
                                                        CustomInputFormField(
                                                          translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              controller
                                                                  .priceVlaue())!,
                                                          const TextInputType
                                                              .numberWithOptions(),
                                                          controller
                                                              .sellingPriceController,
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              marginHeight(19),
                                              // Price on request is on keys.elementAt(0)
                                              AdCheckBox(
                                                name: priceOnRequest,
                                              ),
                                            ],
                                          ),
                                marginHeight(19),
                                controller.isLoading == false
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                country)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          TextFormField(
                                            initialValue: translate(
                                                context,
                                                language.languageCode,
                                                controller
                                                    .countriesList.first)!,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintStyle: textStyle(
                                                  fontSize: 14,
                                                  color: greyLight,
                                                  fontFamily: satoshiRegular),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                          setWidgetWidth(15),
                                                      vertical:
                                                          setWidgetHeight(15)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: greyLight),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: greyLight),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: greyLight),
                                              ),
                                            ),
                                          ),
                                          marginHeight(19),
                                        ],
                                      )
                                    : const PropertyDropdownListShimmer(
                                        textWidth: 50,
                                      ),

                                Row(
                                  children: [
                                    Text(
                                      '${translate(context, language.languageCode, postCode)!} *',
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field of Postcode and city
                                Column(
                                  children: [
                                    TypeAheadField(
                                      animationStart: 0,
                                      animationDuration: Duration.zero,
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: controller
                                            .postCodeandCityController,
                                        textInputAction: TextInputAction.done,
                                        obscureText: false,
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          fillColor: whitePrimary,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          hintStyle: textStyle(
                                              fontSize: 14,
                                              color: greyLight,
                                              fontFamily: satoshiRegular),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: setWidgetWidth(15),
                                              vertical: setWidgetHeight(15)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: greyLight),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: greyLight),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: greyLight),
                                          ),
                                        ),
                                      ),
                                      suggestionsBoxDecoration:
                                          const SuggestionsBoxDecoration(
                                              color: whitePrimary),
                                      suggestionsCallback: (pattern) async {
                                        return await controller
                                            .tapOnPostalCodeTextField(pattern);
                                      },
                                      itemBuilder: (context, city) {
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(city.toString()),
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        controller.postCodeandCityController
                                            .text = suggestion.toString();
                                        controller.getCityLatLong(
                                            suggestion.toString());
                                      },
                                    )
                                  ],
                                ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          streetAndHouse)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field of Street and house number
                                Column(
                                  children: [
                                    TypeAheadField(
                                      animationStart: 0,
                                      animationDuration: Duration.zero,
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: controller
                                            .streetAndHouseNumberController,
                                        textInputAction: TextInputAction.done,
                                        obscureText: false,
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          fillColor: whitePrimary,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          hintStyle: textStyle(
                                              fontSize: 14,
                                              color: greyLight,
                                              fontFamily: satoshiRegular),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: setWidgetWidth(15),
                                              vertical: setWidgetHeight(15)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: greyLight),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: greyLight),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: greyLight),
                                          ),
                                        ),
                                      ),
                                      suggestionsBoxDecoration:
                                          const SuggestionsBoxDecoration(
                                              color: whitePrimary),
                                      suggestionsCallback: (pattern) async {
                                        return await controller
                                            .getPlacesAddress(pattern);
                                      },
                                      itemBuilder: (context, place) {
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(place.toString()),
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        controller
                                            .streetAndHouseNumberController
                                            .text = suggestion.toString();
                                        controller.setStreetLatlong(
                                            suggestion.toString());
                                      },
                                    )
                                  ],
                                ),
                                marginHeight(10),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Wrap(
                                      children: [
                                        Image.asset(
                                          Images.iconMap,
                                          width: setWidgetWidth(24),
                                          height: setWidgetHeight(24),
                                        ),
                                        SizedBox(
                                          width: setWidgetWidth(5),
                                        ),
                                        Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                selectOnMap)!,
                                            style: textStyle(
                                                fontSize: 16,
                                                color: bluePrimary,
                                                fontFamily: satoshiRegular))
                                      ],
                                    ).onPress(() async {
                                      Future.delayed(Duration.zero, () {
                                        if (controller.postCodeandCityController
                                            .text.isNotEmpty) {
                                          debouncer.run(() async {
                                            await controller
                                                .getCurrentCameraPosition(
                                                    context)
                                                .then((value) {
                                              Navigator.pushNamed(
                                                  context,
                                                  RouterHelper
                                                      .postAdLocationScreen);
                                            });
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(customSnackBar(
                                                  context,
                                                  pleaseSelectCityFirst,
                                                  1));
                                        }
                                      });
                                    }),
                                  ],
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
                        screen:
                            translate(context, language.languageCode, details)!,
                        leftButtonName:
                            translate(context, language.languageCode, cancel)!,
                        rightButtonName: translate(
                            context, language.languageCode, saveNext)!,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
