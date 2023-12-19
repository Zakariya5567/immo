import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/input_field.dart';
import 'package:immo/view/widgets/radio_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';
import '../../utils/app_constant.dart';
import '../../utils/size.dart';
import '../widgets/custom_telephone_field.dart';
import 'components/ad_steps_details.dart';
import 'components/ads_app_bar.dart';
import '../widgets/ads_bottom_buttons.dart';
import 'components/ads_screen_information_title.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({super.key});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  @override
  void initState() {
    setEmail();
    super.initState();
  }

  setEmail() async {
    final postAnAdProvider =
        Provider.of<PostAnAdProvider>(context, listen: false);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    postAnAdProvider.emailController.text =
        sharedPreferences.getString(AppConstant.userEmail)!;
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
            screen: order,
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
                                    steps: 4,
                                    stepTitle: translate(context,
                                        language.languageCode, contacts)!,
                                    stepDescription:
                                        '${translate(context, language.languageCode, nextText)!}: ${translate(context, language.languageCode, order)!}'),
                                marginHeight(28),
                                InformationTitle(
                                    information: translate(
                                        context,
                                        language.languageCode,
                                        contactOptions)!),
                                marginHeight(7),
                                const InformationDetails(),
                                marginHeight(28),
                                // Radio Button of Contact form and Telephone Number
                                // Radio Button of Contact form
                                // Radio Button of Telephone Number
                                RadioList(
                                  controller.verticalRadioListPage5,
                                  fontSize: 14,
                                  isLeftSideRadio: true,
                                  currentIndex: controller
                                      .currentIndexVerticalRadioListPage5,
                                ),
                                marginHeight(28),
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
                                                enterEmailAddress)!,
                                            TextInputType.emailAddress,
                                            controller.emailController,
                                            backGroundColor: greyShadow,
                                            isReadOnly: true,
                                            isFilled: true,
                                          ),
                                          marginHeight(19),
                                        ],
                                      ),
                                controller.currentIndexVerticalRadioListPage5 ==
                                        1
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translate(context, language.languageCode, telephoneNo)!} *',
                                            style: textStyle(
                                              fontSize: 10,
                                              color: blackPrimary,
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),

                                          marginHeight(8),
                                          // Text Field Telephone Number
                                          CustomPhoneFormField(
                                            translate(
                                                context,
                                                language.languageCode,
                                                telephoneNoHint)!,
                                            controller.telephoneController,
                                          ),
                                          marginHeight(19),
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Text(
                                      '${translate(context, language.languageCode, contactPerson)!} *',
                                      style: textStyle(
                                        fontSize: 10,
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
                                ),
                                marginHeight(19),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          comments)!,
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
                                  controller.commentController,
                                  lines: 5,
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
                            translate(context, language.languageCode, order)!,
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
