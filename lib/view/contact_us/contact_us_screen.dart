// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/contact_us_provider.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/view/widgets/Shimmer/shimmer_contact_us_detail.dart';
import 'package:immo/view/widgets/custom_dropdown_list.dart';
import 'package:immo/view/widgets/input_field.dart';
import 'package:immo/view/widgets/radio_list_horizontal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/app_constant.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/launch_url.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../../utils/theme.dart';
import '../authentication_screen/components/custom_build_button.dart';
import '../widgets/Shimmer/post_an_ad/property_dropdown_list.dart';
import '../widgets/button_with_icon.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_telephone_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setEmailField();
  }

  setEmailField() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final contactUsProvider =
        Provider.of<ContactUsProvider>(context, listen: false);
    contactUsProvider.emailController.text =
        sharedPreferences.getString(AppConstant.userEmail)!;
    List<Future> apiFutures = [
      // Future.delayed(Duration.zero,(){
      contactUsProvider.getDropDown(context, RouterHelper.contactUs),
      // });
      // Future.delayed(Duration.zero,(){
      contactUsProvider.getOwnerDetail(context, RouterHelper.contactUs),
      // });
    ];
    // Wait for all the API calls to complete
    await Future.wait(apiFutures);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const ImageIcon(
                AssetImage(Images.arrowBackIcon),
                size: 23,
              ),
            ),
            title: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Text(
                  translate(context, language.languageCode, contactUs)!,
                  style: textStyle(
                      fontSize: 18,
                      color: whitePrimary,
                      fontFamily: satoshiMedium),
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Consumer<LanguageProvider>(
                builder: (context, language, child) {
                  return Consumer<ContactUsProvider>(
                    builder: (context, controller, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate(
                                context, language.languageCode, contactImmo)!,
                            style: textStyle(
                                fontSize: 18,
                                color: blackLight,
                                fontFamily: satoshiMedium),
                          ),
                          SizedBox(
                            height: setWidgetHeight(9),
                          ),
                          Text(
                            translate(
                                context, language.languageCode, contactMsg)!,
                            style: textStyle(
                                fontSize: 14,
                                color: blackLight,
                                fontFamily: satoshiRegular),
                          ),
                          SizedBox(
                            height: setWidgetHeight(23),
                          ),
                          Text(
                            translate(
                                context, language.languageCode, writeMessage)!,
                            style: textStyle(
                                fontSize: 14,
                                color: blackLight,
                                fontFamily: satoshiMedium),
                          ),
                          SizedBox(
                            height: setWidgetHeight(19),
                          ),
                          controller.isShimmerLoading != false
                              ? const PropertyDropdownListShimmer(
                                  textWidth: 100,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          reasonForRequest)!,
                                      style: textStyle(
                                          fontSize: 10,
                                          color: blackLight,
                                          fontFamily: satoshiMedium),
                                    ),
                                    SizedBox(
                                      height: setWidgetHeight(8),
                                    ),
                                    CustomDropdown(
                                      items: controller.contactUsDropDownList,
                                      title: "reasonForRequest",
                                      provider: controller,
                                    ),
                                    SizedBox(
                                      height: setWidgetHeight(23),
                                    ),
                                  ],
                                ),
                          SizedBox(
                              height: setWidgetHeight(50),
                              child: RadioListHorizontal(
                                controller.contactUsRadioList,
                                selectedIndex:
                                    controller.currentIndexContactUsRadioList,
                              )),
                          SizedBox(
                            height: setWidgetHeight(20),
                          ),
                          Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translate(context, language.languageCode,
                                        firstName)!,
                                    style: textStyle(
                                        fontSize: 10,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(8),
                                  ),
                                  CustomInputFormField(
                                    translate(context, language.languageCode,
                                        hintFirstName)!,
                                    TextInputType.text,
                                    controller.firstNameController,
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(19),
                                  ),
                                  Text(
                                    translate(context, language.languageCode,
                                        lastName)!,
                                    style: textStyle(
                                        fontSize: 10,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(8),
                                  ),
                                  CustomInputFormField(
                                    translate(context, language.languageCode,
                                        hintLastName)!,
                                    TextInputType.text,
                                    controller.lastNameController,
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(19),
                                  ),
                                  Text(
                                    translate(context, language.languageCode,
                                        telephoneNo)!,
                                    style: textStyle(
                                        fontSize: 10,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(8),
                                  ),
                                  CustomPhoneFormField(
                                    translate(context, language.languageCode,
                                        telephoneNoHint)!,
                                    controller.telePhoneNumberController,
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(19),
                                  ),
                                  Text(
                                    translate(context, language.languageCode,
                                        emailAddress)!,
                                    style: textStyle(
                                        fontSize: 10,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(19),
                                  ),
                                  CustomInputFormField(
                                    translate(context, language.languageCode,
                                        hintEmail)!,
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
                                    translate(context, language.languageCode,
                                        labelMessage)!,
                                    style: textStyle(
                                        fontSize: 10,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(8),
                                  ),
                                  CustomInputFormField(
                                    translate(context, language.languageCode,
                                        writeHere)!,
                                    TextInputType.text,
                                    controller.messageController,
                                    lines: 6,
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(40),
                                  ),
                                  CustomBuildButton(
                                      buttonName: translate(context,
                                          language.languageCode, send)!,
                                      buttonColor: bluePrimary,
                                      buttonTextColor: whitePrimary,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          controller.contactUsSubmition(
                                              context, RouterHelper.contactUs);
                                        }
                                      }),
                                ],
                              )),
                          SizedBox(
                            height: setWidgetHeight(50),
                          ),
                          Text(
                            translate(context, language.languageCode,
                                customerService)!,
                            style: textStyle(
                                fontSize: 18,
                                color: blackLight,
                                fontFamily: satoshiMedium),
                          ),
                          SizedBox(
                            height: setWidgetHeight(9),
                          ),
                          Text(
                            translate(context, language.languageCode,
                                contactByTelephone)!,
                            style: textStyle(
                                fontSize: 14,
                                color: blackLight,
                                fontFamily: satoshiRegular),
                          ),
                          SizedBox(
                            height: setWidgetHeight(20),
                          ),
                          Text(
                            translate(context, language.languageCode,
                                timingModToFri)!,
                            style: textStyle(
                                fontSize: 14,
                                color: greyLight,
                                fontFamily: satoshiRegular),
                          ),
                          SizedBox(
                            height: setWidgetHeight(9),
                          ),
                          Text(
                            translate(context, language.languageCode,
                                timingSatToSun)!,
                            style: textStyle(
                                fontSize: 14,
                                color: greyLight,
                                fontFamily: satoshiRegular),
                          ),
                          SizedBox(
                            height: setWidgetHeight(20),
                          ),
                          controller.isShimmerLoading != false ||
                                  controller.contactUsDetailModel.ownerDetail ==
                                      null
                              ? const ShimmerContactUsDetail()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: setWidgetWidth(60)),
                                        child: ButtonWithIcon(
                                            controller.contactUsDetailModel
                                                .ownerDetail!.phoneNumber!
                                                .toString(),
                                            Images.iconPhone,
                                            height: 50,
                                            iconSize: 30,
                                            fontSize: 16,
                                            bgColor: orangePrimary,
                                            borderRadius: 10, () async {
                                          try {
                                            if (controller.contactUsDetailModel
                                                    .ownerDetail!.phoneNumber !=
                                                null) {
                                              String callNumber =
                                                  'tel:${controller.contactUsDetailModel.ownerDetail!.phoneNumber!}';
                                              launchInAppURL(callNumber);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                customSnackBar(context,
                                                    phoneNumberNotAvailable, 1),
                                              );
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              customSnackBar(context,
                                                  callDidNotForword, 1),
                                            );
                                          }
                                        })),
                                    SizedBox(
                                      height: setWidgetHeight(50),
                                    ),
                                    Text(
                                      translate(context, language.languageCode,
                                          customerService)!,
                                      style: textStyle(
                                          fontSize: 18,
                                          color: blackLight,
                                          fontFamily: satoshiMedium),
                                    ),
                                    SizedBox(
                                      height: setWidgetHeight(9),
                                    ),
                                    SizedBox(
                                      width: setWidgetWidth(200),
                                      child: Text(
                                        "${controller.contactUsDetailModel.ownerDetail!.address!}\n${controller.contactUsDetailModel.ownerDetail!.location!}",
                                        style: textStyle(
                                            fontSize: 14,
                                            color: blackLight,
                                            fontFamily: satoshiRegular),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: setWidgetHeight(20),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
