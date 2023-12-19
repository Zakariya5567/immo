// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:immo/helper/provider_strings_helper.dart';
import 'package:immo/provider/contact_form_provider.dart';
import 'package:immo/provider/contact_us_provider.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/provider/inquiry_form_provider.dart';
import 'package:immo/provider/property_apraisal_provider.dart';
import 'package:immo/provider/user_profile_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';

// ignore: must_be_immutable
class CustomInputFormField extends StatelessWidget {
  String hint;
  TextInputType inputType;
  TextEditingController controller;
  int lines;
  bool isReadOnly;
  bool isFilled;
  Color backGroundColor;

  CustomInputFormField(this.hint, this.inputType, this.controller,
      {super.key,
      this.lines = 1,
      this.isReadOnly = false,
      this.backGroundColor = whitePrimary,
      this.isFilled = false});

  @override
  Widget build(BuildContext context) {
    final postAdProvider =
        Provider.of<PostAnAdProvider>(context, listen: false);
    final appraisalProvider =
        Provider.of<PropertyAppraisalProvider>(context, listen: false);
    final inquiryFormProvider =
        Provider.of<InquiryFormProvider>(context, listen: false);
    final contactUsProvider =
        Provider.of<ContactUsProvider>(context, listen: false);
    final filterProvider =
        Provider.of<FilterScreenProvider>(context, listen: false);
    final userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    final homeProviderProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    final contactFormProvider =
        Provider.of<ContactFormProvider>(context, listen: false);
    final homeProvider = Provider.of<HomePageProvider>(context, listen: false);
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return TextFormField(
          readOnly: isReadOnly,
          autovalidateMode: controller.text.isNotEmpty
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          autofocus: false,
          controller: controller,
          obscureText: false,
          maxLines: lines,
          keyboardType: inputType,
          validator: (value) {
            if (controller == postAdProvider.titleOfAdController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.titleValidation(value));
            } else if (controller ==
                postAdProvider.rentIncludeUtilitiesController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.priceValidationIncludeUtilities(value));
            } else if (controller == postAdProvider.sellingPriceController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.priceValidationSelling(value));
            } else if (controller == postAdProvider.utilitiesController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.priceValidationUtilities(value));
            } else if (controller ==
                postAdProvider.rentExcludeUtilitiesController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.priceValidationExcludeUtilities(value));
            } else if (controller == postAdProvider.contactPersonController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.contactPersonValidation(value));
            } else if (controller == postAdProvider.postCodeandCityController ||
                controller == homeProvider.searchCityController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.postcodeAndCityValidation(value));
            } else if (controller == homeProvider.searchCityController) {
              return provideKeyToValue(context, language.languageCode,
                  homeProvider.cityValidation(value));
            } else if (controller == postAdProvider.emailController ||
                controller == appraisalProvider.emailController ||
                controller == inquiryFormProvider.emailController ||
                controller == contactUsProvider.emailController ||
                controller == filterProvider.emailController ||
                controller == userProfileProvider.emailController ||
                controller == homeProviderProvider.emailController ||
                controller == contactFormProvider.emailController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.emailValidation(value));
            }
            else if (controller ==
                    appraisalProvider.firstAndLastNameController ||
                controller == inquiryFormProvider.firstAndLastNameController ||
                controller == contactFormProvider.firstAndLastNameController ||
                controller == homeProviderProvider.firstAndLastNameController) {
              return provideKeyToValue(context, language.languageCode,
                  appraisalProvider.firstAndLastNameValidation(value));
            }
            else if (controller == contactUsProvider.firstNameController) {
              return provideKeyToValue(context, language.languageCode,
                  contactUsProvider.firstNameValidation(value));
            } else if (controller == contactUsProvider.lastNameController) {
              return provideKeyToValue(context, language.languageCode,
                  contactUsProvider.lastNameValidation(value));
            } else if (controller == filterProvider.alertNameController) {
              return provideKeyToValue(context, language.languageCode,
                  filterProvider.alertNameValidation(value));
            } else if (controller == userProfileProvider.userNameController) {
              return provideKeyToValue(context, language.languageCode,
                  userProfileProvider.usernNameValidation(value));
            } else if (controller == postAdProvider.webLinkController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.webLinkValidation(value));
            } else if (controller == postAdProvider.youtubeLink1Controller ||
                controller == postAdProvider.youtubeLink2Controller) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.youTubeLinkValidation(value));
            }
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            fillColor: backGroundColor,
            filled: isFilled,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hint,
            hintStyle: textStyle(
                fontSize: 14, color: greyLight, fontFamily: satoshiRegular),
            contentPadding: EdgeInsets.symmetric(
                horizontal: setWidgetWidth(15), vertical: setWidgetHeight(15)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: greyLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: greyLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: greyLight),
            ),
          ),
        );
      },
    );
  }
}
