// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/app_constant.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/view/widgets/custom_button.dart';
import 'package:immo/view/widgets/custom_dropdown_list.dart';
import 'package:immo/view/widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/style.dart';
import '../../widgets/custom_telephone_field.dart';

// ignore: must_be_immutable
class ReportAnAd extends StatefulWidget {
  ReportAnAd(
      {super.key,
      required this.scaffoldKey,
      required this.formKey,
      required this.id});
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  int id;

  @override
  State<ReportAnAd> createState() => _ReportAnAdState();
}

class _ReportAnAdState extends State<ReportAnAd> {
  @override
  void initState() {
    super.initState();
    setEmailField();
  }

  setEmailField() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    homePageProvider.emailController.text =
        sharedPreferences.getString(AppConstant.userEmail)!;
    homePageProvider.firstAndLastNameController.text =
        sharedPreferences.getString(AppConstant.userName)!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, HomePageProvider>(
      builder: (context, language, controller, child) {
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
                        translate(context, language.languageCode, reportAd)!,
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
                    translate(context, language.languageCode, reason)!,
                    style: textStyle(
                      fontSize: 10,
                      color: blackPrimary,
                      fontFamily: satoshiMedium,
                    ),
                  ),
                  marginHeight(8),
                  CustomDropdown(
                    items: controller.reportList,
                    title: controller.reportList.first,
                    provider: controller,
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
                    controller.emailController,
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
                    controller.phoneNumberController,
                  ),
                  marginHeight(20),
                  Text(
                    translate(
                        context, language.languageCode, detailedDescription)!,
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
                    controller.descriptionController,
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
                          translate(context, language.languageCode, send)!,
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          Navigator.of(widget.scaffoldKey.currentContext!)
                              .pop();
                          controller.createReportAd(
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
