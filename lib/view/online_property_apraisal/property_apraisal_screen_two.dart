import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/theme.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/property_apraisal_provider.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../widgets/ads_bottom_buttons.dart';
import '../widgets/input_field.dart';
import 'components/appraisal_app_bar.dart';
import 'components/appraisal_step_bar.dart';

TextEditingController controller = TextEditingController();

class InformationPropertyDetails extends StatelessWidget {
  const InformationPropertyDetails({super.key});

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
                                steps: '2',
                              ),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,informationProperty)!,
                                    style: textStyle(
                                      fontSize: 18,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(29),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    '${translate(context, language.languageCode,livingSpace)!} (m²)',
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Living Space
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  '',
                                  TextInputType.number,
                                  controller.livingSpaceController,
                                ),
                              ),
                              marginHeight(19),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,numberOfRooms)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Number of Rooms
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  '',
                                  const TextInputType.numberWithOptions(),
                                  controller.numberOfRoomsController,
                                ),
                              ),
                              marginHeight(19),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,constructionYear)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Construction Year
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  '',
                                  const TextInputType.numberWithOptions(),
                                  controller.constructionYearController,
                                ),
                              ),
                              marginHeight(19),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,renovationyear)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Renovation Year
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  '',
                                  const TextInputType.numberWithOptions(),
                                  controller.renovatedYearController,
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
                        screen: translate(context, language.languageCode,informationProperty)!,
                        rightButtonName: translate(context, language.languageCode,nextText)!,
                        leftButtonName: translate(context, language.languageCode,back)!,
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
