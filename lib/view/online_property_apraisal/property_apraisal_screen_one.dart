import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/online_property_apraisal/components/appraisal_step_bar.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/property_apraisal_provider.dart';
import '../../utils/images.dart';
import '../widgets/ads_bottom_buttons.dart';
import '../widgets/input_field.dart';
import 'components/appraisal_app_bar.dart';

class OnlineAppraisalStepOne extends StatefulWidget {
  const OnlineAppraisalStepOne({super.key});

  @override
  State<OnlineAppraisalStepOne> createState() => _OnlineAppraisalStepOneState();
}

class _OnlineAppraisalStepOneState extends State<OnlineAppraisalStepOne> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Consumer<LanguageProvider>(
          builder: (context, language, child) {
            return Scaffold(
              appBar: AppraisalAppBar(
                appBar: AppBar(),
              ),
              body: Consumer<PropertyAppraisalProvider>(
                builder: (context, controller, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppraisalStepBar(
                                steps: '1',
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    marginWidth(30),
                                    Text(
                                      translate(context, language.languageCode,
                                          onlineAppraisalDetail1)!,
                                      overflow: TextOverflow.clip,
                                      style: textStyle(
                                        fontSize: 18,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                    marginWidth(30),
                                  ],
                                ),
                              ),
                              marginHeight(22),
                              Container(
                                margin: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                height: setWidgetHeight(135),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: bluePrimary.withOpacity(0.15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: setWidgetHeight(95),
                                      width: setWidgetHeight(90),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            controller.isHouseSelected == true
                                                ? orangePrimary
                                                : whitePrimary,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                blackPrimary.withOpacity(0.1),
                                            spreadRadius: 4,
                                            blurRadius: 8,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ImageIcon(
                                            const AssetImage(
                                              Images.iconHouse,
                                            ),
                                            size: 33,
                                            color: controller.isHouseSelected ==
                                                    true
                                                ? whitePrimary
                                                : blackPrimary,
                                          ),
                                          Text(
                                            translate(context,
                                                language.languageCode, aHouse)!,
                                            style: textStyle(
                                              fontSize: 10,
                                              color:
                                                  controller.isHouseSelected ==
                                                          true
                                                      ? whitePrimary
                                                      : blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).onPress(() {
                                      controller.setSelectedProperty(true);
                                    }),
                                    Container(
                                      height: setWidgetHeight(95),
                                      width: setWidgetHeight(90),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            controller.isHouseSelected == true
                                                ? whitePrimary
                                                : orangePrimary,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                blackPrimary.withOpacity(0.1),
                                            spreadRadius: 4,
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                            // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ImageIcon(
                                            const AssetImage(
                                              Images.iconAppartment,
                                            ),
                                            size: 33,
                                            color: controller.isHouseSelected ==
                                                    true
                                                ? blackPrimary
                                                : whitePrimary,
                                          ),
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                apartment)!,
                                            textAlign: TextAlign.center,
                                            style: textStyle(
                                              fontSize: 10,
                                              color:
                                                  controller.isHouseSelected ==
                                                          true
                                                      ? blackPrimary
                                                      : whitePrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).onPress(() {
                                      //Appartment Selection
                                      controller.setSelectedProperty(false);
                                    }),
                                  ],
                                ),
                              ),
                              marginHeight(29),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,
                                        postalCodeCity)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Postal code & city
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  "${translate(context, language.languageCode, eg)!} 1234",
                                  TextInputType.text,
                                  controller.postCodeandCityController,
                                ),
                              ),
                              marginHeight(19),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,
                                        streetNumber)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Street & number
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  "${translate(context, language.languageCode, eg)!} 1234",
                                  TextInputType.text,
                                  controller.streetAndHouseNumberController,
                                ),
                              ),
                              //Bottom Padding
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: setWidgetHeight(50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BottomButtons(
                        screen: translate(context, language.languageCode,
                            onlinePropertyAppraisal)!,
                        rightButtonName: translate(
                            context, language.languageCode, nextText)!,
                        leftButtonName:
                            translate(context, language.languageCode, cancel)!,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
