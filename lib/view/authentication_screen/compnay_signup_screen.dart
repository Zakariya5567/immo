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
class CompanySignUpScreen extends StatelessWidget {
  CompanySignUpScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: whiteStatusBar(),
        child: WillPopScope(
          onWillPop: () {
            authProvider.resetIsCompanySignUp();
            authProvider.createScreenPasswordController.clear();
            return Future.value(true);
          },
          child: SafeArea(
            top: Platform.isAndroid ? true : false,
            bottom: Platform.isAndroid ? true : false,
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: whitePrimary,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      authProvider.companyNameController.clear();
                      authProvider.companyEmailController.clear();
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
                                  HeightSizedBox(height: 0.06),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            companyName)!,
                                        style: textStyle(
                                            fontSize: 12,
                                            color: blackLight,
                                            fontFamily: satoshiMedium)),
                                  ),
                                  HeightSizedBox(height: 0.02),
                                  AuthenticationTextField(
                                    controller:
                                        controller.companyNameController,
                                    hintText: translate(
                                        context,
                                        language.languageCode,
                                        hintCompanyName)!,
                                    icon: Icons.person_outline,
                                    borderColor: bluePrimary,
                                    backgroundColor: whitePrimary,
                                  ),
                                  HeightSizedBox(height: 0.03),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            emailAddress)!,
                                        style: textStyle(
                                            fontSize: 12,
                                            color: blackLight,
                                            fontFamily: satoshiMedium)),
                                  ),
                                  HeightSizedBox(height: 0.02),
                                  AuthenticationTextField(
                                    controller:
                                        controller.companyEmailController,
                                    hintText: translate(context,
                                        language.languageCode, hintEmail)!,
                                    icon: Icons.email_outlined,
                                    borderColor: bluePrimary,
                                    backgroundColor: whitePrimary,
                                  ),
                                  HeightSizedBox(height: 0.06),
                                  HeightSizedBox(height: 0.06),
                                  CustomBuildButton(
                                      buttonName: translate(
                                          context,
                                          language.languageCode,
                                          signUpIndividual)!,
                                      buttonColor: whitePrimary,
                                      buttonTextColor: bluePrimary,
                                      onPressed: () {
                                        controller.setSignUpEmail();
                                        Navigator.of(context)
                                            .pushReplacementNamed(RouterHelper
                                                .individualSignUpScreen);
                                      }),
                                  CustomBuildButton(
                                    buttonName: translate(context,
                                        language.languageCode, createPassword)!,
                                    buttonColor: bluePrimary,
                                    buttonTextColor: whitePrimary,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate() &&
                                          controller
                                              .isCompanySignUpEmailValid &&
                                          controller.companyNameController.text
                                              .isNotEmpty) {
                                        Future.delayed(Duration.zero, () {
                                          Navigator.pushNamed(
                                              context,
                                              RouterHelper
                                                  .createPasswordScreen);
                                        });
                                      }
                                    },
                                  ),
                                  HeightSizedBox(height: 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        translate(
                                            context,
                                            language.languageCode,
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
                                          Navigator.of(context).pushNamed(
                                              RouterHelper.emailSignInScreen);
                                          controller.companyNameController
                                              .clear();
                                          controller.companyEmailController
                                              .clear();
                                        },
                                      ),
                                    ],
                                  ),
                                  HeightSizedBox(height: 0.12),
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
                },
              ),
            ),
          ),
        ));
  }
}
