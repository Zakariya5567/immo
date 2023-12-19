// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/helper/provider_strings_helper.dart';
import 'package:immo/provider/contact_form_provider.dart';
import 'package:immo/provider/contact_us_provider.dart';
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
class CustomPhoneFormField extends StatelessWidget {
  String hint;
  TextEditingController controller;

  CustomPhoneFormField(this.hint, this.controller, {super.key});

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
    final userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    final homeProviderProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    final contactFormProvider =
        Provider.of<ContactFormProvider>(context, listen: false);
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return TextFormField(
          autovalidateMode: controller.text.isNotEmpty
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          autofocus: false,
          controller: controller,
          obscureText: false,
          maxLines: 1,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            NumberTextInputFormatter(),
          ],
          validator: (value) {
            if (controller == postAdProvider.telephoneController ||
                controller == contactUsProvider.telePhoneNumberController) {
              return provideKeyToValue(context, language.languageCode,
                  postAdProvider.telephoneValidation(value));
            } else if (controller == appraisalProvider.mobileNumberController) {
              return provideKeyToValue(context, language.languageCode,
                  appraisalProvider.mobileValidation(value));
            } else if (controller ==
                    inquiryFormProvider.phoneNumberController ||
                controller == homeProviderProvider.phoneNumberController ||
                controller == contactFormProvider.phoneNumberController) {
              return provideKeyToValue(context, language.languageCode,
                  inquiryFormProvider.phoneValidation(value));
            } else if (controller ==
                userProfileProvider.phoneNumberController) {
              return provideKeyToValue(context, language.languageCode,
                  userProfileProvider.phoneValidation(value));
            }
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixText: "+41 ",
            prefixStyle: textStyle(
                fontSize: 15, color: blackPrimary, fontFamily: satoshiMedium),
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

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newFormattedValue = _getFormattedValue(newValue.text);
    return TextEditingValue(
      text: newFormattedValue,
      selection: TextSelection.collapsed(offset: newFormattedValue.length),
    );
  }

  String _getFormattedValue(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length <= 2) {
      return digitsOnly;
    } else if (digitsOnly.length <= 5) {
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2)}';
    } else if (digitsOnly.length <= 7) {
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 5)} ${digitsOnly.substring(5)}';
    } else {
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 5)} ${digitsOnly.substring(5, 7)} ${digitsOnly.substring(7)}';
    }
  }
}
