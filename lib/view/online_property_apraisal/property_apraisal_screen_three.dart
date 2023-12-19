import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/radio_list.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/property_apraisal_provider.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../../utils/style.dart';
import '../widgets/ads_bottom_buttons.dart';
import 'components/appraisal_app_bar.dart';
import 'components/appraisal_step_bar.dart';

class OtherPropertyDetails extends StatelessWidget {
  const OtherPropertyDetails({super.key});

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
                                steps: '3',
                              ),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(
                                        context, language.languageCode, other)!,
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
                                  SizedBox(
                                    width: setWidgetWidth(380),
                                    child: Text(
                                      translate(context, language.languageCode,
                                          onlineAppraisalDetail2)!,
                                      overflow: TextOverflow.clip,
                                      style: textStyle(
                                        fontSize: 12,
                                        color: blackPrimary,
                                        fontFamily: satoshiBold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(24),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: RadioList(
                                  controller.verticalRadioList1,
                                  fontSize: 14,
                                  isLeftSideRadio: true,
                                  heightSpace: 50,
                                  currentIndex:
                                      controller.currentIndexVerticalRadioList1,
                                ),
                              ),
                              marginHeight(29),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,
                                        onlineAppraisalDetail3)!,
                                    style: textStyle(
                                      fontSize: 12,
                                      color: blackPrimary,
                                      fontFamily: satoshiBold,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(24),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: RadioList(
                                  controller.verticalRadioList2,
                                  fontSize: 14,
                                  isLeftSideRadio: true,
                                  heightSpace: 50,
                                  currentIndex:
                                      controller.currentIndexVerticalRadioList2,
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
                        screen:
                            translate(context, language.languageCode, other)!,
                        rightButtonName: translate(
                            context, language.languageCode, nextText)!,
                        leftButtonName:
                            translate(context, language.languageCode, back)!,
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
