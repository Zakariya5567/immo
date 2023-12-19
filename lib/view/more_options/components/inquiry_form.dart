// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:immo/provider/inquiry_form_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/view/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/custom_telephone_field.dart';
import '../../widgets/input_field.dart';

// ignore: must_be_immutable
class InquiryForm extends StatefulWidget {
  VoidCallback onPress;

  InquiryForm(this.onPress, {super.key});

  @override
  State<InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  @override
  void initState() {
    super.initState();
    setEmailField();
  }

  setEmailField() async{
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final filterScreenProvider =
          Provider.of<InquiryFormProvider>(context, listen: false);
      filterScreenProvider.emailController.text =
          sharedPreferences.getString(AppConstant.userEmail)!;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Consumer<InquiryFormProvider>(
            builder: (context, controller, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate(context, language.languageCode,inquiryForm)!,
                        style: textStyle(
                            fontSize: 22,
                            color: blackLight,
                            fontFamily: satoshiBold),
                      ),
                      Image.asset(
                        Images.iconClose,
                        width: setWidgetWidth(24),
                        height: setWidgetHeight(24),
                      ).onPress(
                        () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: setWidgetHeight(34),
                  ),
                  Text(
                    translate(context, language.languageCode,firstAndLastName)!,
                    style: textStyle(
                        fontSize: 10,
                        color: blackLight,
                        fontFamily: satoshiMedium),
                  ),
                  SizedBox(
                    height: setWidgetHeight(8),
                  ),
                  CustomInputFormField(
                    translate(context, language.languageCode,hintYourName)!,
                    TextInputType.text,
                    controller.firstAndLastNameController,
                  ),
                  SizedBox(
                    height: setWidgetHeight(19),
                  ),
                  Text(
                    translate(context, language.languageCode,labelEmail)!,
                    style: textStyle(
                        fontSize: 10,
                        color: blackLight,
                        fontFamily: satoshiMedium),
                  ),
                  SizedBox(
                    height: setWidgetHeight(8),
                  ),
                  CustomInputFormField(
                    translate(context, language.languageCode,hintEmail)!,
                    TextInputType.emailAddress,
                    controller.emailController,
                    backGroundColor: greyShadow,
                      isReadOnly: true,
                      isFilled: true,
                  ),
                  SizedBox(
                    height: setWidgetHeight(19),
                  ),
                  Text(
                    translate(context, language.languageCode,phoneNumber)!,
                    style: textStyle(
                        fontSize: 10,
                        color: blackLight,
                        fontFamily: satoshiMedium),
                  ),
                  SizedBox(
                    height: setWidgetHeight(8),
                  ),
                  CustomPhoneFormField(
                    translate(context, language.languageCode,hintPhone)!,
                    controller.phoneNumberController,
                  ),
                  SizedBox(
                    height: setWidgetHeight(19),
                  ),
                  Text(
                    translate(context, language.languageCode,labelMessage)!,
                    style: textStyle(
                        fontSize: 10,
                        color: blackLight,
                        fontFamily: satoshiMedium),
                  ),
                  SizedBox(
                    height: setWidgetHeight(8),
                  ),
                  CustomInputFormField(
                    translate(context, language.languageCode,writeHere)!,
                    TextInputType.text,
                    controller.messageController,
                    lines: 6,
                  ),
                  SizedBox(
                    height: setWidgetHeight(40),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      buttonHeight: 50,
                      buttonWidth: 168,
                      buttonColor: bluePrimary,
                      buttonTextColor: whitePrimary,
                      buttonText: translate(context, language.languageCode,submit)!,
                      onPressed: () {},
                      radiusSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: setWidgetHeight(50),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
