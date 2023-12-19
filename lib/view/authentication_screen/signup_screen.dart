import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/authentication_screen/components/custom_build_button.dart';
import 'package:immo/view/authentication_screen/components/title_section.dart';
import 'package:immo/view/widgets/authentication_textField.dart';
import 'package:immo/view/widgets/sizedbox_height.dart';
import 'package:provider/provider.dart';

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/authentication_provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/images.dart';
import '../../utils/size.dart';
import 'components/language_text_button.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: whiteStatusBar(),
        child: SafeArea(
          top: Platform.isAndroid ? true : false,
          bottom: Platform.isAndroid ? true : false,
          child: WillPopScope(
            onWillPop: () {
              authProvider.resetIsCompanySignUp();
              authProvider.signUpNameController.clear();
              authProvider.signUpEmailController.clear();
              return Future.value(true);
            },
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: whitePrimary,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      authProvider.createScreenPasswordController.clear();
                    },
                    icon: const ImageIcon(
                      AssetImage(Images.arrowBackIcon),
                      color: blackPrimary,
                      size: 23,
                    ),
                  )),
              backgroundColor: whitePrimary,
              body: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                return Consumer<AuthProvider>(
                  builder: (context, controller, child) {
                    return SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: setWidgetWidth(30),
                            ),
                            child: Column(
                              children: [
                                TitleSection(
                                  title: translate(context,
                                      language.languageCode, createAccount)!,
                                  description: translate(context,
                                      language.languageCode, description2)!,
                                  iconColor: blackPrimary,
                                ),
                                HeightSizedBox(height: 0.05),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    translate(context, language.languageCode,
                                        userNameValue)!,
                                    style: textStyle(
                                        fontSize: 12,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ),
                                ),
                                HeightSizedBox(height: 0.02),
                                AuthenticationTextField(
                                  controller: controller.signUpNameController,
                                  hintText: translate(context,
                                      language.languageCode, hintUserName)!,
                                  icon: Icons.person_outline,
                                  borderColor: bluePrimary,
                                  backgroundColor: whitePrimary,
                                ),
                                HeightSizedBox(height: 0.03),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    translate(context, language.languageCode,
                                        emailAddress)!,
                                    style: textStyle(
                                        fontSize: 12,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ),
                                ),
                                HeightSizedBox(height: 0.02),
                                AuthenticationTextField(
                                  controller: controller.signUpEmailController,
                                  hintText: translate(context,
                                      language.languageCode, hintEmail)!,
                                  icon: Icons.email_outlined,
                                  borderColor: greyShadow,
                                  backgroundColor: greyShadow,
                                ),
                                HeightSizedBox(height: 0.06),
                                HeightSizedBox(height: 0.06),
                                CustomBuildButton(
                                    buttonName: translate(context,
                                        language.languageCode, signUpCompany)!,
                                    buttonColor: whitePrimary,
                                    buttonTextColor: bluePrimary,
                                    onPressed: () {
                                      controller.setCompanySignUpEmail();
                                      // controller.clearSignUpScreen();
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              RouterHelper.companySignUpScreen);
                                    }),
                                CustomBuildButton(
                                    buttonName: translate(context,
                                        language.languageCode, createPassword)!,
                                    buttonColor:
                                        controller.isSignUpEmailValid &&
                                                controller.signUpNameController
                                                    .text.isNotEmpty
                                            ? bluePrimary
                                            : blueLight,
                                    buttonTextColor: whitePrimary,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate() &&
                                          controller.isSignUpEmailValid &&
                                          controller.signUpNameController.text
                                              .isNotEmpty) {
                                        Future.delayed(Duration.zero, () {
                                          Navigator.pushNamed(
                                              context,
                                              RouterHelper
                                                  .createPasswordScreen);
                                        });
                                      }
                                    }),
                                HeightSizedBox(height: 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          alreadySignUp)!,
                                      style: textStyle(
                                          fontSize: 14,
                                          color: blackLight,
                                          fontFamily: satoshiRegular),
                                    ),
                                    TextButton(
                                      child: Text(
                                        translate(context,
                                            language.languageCode, signIn)!,
                                        style: textStyle(
                                            fontSize: 14,
                                            color: bluePrimary,
                                            fontFamily: satoshiMedium),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                RouterHelper.emailSignInScreen);
                                        controller.signUpNameController.clear();
                                        controller.signUpEmailController
                                            .clear();
                                      },
                                    ),
                                  ],
                                ),
                                HeightSizedBox(height: 0.04),
                                LanguageTextButton(
                                  formKey: formKey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ));
  }
}
