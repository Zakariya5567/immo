// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_telephone_field.dart';
import '../../widgets/input_field.dart';

class ContactForm extends StatefulWidget {
  const ContactForm(
      {super.key,
      required this.id,
      required this.scaffoldKey,
      required this.controller,
      required this.formKey});
  final int id;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomePageProvider controller;
  final GlobalKey<FormState> formKey;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  void initState() {
    super.initState();
    setEmailField();
  }

  setEmailField() async {
    // Future.delayed(Duration.zero, () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    homePageProvider.emailController.text =
        sharedPreferences.getString(AppConstant.userEmail)!;
    homePageProvider.firstAndLastNameController.text =
        sharedPreferences.getString(AppConstant.userName)!;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: widget.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate(context, language.languageCode, contactForm)!,
                        style: textStyle(
                            fontSize: 22,
                            color: blackLight,
                            fontFamily: satoshiBold),
                      ),
                      const ImageIcon(
                        AssetImage(
                          Images.iconClose,
                        ),
                        size: 24,
                      ).onPress(
                        () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  marginHeight(35),
                  Text(
                    translate(
                        context, language.languageCode, firstAndLastName)!,
                    style: textStyle(
                      fontSize: 10,
                      color: blackPrimary,
                      fontFamily: satoshiMedium,
                    ),
                  ),
                  marginHeight(8),
                  CustomInputFormField(
                    translate(context, language.languageCode, hintYourName)!,
                    TextInputType.name,
                    widget.controller.firstAndLastNameController,
                  ),
                  marginHeight(20),
                  Text(
                    translate(context, language.languageCode, labelEmail)!,
                    style: textStyle(
                      fontSize: 10,
                      color: blackPrimary,
                      fontFamily: satoshiMedium,
                    ),
                  ),
                  marginHeight(8),
                  CustomInputFormField(
                    translate(context, language.languageCode, hintEmail)!,
                    TextInputType.emailAddress,
                    widget.controller.emailController,
                    backGroundColor: greyShadow,
                    isReadOnly: true,
                    isFilled: true,
                  ),
                  marginHeight(20),
                  Text(
                    translate(context, language.languageCode, phoneNumber)!,
                    style: textStyle(
                      fontSize: 10,
                      color: blackPrimary,
                      fontFamily: satoshiMedium,
                    ),
                  ),
                  marginHeight(8),
                  CustomPhoneFormField(
                    translate(context, language.languageCode, hintPhone)!,
                    widget.controller.phoneNumberController,
                  ),
                  marginHeight(20),
                  Text(
                    translate(context, language.languageCode, labelMessage)!,
                    style: textStyle(
                      fontSize: 10,
                      color: blackPrimary,
                      fontFamily: satoshiMedium,
                    ),
                  ),
                  marginHeight(8),
                  CustomInputFormField(
                    translate(context, language.languageCode, writeHere)!,
                    TextInputType.text,
                    widget.controller.descriptionController,
                    lines: 5,
                  ),
                  marginHeight(30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      buttonHeight: 50,
                      buttonWidth: 168,
                      buttonColor: bluePrimary,
                      buttonTextColor: whitePrimary,
                      buttonText:
                          translate(context, language.languageCode, submit)!,
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          Navigator.of(widget.scaffoldKey.currentContext!)
                              .pop();
                          widget.controller.submitContactUs(
                              widget.scaffoldKey.currentContext!,
                              RouterHelper.adDetailsScreen,
                              widget.id);
                        }
                      },
                      radiusSize: 12,
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
