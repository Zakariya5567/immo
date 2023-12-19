// ignore_for_file: body_might_complete_normally_nullable, file_names

import 'package:flutter/material.dart';
import 'package:immo/helper/provider_strings_helper.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/authentication_provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/string.dart';

// ignore: must_be_immutable
class AuthenticationTextField extends StatelessWidget {
  AuthenticationTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.borderColor,
    required this.backgroundColor,
  });

  TextEditingController controller = TextEditingController();
  String hintText;
  IconData icon;
  Color borderColor;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Consumer<LanguageProvider>(
          builder: (context, language, child) {
            return TextFormField(
              autofocus: false,
              controller: controller,
              autovalidateMode: controller.text.isNotEmpty
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 14),
              obscureText: controller == provider.signInPasswordController &&
                          provider.isSecure == true ||
                      controller == provider.signUpPasswordController &&
                          provider.isSecure == true ||
                      controller == provider.createScreenPasswordController &&
                          provider.isSecure == true
                  ? true
                  : false,
              keyboardType: controller == provider.signInEmailController ||
                      controller == provider.signUpEmailController ||
                      controller == provider.companyEmailController ||
                      controller == provider.forgotEmailController
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              onChanged: (value) {},
              validator: (value) {
                if (controller == provider.signUpNameController) {
                  return provideKeyToValue(context, language.languageCode,
                      provider.nameValidation(value));
                } else if (controller == provider.signInEmailController ||
                    controller == provider.signUpEmailController ||
                    controller == provider.companyEmailController ||
                    controller == provider.forgotEmailController) {
                  Future.delayed(Duration.zero, () {
                    provider.getEmailValid();
                  });
                  return provideKeyToValue(context, language.languageCode,
                      provider.emailValidation(value, controller));
                } else if (controller == provider.signInPasswordController ||
                    controller == provider.signUpPasswordController ||
                    controller == provider.createScreenPasswordController) {
                  Future.delayed(Duration.zero, () {
                    provider.getPasswordValid();
                  });
                  return provideKeyToValue(context, language.languageCode,
                      provider.passwordValidation(value, controller));
                } else if (controller == provider.companyNameController) {
                  return provideKeyToValue(context, language.languageCode,
                      provider.companyNameValidation(value));
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                suffixIcon: controller == provider.signInEmailController ||
                        controller == provider.signUpEmailController ||
                        controller == provider.companyEmailController ||
                        controller == provider.forgotEmailController
                    ? Icon(
                        Icons.check_circle,
                        color: controller == provider.signInEmailController &&
                                    provider.isSignInEmailValid == true ||
                                controller == provider.companyEmailController &&
                                    provider.isCompanySignUpEmailValid ==
                                        true ||
                                controller == provider.signUpEmailController &&
                                    provider.isSignUpEmailValid == true ||
                                controller == provider.forgotEmailController &&
                                    provider.isForgetEmailValid == true
                            ? bluePrimary
                            : greyLight,
                      )
                    : controller == provider.signInPasswordController ||
                            controller ==
                                provider.createScreenPasswordController
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: setWidgetHeight(8),
                                horizontal: setWidgetWidth(10)),
                            child: InkWell(
                              onTap: () {
                                provider.setIsSecure();
                              },
                              child: Container(
                                width: language.languageCode == 'en'
                                    ? setWidgetWidth(55)
                                    : setWidgetWidth(80),
                                decoration: BoxDecoration(
                                    color: blueLight,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: bluePrimary)),
                                child: Center(
                                  child: Text(
                                    provider.isSecure == true
                                        ? translate(context,
                                            language.languageCode, show)!
                                        : translate(context,
                                            language.languageCode, hide)!,
                                    style: textStyle(
                                        fontSize: 14,
                                        color: bluePrimary,
                                        fontFamily: satoshiMedium),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),

                //suffix,
                errorStyle: const TextStyle(fontSize: 12),
                fillColor: backgroundColor,
                filled: true,
                hintText: hintText,
                hintStyle: textStyle(
                    fontSize: 14,
                    color: greyPrimary,
                    fontFamily: satoshiRegular),
                contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.022,
                  horizontal: MediaQuery.of(context).size.width * 0.022,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
