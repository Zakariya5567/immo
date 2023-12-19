import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/authentication_screen/components/custom_build_button.dart';
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
class PasswordScreen extends StatelessWidget {
  PasswordScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: whiteStatusBar(),
      child: Consumer<AuthProvider>(
        builder: (context, controller, child) {
          return SafeArea(
            top: Platform.isAndroid ? true : false,
            bottom: Platform.isAndroid ? true : false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: whitePrimary,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller.createScreenPasswordController.clear();
                  },
                  icon: const ImageIcon(
                    AssetImage(Images.arrowBackIcon),
                    color: blackPrimary,
                    size: 23,
                  ),
                ),
              ),
              backgroundColor: whitePrimary,
              body: Consumer<LanguageProvider>(
                builder: (context, language, child) {
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
                              HeightSizedBox(height: 0.03),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  translate(context, language.languageCode,
                                      password)!,
                                  style: textStyle(
                                      fontSize: 12,
                                      color: blackLight,
                                      fontFamily: satoshiMedium),
                                ),
                              ),
                              HeightSizedBox(height: 0.02),
                              AuthenticationTextField(
                                controller: controller.signInPasswordController,
                                hintText: translate(context,
                                    language.languageCode, hintPassword)!,
                                icon: Icons.lock_open,
                                borderColor: greyShadow,
                                backgroundColor: greyShadow,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          RouterHelper.forgotPasswordScreen);
                                    },
                                    child: Text(
                                      "${translate(context, language.languageCode, forgotPassword)!} ?",
                                      style: textStyle(
                                          fontSize: 14,
                                          color: bluePrimary,
                                          fontFamily: satoshiMedium),
                                    )),
                              ),
                              HeightSizedBox(height: 0.2),
                              CustomBuildButton(
                                buttonName: translate(
                                    context, language.languageCode, loginText)!,
                                buttonColor: bluePrimary,
                                buttonTextColor: whitePrimary,
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (controller.signInPasswordController.text
                                        .isNotEmpty) {
                                      await controller.login(
                                          context, RouterHelper.passwordScreen);
                                    }
                                    if (controller.loginModel.error == false) {
                                      Future.delayed(Duration.zero, () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                RouterHelper.homeScreen,
                                                (route) => false);
                                        controller.clearTextField();
                                      });
                                    }
                                  }
                                },
                              ),
                              HeightSizedBox(height: 0.4),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
