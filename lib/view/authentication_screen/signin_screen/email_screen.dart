import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/authentication_screen/components/custom_build_button.dart';
import 'package:immo/view/authentication_screen/components/custom_socail_button.dart';
import 'package:immo/view/authentication_screen/components/title_section.dart';
import 'package:immo/view/widgets/authentication_textField.dart';
import 'package:immo/view/widgets/sizedbox_height.dart';
import 'package:provider/provider.dart';

import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/authentication_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/images.dart';
import '../components/language_text_button.dart';

// ignore: must_be_immutable
class EmailSignInScreen extends StatelessWidget {
  EmailSignInScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: whiteStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: whitePrimary,
            elevation: 0,
          ),
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
                                title: translate(
                                    context, language.languageCode, loginNow)!,
                                description: translate(context,
                                    language.languageCode, description1)!,
                                iconColor: whitePrimary,
                              ),
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
                                controller: controller.signInEmailController,
                                hintText: translate(
                                    context, language.languageCode, hintEmail)!,
                                icon: Icons.email_outlined,
                                borderColor: bluePrimary,
                                backgroundColor: whitePrimary,
                              ),
                              HeightSizedBox(height: 0.25),
                              CustomBuildButton(
                                buttonName: translate(
                                    context, language.languageCode, nextText)!,
                                buttonColor: bluePrimary,
                                buttonTextColor: whitePrimary,
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (controller.signInEmailController.text
                                        .isNotEmpty) {
                                      await controller.isEmailAlreadyExist(
                                          context,
                                          RouterHelper.emailSignInScreen);
                                    }
                                    if (controller
                                            .emailAlreadyExistModel.error ==
                                        false) {
                                      Future.delayed(Duration.zero, () {
                                        controller.setSignUpEmail();
                                        controller.clearUserNamesTextField();
                                        Navigator.of(context).pushNamed(
                                            RouterHelper
                                                .individualSignUpScreen);
                                      });
                                    } else if (controller
                                            .emailAlreadyExistModel.error ==
                                        true) {
                                      Future.delayed(Duration.zero, () {
                                        controller.clearPasswordTextField();
                                        Navigator.of(context).pushNamed(
                                            RouterHelper.passwordScreen);
                                      });
                                    }
                                  }
                                },
                              ),
                              HeightSizedBox(height: 0.06),
                              Text(
                                translate(context, language.languageCode,
                                    youCanConnect)!,
                                style: textStyle(
                                    fontSize: 12,
                                    color: greyLight,
                                    fontFamily: satoshiRegular),
                              ),
                              HeightSizedBox(height: 0.04),
                              SizedBox(
                                width: displayWidth(context) * 0.52,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomSocialButton(
                                        image: Images.googleIcon,
                                        onPressed: () async {
                                          debugPrint("google");
                                          await controller
                                              .socialSignup(
                                                  context,
                                                  "google",
                                                  RouterHelper
                                                      .emailSignInScreen)
                                              .then(
                                            (value) async {
                                              if (controller.socialSignUpModel
                                                      .error ==
                                                  false) {
                                                Future.delayed(
                                                  Duration.zero,
                                                  () {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            RouterHelper
                                                                .homeScreen,
                                                            (route) => false);
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        }),
                                    CustomSocialButton(
                                        image: Images.facebookIcon,
                                        onPressed: () async {
                                          debugPrint("facebook");
                                          await controller
                                              .socialSignup(
                                                  context,
                                                  "facebook",
                                                  RouterHelper
                                                      .emailSignInScreen)
                                              .then(
                                            (value) async {
                                              if (controller.socialSignUpModel
                                                      .error ==
                                                  false) {
                                                Future.delayed(
                                                  Duration.zero,
                                                  () {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            RouterHelper
                                                                .homeScreen,
                                                            (route) => false);
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        }),
                                    CustomSocialButton(
                                        image: Images.appleIcon,
                                        onPressed: () async {
                                          debugPrint("apple");
                                          await controller
                                              .socialSignup(
                                                  context,
                                                  "apple",
                                                  RouterHelper
                                                      .emailSignInScreen)
                                              .then(
                                            (value) async {
                                              if (controller.socialSignUpModel
                                                      .error ==
                                                  false) {
                                                Future.delayed(
                                                  Duration.zero,
                                                  () {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            RouterHelper
                                                                .homeScreen,
                                                            (route) => false);
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        }),
                                  ],
                                ),
                              ),
                              HeightSizedBox(height: 0.24),
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
    );
  }
}
