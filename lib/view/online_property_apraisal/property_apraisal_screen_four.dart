// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/property_apraisal_provider.dart';
import '../../utils/app_constant.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../widgets/ads_bottom_buttons.dart';
import '../widgets/custom_telephone_field.dart';
import '../widgets/input_field.dart';
import 'components/appraisal_app_bar.dart';
import 'components/appraisal_step_bar.dart';

class YourContactDetails extends StatefulWidget {
  const YourContactDetails({super.key});

  @override
  State<YourContactDetails> createState() => _YourContactDetailsState();
}

class _YourContactDetailsState extends State<YourContactDetails> {
  @override
  void initState() {
    super.initState();
    setEmailField();
  }

  setEmailField() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final propertyAppraisalProvider =
        Provider.of<PropertyAppraisalProvider>(context, listen: false);
    propertyAppraisalProvider.emailController.text =
        sharedPreferences.getString(AppConstant.userEmail)!;
    propertyAppraisalProvider.firstAndLastNameController.text =
        sharedPreferences.getString(AppConstant.userName)!;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppraisalAppBar(
            appBar: AppBar(),
          ),
          body: Consumer<PropertyAppraisalProvider>(
            builder: (context, controller, child) {
              return Consumer<LanguageProvider>(
                builder: (context, language, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.currentStep == 5
                                  ? const AppraisalStepBar(
                                      steps: '5',
                                    )
                                  : const AppraisalStepBar(
                                      steps: '4',
                                    ),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,
                                        yourContactDetails)!,
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
                                    translate(context, language.languageCode,
                                        firstAndLastName)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of First & last Name
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  '',
                                  TextInputType.text,
                                  controller.firstAndLastNameController,
                                ),
                              ),
                              marginHeight(19),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,
                                        emailAddress)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Email Address
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomInputFormField(
                                  '',
                                  TextInputType.text,
                                  controller.emailController,
                                  backGroundColor: greyShadow,
                                  isReadOnly: true,
                                  isFilled: true,
                                ),
                              ),
                              marginHeight(19),
                              Row(
                                children: [
                                  marginWidth(30),
                                  Text(
                                    translate(context, language.languageCode,
                                        mobileNumber)!,
                                    style: textStyle(
                                      fontSize: 10,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ],
                              ),
                              marginHeight(8),
                              // Text Field of Mobile Number
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: CustomPhoneFormField(
                                  '',
                                  controller.mobileNumberController,
                                ),
                              ),
                              marginHeight(19),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: setWidgetWidth(30),
                                  right: setWidgetWidth(30),
                                ),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    text: translate(
                                        context,
                                        language.languageCode,
                                        alertPolicyMessage)!,
                                    style: textStyle(
                                        fontSize: 12,
                                        color: blackPrimary,
                                        fontFamily: satoshiRegular),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "${translate(context, language.languageCode, privacyPolicy)!}.",
                                          style: textStyle(
                                              fontSize: 12,
                                              color: bluePrimary,
                                              fontFamily: satoshiRegular)),
                                    ],
                                  ),
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
                            yourContactDetails)!,
                        rightButtonName: translate(
                            context, language.languageCode, requestAppraisal)!,
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
