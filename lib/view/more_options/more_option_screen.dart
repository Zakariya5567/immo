import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/provider/more_option_provider.dart';
import 'package:immo/provider/user_profile_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/view/more_options/components/more_options_item.dart';
import 'package:immo/view/more_options/components/option_heading.dart';
import 'package:immo/view/more_options/components/user_info_section.dart';
import 'package:immo/view/widgets/delete_confirmation_view.dart';
import 'package:immo/view/widgets/radio_list.dart';
import 'package:provider/provider.dart';

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/authentication_provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import '../../utils/style.dart';
import '../../utils/theme.dart';
import '../widgets/bottom_nevigation_bar.dart';

class MoreOptionsScreen extends StatefulWidget {
  const MoreOptionsScreen({Key? key}) : super(key: key);

  @override
  State<MoreOptionsScreen> createState() => _MoreOptionsScreenState();
}

class _MoreOptionsScreenState extends State<MoreOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Text(
                  translate(context, language.languageCode, moreOptions)!,
                  style: textStyle(
                      fontSize: 20,
                      color: whitePrimary,
                      fontFamily: satoshiMedium),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouterHelper.postAdMainDetailFirstScreen);
            },
            backgroundColor: orangePrimary,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomBar(
            currentIndex: 4,
          ),
          body: Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Consumer<MoreOptionProvider>(
                builder: (context, controller, child) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: setWidgetWidth(20),
                          top: setWidgetHeight(10),
                          right: setWidgetWidth(10),
                          bottom: setWidgetHeight(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: setWidgetHeight(15),
                          ),
                          const UserInfo(),
                          SizedBox(
                            height: setWidgetHeight(40),
                          ),
                          OptionHeading(translate(
                              context, language.languageCode, services)!),
                          SizedBox(
                            height: setWidgetHeight(5),
                          ),
                          MoreOptionsItem(
                              translate(context, language.languageCode,
                                  movingService)!, () {
                            launchInAppURL(offerten365);
                          }),
                          MoreOptionsItem(
                              translate(context, language.languageCode,
                                  financeCalculatingService)!, () {
                            launchInAppURL(combinvest);
                          }),
                          SizedBox(
                            height: setWidgetHeight(10),
                          ),
                          OptionHeading(translate(
                              context, language.languageCode, otherServices)!),
                          SizedBox(
                            height: setWidgetHeight(10),
                          ),
                          MoreOptionsItem(
                            translate(context, language.languageCode,
                                onlinePropertyAppraisal)!,
                            () {
                              // Navigator.of(context).pushNamed(
                              //     RouterHelper.onlinePropertyAppraisalsScreen);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 500),
                                  dismissDirection: DismissDirection.up,
                                  width: setWidgetWidth(130),
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  content: Container(
                                    alignment: Alignment.center,
                                    height: setWidgetHeight(40),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(200, 1, 1, 1),
                                      borderRadius: BorderRadius.circular(90),
                                    ),
                                    child: Text(
                                      "${translate(context, language.languageCode, commingSoon)!}...",
                                      style: textStyle(
                                          fontSize: 14,
                                          color: whitePrimary,
                                          fontFamily: satoshiMedium),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: setWidgetHeight(10),
                          ),
                          OptionHeading(translate(
                              context, language.languageCode, otherOptions)!),
                          SizedBox(
                            height: setWidgetHeight(10),
                          ),
                          MoreOptionsItem(
                              translate(
                                  context, language.languageCode, myAlerts)!,
                              leadingIcon: Images.iconAlert, () {
                            Navigator.of(context)
                                .pushNamed(RouterHelper.myAlerts);
                          }),
                          MoreOptionsItem(
                              translate(context, language.languageCode,
                                  inquiryManagement)!,
                              leadingIcon: Images.iconInquiry, () {
                            Navigator.of(context)
                                .pushNamed(RouterHelper.inquiryManagement);
                          }),
                          MoreOptionsItem(
                              translate(
                                  context, language.languageCode, postAnAd)!,
                              leadingIcon: Images.iconAddBlue, () {
                            Navigator.of(context).pushNamed(
                                RouterHelper.postAdMainDetailFirstScreen);
                          }),
                          MoreOptionsItem(
                              translate(context, language.languageCode,
                                  languageText)!,
                              leadingIcon: Images.iconGlobal, () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: whitePrimary,
                              // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                              clipBehavior: Clip.antiAlias,
                              // set shape to make top corners rounded
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: setWidgetWidth(35),
                                    vertical: setWidgetHeight(35),
                                  ),
                                  child: Wrap(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                translate(
                                                    context,
                                                    language.languageCode,
                                                    languageText)!,
                                                style: textStyle(
                                                  fontSize: 22,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiBold,
                                                ),
                                              ),
                                              //Close Button
                                              const ImageIcon(
                                                AssetImage(
                                                  Images.iconClose,
                                                ),
                                                size: 22,
                                                color: blackPrimary,
                                              ).onPress(() {
                                                Navigator.pop(context);
                                              }),
                                            ],
                                          ),
                                          marginHeight(30),
                                          RadioList(
                                            controller.languageRadioList,
                                            heightSpace: 40,
                                            currentIndex: controller
                                                .currentIndexLanguageRadioList,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                          MoreOptionsItem(
                              translate(
                                  context, language.languageCode, contactUs)!,
                              leadingIcon: Images.iconContactUs, () {
                            Navigator.of(context)
                                .pushNamed(RouterHelper.contactUs);
                          }),
                          MoreOptionsItem(
                              translate(
                                  context, language.languageCode, pPrivacyPolicy)!,
                              leadingIcon: Images.iconPrivacyPolicy, () {
                            Navigator.of(context)
                                .pushNamed(RouterHelper.privacyPolicyScreen);
                          }),
                          MoreOptionsItem(
                              translate(
                                  context, language.languageCode, logout)!,
                              leadingIcon: Images.iconLogout, () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: whitePrimary,
                              // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                              clipBehavior: Clip.antiAlias,
                              // set shape to make top corners rounded
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return Consumer<AuthProvider>(
                                  builder: (context, authController, child) {
                                    return Consumer<UserProfileProvider>(
                                      builder: (context, userProfileController,
                                          child) {
                                        return SingleChildScrollView(
                                          child: DeleteConfirmationView(
                                            Images.iconLogoutWarning,
                                            () async {
                                              authController
                                                  .logOut(context,
                                                      RouterHelper.moreOptions)
                                                  .then((value) {
                                                if (authController
                                                        .logOutModel.error ==
                                                    false) {
                                                  userProfileController
                                                      .clearDataFields();
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          RouterHelper
                                                              .emailSignInScreen,
                                                          (route) => false);
                                                }
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          }),
                          SizedBox(
                            height: setWidgetHeight(20),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  translate(context, language.languageCode,
                                      versionText)!,
                                  style: textStyle(
                                      fontSize: 12,
                                      color: blackLight,
                                      fontFamily: satoshiMedium)),
                            ],
                          ),
                          SizedBox(
                            height: setWidgetHeight(20),
                          )
                        ],
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
