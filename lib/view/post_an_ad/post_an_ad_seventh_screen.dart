import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/radio_list.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../../utils/style.dart';
import '../widgets/input_field.dart';
import 'components/ad_steps_details.dart';
import 'components/ads_app_bar.dart';
import '../widgets/ads_bottom_buttons.dart';

class FinishindDetails extends StatelessWidget {
  const FinishindDetails({super.key});

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
            screen: publish,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AdsStepsDetails(
                                    steps: 6,
                                    stepTitle: translate(context,
                                        language.languageCode, finish)!,
                                    stepDescription: ''),
                                marginHeight(28),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          finish)!,
                                      style: textStyle(
                                        fontSize: 18,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            finishDetails)!,
                                        style: textStyle(
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(22),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          contactDetails)!,
                                      style: textStyle(
                                        fontSize: 18,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                RadioList(
                                  controller.contactFormListPage7,
                                  isLeftSideRadio: true,
                                  fontSize: 14,
                                  currentIndex: controller
                                      .currentIndexContactFormListPage7,
                                ),
                                marginHeight(19),
                                controller.currentIndexVerticalRadioListPage5 ==
                                        2
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translate(context, language.languageCode, emailAddress)!} *',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),

                                          marginHeight(8),
                                          // Text Field Email Address
                                          CustomInputFormField(
                                            translate(
                                                context,
                                                language.languageCode,
                                                hintEmail)!,
                                            TextInputType.emailAddress,
                                            controller.emailController,
                                            isReadOnly: true,
                                            backGroundColor: greyShadow,
                                            isFilled: true,
                                          ),
                                        ],
                                      ),
                                controller.currentIndexVerticalRadioListPage5 ==
                                        0
                                    ? marginHeight(19)
                                    : const SizedBox(),
                                controller.currentIndexVerticalRadioListPage5 ==
                                        1
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${translate(context, language.languageCode, telephoneNo)!} *",
                                            style: textStyle(
                                              fontSize: 12,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          // Text Field Telephone Number
                                          CustomInputFormField(
                                            translate(
                                                context,
                                                language.languageCode,
                                                telephoneNoHint)!,
                                            TextInputType.phone,
                                            controller.telephoneController,
                                            isReadOnly: true,
                                            backGroundColor: greyShadow,
                                            isFilled: true,
                                          ),
                                        ],
                                      ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      '${translate(context, language.languageCode, contactPerson)!} *',
                                      style: textStyle(
                                        fontSize: 12,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                // Text Field Contact Person
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      contactPersonHint)!,
                                  TextInputType.text,
                                  controller.contactPersonController,
                                  isReadOnly: true,
                                  backGroundColor: greyShadow,
                                  isFilled: true,
                                ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          comments)!,
                                      style: textStyle(
                                        fontSize: 12,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(8),
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      anyComment)!,
                                  TextInputType.text,
                                  controller.commentController,
                                  lines: 5,
                                  isReadOnly: true,
                                  backGroundColor: greyShadow,
                                  isFilled: true,
                                ),
                                controller.isSubscriptionPackegeSelected
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          marginHeight(22),
                                          Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                subscriptionDetails)!,
                                            style: textStyle(
                                              fontSize: 18,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                          marginHeight(8),
                                          RadioList(
                                            controller.standardListPage7,
                                            isLeftSideRadio: true,
                                            fontSize: 14,
                                            currentIndex: controller
                                                .currentIndexStandardListPage7,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

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
                            translate(context, language.languageCode, publish)!,
                        rightButtonName:
                            translate(context, language.languageCode, publish)!,
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
