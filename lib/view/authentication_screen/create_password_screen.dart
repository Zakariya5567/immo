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

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/authentication_provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/images.dart';
import 'components/language_text_button.dart';

// ignore: must_be_immutable
class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: whiteStatusBar(),
      child: WillPopScope(
        onWillPop: () {
          authProvider.createScreenPasswordController.clear();
          authProvider.setIsSecureDefault();
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
                    authProvider.createScreenPasswordController.clear();
                    authProvider.setIsSecureDefault();
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
                                      language.languageCode, createPassword)!,
                                  description: translate(context,
                                      language.languageCode, description2)!,
                                  iconColor: blackPrimary,
                                ),
                                HeightSizedBox(height: 0.08),
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
                                  controller:
                                      controller.createScreenPasswordController,
                                  hintText: translate(context,
                                      language.languageCode, hintPassword)!,
                                  icon: Icons.lock_open,
                                  borderColor: bluePrimary,
                                  backgroundColor: whitePrimary,
                                ),
                                HeightSizedBox(height: 0.02),
                                Container(
                                  height: displayHeight(context) * 0.09,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      color: blueLight,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      "${translate(context, language.languageCode, hintRegexPassword)!} ! @ # \$ % ^ & *)",
                                      textAlign: TextAlign.start,
                                      style: textStyle(
                                          fontSize: 12,
                                          color: blackLight,
                                          fontFamily: satoshiItalic),
                                    ),
                                  ),
                                ),
                                HeightSizedBox(height: 0.10),
                                CustomBuildButton(
                                    buttonName: translate(context,
                                        language.languageCode, createAccount)!,
                                    buttonColor:
                                        controller.isCreateScreenPasswordValid ==
                                                false
                                            ? blueLight
                                            : bluePrimary,
                                    buttonTextColor: whitePrimary,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        if (controller.isSignInPasswordValid == true ||
                                            controller.isSignUpPasswordValid ==
                                                true ||
                                            controller
                                                    .isCreateScreenPasswordValid ==
                                                true) {
                                          await controller.signUp(
                                              context,
                                              RouterHelper
                                                  .createPasswordScreen);
                                        }
                                        if (controller.signupModel.error ==
                                            false) {
                                          Future.delayed(Duration.zero, () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    RouterHelper.emailSignInScreen);
                                            // customSnackBar(
                                            //     context,
                                            //     accountCreatedSignIn,
                                            //     0);
                                            controller.clearTextField();
                                          });
                                        }
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
                                        Navigator.of(context).pushNamed(
                                            RouterHelper.emailSignInScreen);
                                      },
                                    ),
                                  ],
                                ),
                                HeightSizedBox(height: 0.25),
                                LanguageTextButton(formKey: formKey,),
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
      ),
    );
  }
}
