import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/radio_list.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../widgets/input_field.dart';
import 'components/ad_checkbox.dart';
import 'components/ad_steps_details.dart';
import 'components/ads_app_bar.dart';
import '../widgets/ads_bottom_buttons.dart';
import 'components/ads_screen_information_title.dart';

class DimentionsScreen extends StatelessWidget {
  const DimentionsScreen({super.key});

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
            screen: imagesVideosPDFs,
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
                              horizontal: setWidgetWidth(30),
                            ),
                            child: Column(
                              children: [
                                AdsStepsDetails(
                                    steps: 2,
                                    stepTitle: translate(context,
                                        language.languageCode, details)!,
                                    stepDescription:
                                        '${translate(context, language.languageCode, nextText)}: ${translate(context, language.languageCode, imagesVideosPDFs)!}'),
                                marginHeight(28),
                                InformationTitle(
                                    information: translate(context,
                                        language.languageCode, dimentions)!),
                                marginHeight(7),
                                const InformationDetails(),
                                marginHeight(28),
                                // If Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) then
                                // Show Room Height Field & Hall Height Field
                                controller.categoryListId == 28 ||
                                        controller.categoryListId == 46 ||
                                        controller.categoryListId == 84
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translate(context, language.languageCode, roomHeight)!} (m)',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Text Field Room Height(m)
                                          CustomInputFormField(
                                            '',
                                            const TextInputType
                                                .numberWithOptions(),
                                            controller.roomHeightController,
                                          ),
                                          marginHeight(19),
                                          Text(
                                            '${translate(context, language.languageCode, hallHeight)!} (m)',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Text Field Hall Height(m)
                                          CustomInputFormField(
                                            '',
                                            const TextInputType
                                                .numberWithOptions(),
                                            controller.hallHeightController,
                                          ),
                                          marginHeight(19),
                                        ],
                                      )
                                    : const SizedBox(),
                                // Text Field Cubage (m3)
                                // If Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Cubage Field
                                controller.categoryListId == 88 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${translate(context, language.languageCode, cubage)!} (m\u00B3)",
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          CustomInputFormField(
                                            '',
                                            const TextInputType
                                                .numberWithOptions(),
                                            controller.cubageController,
                                          ),
                                          marginHeight(19),
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          noOfFloors)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field No of Floors
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      noOfFloors)!,
                                  const TextInputType.numberWithOptions(),
                                  controller.numberOfFloorsController,
                                ),
                                marginHeight(28),
                                // Interior
                                // If Property Category is Plot(categoryListId == 101) or then
                                // Hide entire Interior
                                controller.categoryListId == 101
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                interior)!,
                                            style: textStyle(
                                              fontSize: 18,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(25),
                                          // Wheel Chair Permission CheckBox
                                          // If Property Category is Parking(categoryListId == 88) or then
                                          // Hide Wheel Chair Permission
                                          controller.categoryListId == 88
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: wheelChairAccess,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Pet Permission CheckBox
                                          // If Property Category is Additional(categoryListId == 24) or
                                          // is Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) or
                                          // is Property Category is Parking(categoryListId == 88) or
                                          // is Property Category is Allotment(categoryListId == 100) then
                                          // Hide Pet Permitted
                                          controller.categoryListId == 24 ||
                                                  controller.categoryListId ==
                                                      28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84 ||
                                                  controller.categoryListId ==
                                                      88 ||
                                                  controller.categoryListId ==
                                                      100
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: petPermission,
                                                    ),
                                                    marginHeight(19),
                                                  ],
                                                ),
                                          // Toilets CheckBox
                                          // If Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) then
                                          // Show Toilets
                                          controller.categoryListId == 28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: toilets,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          // Text Field No of BathRooms
                                          // If Property Category is Additional(categoryListId == 24) or
                                          // is Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) or
                                          // is Property Category is Parking(categoryListId == 88) or
                                          // is Property Category is Allotment(categoryListId == 100) then
                                          // Hide Number of Bathrooms
                                          controller.categoryListId == 24 ||
                                                  controller.categoryListId ==
                                                      28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84 ||
                                                  controller.categoryListId ==
                                                      88 ||
                                                  controller.categoryListId ==
                                                      100
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      translate(
                                                          context,
                                                          language.languageCode,
                                                          noOfBathRooms)!,
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
                                                          noOfBathRooms)!,
                                                      const TextInputType
                                                          .numberWithOptions(),
                                                      controller
                                                          .numberofBathroomsController,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // View CheckBox
                                          AdCheckBox(
                                            name: view,
                                          ),
                                          marginHeight(20),
                                          // Attic CheckBox
                                          // If Property Category is Additional(categoryListId == 24) or
                                          // is Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) or
                                          // is Property Category is Parking(categoryListId == 88) or
                                          // is Property Category is Allotment(categoryListId == 100) then
                                          // Hide Attic
                                          controller.categoryListId == 24 ||
                                                  controller.categoryListId ==
                                                      28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84 ||
                                                  controller.categoryListId ==
                                                      88 ||
                                                  controller.categoryListId ==
                                                      100
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: attic,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Cellar CheckBox
                                          // If Property Category is Additional(categoryListId == 24) or
                                          // is Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) or
                                          // is Property Category is Parking(categoryListId == 88) or
                                          // is Property Category is Allotment(categoryListId == 100) then
                                          // Hide Cellar
                                          controller.categoryListId == 24 ||
                                                  controller.categoryListId ==
                                                      28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84 ||
                                                  controller.categoryListId ==
                                                      88 ||
                                                  controller.categoryListId ==
                                                      100
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: cellar,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Storage Room CheckBox
                                          // If Property Category is Additional(categoryListId == 24) or
                                          // is Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) or
                                          // is Property Category is Parking(categoryListId == 88) or
                                          // is Property Category is Allotment(categoryListId == 100) then
                                          // Hide Storage Room
                                          controller.categoryListId == 24 ||
                                                  controller.categoryListId ==
                                                      28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84 ||
                                                  controller.categoryListId ==
                                                      88 ||
                                                  controller.categoryListId ==
                                                      100
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: storageRoom,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Fire Place CheckBox
                                          // If Property Category is Additional(categoryListId == 24) or
                                          // is Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) or
                                          // is Property Category is Parking(categoryListId == 88) or
                                          // is Property Category is Allotment(categoryListId == 100) then
                                          // Hide Fire Place
                                          controller.categoryListId == 24 ||
                                                  controller.categoryListId ==
                                                      28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84 ||
                                                  controller.categoryListId ==
                                                      88 ||
                                                  controller.categoryListId ==
                                                      100
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: firePlace,
                                                    ),
                                                    marginHeight(28),
                                                  ],
                                                ),
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          equipment)!,
                                      style: textStyle(
                                        fontSize: 18,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(28),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          certificateNO)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field Certificate No
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      certificateNO)!,
                                  TextInputType.text,
                                  controller.certificateNumberController,
                                ),
                                marginHeight(20),
                                // Energy-efficient construction CheckBox
                                AdCheckBox(
                                  name: energy,
                                ),
                                marginHeight(20),
                                // Minergie Certified CheckBox
                                AdCheckBox(
                                  name: minergie,
                                ),
                                marginHeight(20),
                                // If Property Category is Allotment(categoryListId == 101) only then
                                // Show Sewage connection,Electricity supply, aand Gas supply
                                controller.categoryListId == 101
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            // Sewage connection CheckBox
                                            AdCheckBox(
                                              name: sewageConnection,
                                            ),
                                            marginHeight(20),
                                            // Electricity supply CheckBox
                                            AdCheckBox(
                                              name: electricitySupply,
                                            ),
                                            marginHeight(20),
                                            // Gas supply CheckBox
                                            AdCheckBox(
                                              name: gasSupply,
                                            ),
                                            marginHeight(20),
                                          ])
                                    : const SizedBox(),
                                // Steam Oven CheckBox
                                // If Property Category is Additional(categoryListId == 24) or
                                // is Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) or
                                // is Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Steam Oven
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
                                          AdCheckBox(
                                            name: steamOven,
                                          ),
                                          marginHeight(20),
                                        ],
                                      ),
                                // Dishwasher CheckBox
                                // If Property Category is Additional(categoryListId == 24) or
                                // is Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) or
                                // is Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Dishwasher
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
                                          AdCheckBox(
                                            name: dishwasher,
                                          ),
                                          marginHeight(20),
                                        ],
                                      ),
                                // Own tumble dryer CheckBox
                                // If Property Category is House(categoryListId == 12) or
                                // is Property Category is Multi Family Residential(categoryListId == 23) or
                                // is Property Category is Additional(categoryListId == 24) or
                                // is Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) or
                                // is Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Own Dumbke Dryer
                                controller.categoryListId == 12 ||
                                        controller.categoryListId == 23 ||
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
                                          AdCheckBox(
                                            name: ownDryer,
                                          ),
                                          marginHeight(20),
                                        ],
                                      ),
                                // Own Washing Machine CheckBox
                                // If Property Category is House(categoryListId == 12) or
                                // is Property Category is Multi Family Residential(categoryListId == 23) or
                                // is Property Category is Additional(categoryListId == 24) or
                                // is Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) or
                                // is Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Own Washing Mashine
                                controller.categoryListId == 12 ||
                                        controller.categoryListId == 23 ||
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
                                          AdCheckBox(
                                            name: ownWashingMachine,
                                          ),
                                          marginHeight(20),
                                        ],
                                      ),
                                // Cable Tv Connection CheckBox
                                // If Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Cable TV Connecti0n
                                controller.categoryListId == 88 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : AdCheckBox(
                                        name: cableTV,
                                      ),
                                // If Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) then
                                // Show Water supply, Lifting capacity of crain,
                                // Loading capacity of Goods lift, Floor load capacity, and
                                // Lifting platform
                                controller.categoryListId == 28 ||
                                        controller.categoryListId == 46 ||
                                        controller.categoryListId == 84
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          marginHeight(20),
                                          // Water Supply CheckBox
                                          AdCheckBox(
                                            name: waterSupply,
                                          ),
                                          marginHeight(20),
                                          // Text Lifting capacity of the crane (kg)
                                          Text(
                                            '${translate(context, language.languageCode, liftingCapacityOfTheCrane)!} (kg)',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          CustomInputFormField(
                                            '',
                                            const TextInputType
                                                .numberWithOptions(),
                                            controller
                                                .liftingCapacityOfTheCraneController,
                                          ),
                                          marginHeight(20),
                                          // Text Loading capacity of the goods lift (kg)
                                          Text(
                                            '${translate(context, language.languageCode, loadingCapacityOfTheGoodsLift)!} (kg)',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          CustomInputFormField(
                                            '',
                                            const TextInputType
                                                .numberWithOptions(),
                                            controller
                                                .loadingCapacityOfTheGoodsLiftController,
                                          ),
                                          marginHeight(20),
                                          // Text floor load capacity (kg/m²)
                                          Text(
                                            '${translate(context, language.languageCode, floorLoadCapacity)!} (kg/m²)',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          CustomInputFormField(
                                            '',
                                            const TextInputType
                                                .numberWithOptions(),
                                            controller
                                                .floorLoadCapacityController,
                                          ),
                                          marginHeight(20),
                                          // Lifting platform Check Box
                                          AdCheckBox(
                                            name: liftingPlatform,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                marginHeight(28),
                                // If Property Category is Parking(categoryListId == 88) then
                                // Hide entire Exterior View
                                controller.categoryListId == 88
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                exterior)!,
                                            style: textStyle(
                                              fontSize: 18,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(28),
                                          // Lift CheckBox
                                          // If Property Category is Plot(categoryListId == 101) then
                                          // Hide Lift
                                          controller.categoryListId == 101
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: lift,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Balcony/taerrace/patio CheckBox
                                          // If Property Category is Plot(categoryListId == 101) then
                                          // Hide Balcony/taerrace/patio
                                          controller.categoryListId == 101
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: balcony,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Child Friendly CheckBox
                                          AdCheckBox(
                                            name: childFriendly,
                                          ),
                                          marginHeight(20),
                                          // Play Ground CheckBox
                                          // If Property Category is Additional(categoryListId == 24) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) or
                                          // is Property Category is Allotment(categoryListId == 100) or
                                          // is Property Category is Plot(categoryListId == 101) then
                                          // Hide Play Ground
                                          controller.categoryListId == 24 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84 ||
                                                  controller.categoryListId ==
                                                      100 ||
                                                  controller.categoryListId ==
                                                      101
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: playGround,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Parking Space CheckBox
                                          // If Property Category is Plot(categoryListId == 101) then
                                          // Hide Parking Spac
                                          controller.categoryListId == 101
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AdCheckBox(
                                                      name: parkingSpace,
                                                    ),
                                                    marginHeight(20),
                                                  ],
                                                ),
                                          // Garage CheckBox
                                          // If Property Category is Plot(categoryListId == 101) then
                                          // Hide Garage
                                          controller.categoryListId == 101
                                              ? const SizedBox()
                                              : AdCheckBox(
                                                  name: garage,
                                                ),
                                          // Loading Ramp CheckBox
                                          // If Property Category is Gastronomy(categoryListId == 28) or
                                          // is Property Category is commercial(categoryListId == 46) or
                                          // is Property Category is Agriculture(categoryListId == 84) then
                                          // Show Loading Ramp
                                          controller.categoryListId == 28 ||
                                                  controller.categoryListId ==
                                                      46 ||
                                                  controller.categoryListId ==
                                                      84
                                              ? Column(
                                                  children: [
                                                    marginHeight(20),
                                                    AdCheckBox(
                                                      name: loadingRamp,
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          marginHeight(28),
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          surroundings)!,
                                      style: textStyle(
                                        fontSize: 18,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(28),
                                // If Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Shops, Kindergarten, Primery School and Secondary school distance
                                controller.categoryListId == 88 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translate(context,
                                                language.languageCode, shops)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Text Field Shops Distance
                                          CustomInputFormField(
                                            '',
                                            TextInputType.number,
                                            controller.shopsController,
                                          ),
                                          marginHeight(19),
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                kindergarten)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Text Field Kindergarten Distance
                                          CustomInputFormField(
                                            '',
                                            TextInputType.number,
                                            controller.kindergartenController,
                                          ),
                                          marginHeight(19),
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                primearySchool)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Text Field Primary School Distance
                                          CustomInputFormField(
                                            '',
                                            TextInputType.number,
                                            controller.primarySchoolController,
                                          ),
                                          marginHeight(19),
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                secondarySchool)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Text Field Secondary School Distance
                                          CustomInputFormField(
                                            '',
                                            TextInputType.number,
                                            controller
                                                .secondarySchoolController,
                                          ),
                                          marginHeight(19),
                                        ],
                                      ),
                                // Railway siding CheckBox
                                // If Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) then
                                // Show Railway siding
                                controller.categoryListId == 28 ||
                                        controller.categoryListId == 46 ||
                                        controller.categoryListId == 84
                                    ? Column(
                                        children: [
                                          AdCheckBox(
                                            name: railwaySiding,
                                          ),
                                          marginHeight(19),
                                        ],
                                      )
                                    : const SizedBox(),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          publicTransport)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field Public Transport Distance
                                CustomInputFormField(
                                  '',
                                  TextInputType.number,
                                  controller.publicTransportController,
                                ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          motorway)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field Motorway Distance
                                CustomInputFormField(
                                  '',
                                  TextInputType.number,
                                  controller.motorwayController,
                                ),
                                // Text Field Location
                                // If Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Location
                                controller.categoryListId == 100 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          marginHeight(19),
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                location)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          CustomInputFormField(
                                            '',
                                            TextInputType.text,
                                            controller.locationController,
                                          ),
                                        ],
                                      ),
                                marginHeight(28),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          otherFeatures)!,
                                      style: textStyle(
                                        fontSize: 18,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(28),
                                // New Building / First-time Occupancy CheckBox
                                // Other features Radio list
                                RadioList(
                                  controller.otherFeatureRadioList,
                                  fontSize: 14,
                                  isLeftSideRadio: true,
                                  currentIndex: controller
                                      .currentIndexOtherFeatureRadioList,
                                ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          renovationyear)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field Last Year Renovated
                                CustomInputFormField(
                                  '',
                                  const TextInputType.numberWithOptions(),
                                  controller.renovatedYearController,
                                ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          constructionYear)!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field Construction Year
                                CustomInputFormField(
                                  '',
                                  const TextInputType.numberWithOptions(),
                                  controller.constructionYearController,
                                ),
                                marginHeight(20),
                                // House / Flat Share CheckBox
                                // If Property Category is House(categoryListId == 12) or
                                // is Property Category is Multi Family Residential(categoryListId == 23) or
                                // is Property Category is Additional(categoryListId == 24) or
                                // is Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) or
                                // is Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide House/ Share
                                controller.categoryListId == 12 ||
                                        controller.categoryListId == 23 ||
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
                                          AdCheckBox(
                                            name: houseOrFlatShare,
                                          ),
                                          marginHeight(20),
                                        ],
                                      ),
                                // Leasehold CheckBox
                                // If Property Category is Additional(categoryListId == 24) or
                                // is Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is commercial(categoryListId == 46) or
                                // is Property Category is Agriculture(categoryListId == 84) or
                                // is Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Lease Hold
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
                                          AdCheckBox(
                                            name: leaseHold,
                                          ),
                                          marginHeight(20),
                                        ],
                                      ),
                                // Swimming Pool CheckBox
                                // If Property Category is Additional(categoryListId == 24) or
                                // is Property Category is Gastronomy(categoryListId == 28) or
                                // is Property Category is Agriculture(categoryListId == 84) or
                                // is Property Category is Parking(categoryListId == 88) or
                                // is Property Category is Allotment(categoryListId == 100) or
                                // is Property Category is Plot(categoryListId == 101) then
                                // Hide Swimming pool
                                controller.categoryListId == 24 ||
                                        controller.categoryListId == 28 ||
                                        controller.categoryListId == 84 ||
                                        controller.categoryListId == 88 ||
                                        controller.categoryListId == 100 ||
                                        controller.categoryListId == 101
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AdCheckBox(
                                            name: swimmingPool,
                                          ),
                                        ],
                                      ),
                                marginHeight(20),
                                // Corner house/end-of-terrace house & Mid-terrace house CheckBox
                                // If Property Category is House(categoryListId == 12) or
                                // is Property Category is Multi Family Residential(categoryListId == 23) then
                                // Show Corner house/end-of-terrace & Mid-terrace house
                                controller.categoryListId == 12 ||
                                        controller.categoryListId == 23
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AdCheckBox(
                                            name: corneHouse,
                                          ),
                                          marginHeight(20),
                                          AdCheckBox(
                                            name: midTerraceHouse,
                                          ),
                                          marginHeight(20),
                                        ],
                                      )
                                    : const SizedBox(),
                                // Covered Check Box
                                // If Property Category is Parking(categoryListId == 88) then
                                // Show Covered
                                controller.categoryListId == 88
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AdCheckBox(
                                            name: covered,
                                          ),
                                          marginHeight(20),
                                        ],
                                      )
                                    : const SizedBox(),
                                // Garden Hut Check Box
                                // If Property Category is Allotment(categoryListId == 100) then
                                // Show Garden Hut
                                controller.categoryListId == 100
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AdCheckBox(
                                            name: gardenHut,
                                          ),
                                          marginHeight(20),
                                        ],
                                      )
                                    : const SizedBox(),
                                // Developed Check Box
                                // is Property Category is Plot(categoryListId == 101) then
                                // Show Developed
                                controller.categoryListId == 101
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AdCheckBox(
                                            name: developed,
                                          ),
                                          marginHeight(20),
                                        ],
                                      )
                                    : const SizedBox(),

                                // Bottom Padding
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
                            context, language.languageCode, imagesVideosPDFs)!,
                        rightButtonName: translate(
                            context, language.languageCode, saveNext)!,
                        leftButtonName:
                            translate(context, language.languageCode, back)!,
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
