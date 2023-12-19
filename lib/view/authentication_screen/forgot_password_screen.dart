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

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
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
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: setWidgetWidth(30),),
                        child: Column(
                          children: [
                            TitleSection(
                              title: translate(context, language.languageCode,
                                  forgotPassword)!,
                              description: translate(context,
                                  language.languageCode, description5)!,
                              iconColor: blackPrimary,
                            ),
                            HeightSizedBox(height: 0.08),
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
                              controller: controller.forgotEmailController,
                              hintText: translate(
                                  context, language.languageCode, hintEmail)!,
                              icon: Icons.email_outlined,
                              borderColor: bluePrimary,
                              backgroundColor: whitePrimary,
                            ),
                            HeightSizedBox(height: 0.12),
                            CustomBuildButton(
                                buttonName: translate(context,
                                    language.languageCode, resetPassword)!,
                                buttonColor: bluePrimary,
                                buttonTextColor: whitePrimary,
                                onPressed: () async {
                                  if (controller.isForgetEmailValid &&
                                      controller.forgotEmailController.text
                                          .isNotEmpty) {
                                    await controller.forgotPassword(context,
                                        RouterHelper.forgotPasswordScreen);
                                        if (controller.forgotPasswordModel.error ==
                                      false) {
                                    Future.delayed(Duration.zero, () {
                                      Navigator.pushNamed(
                                          context, RouterHelper.emailSignInScreen);
                                      controller.clearTextField();
                                    });
                                  }
                                  }
                                }),
                          ],
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
