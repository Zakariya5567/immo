import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/on_boarding_screen/components/onboard_Custom_design.dart';
import 'package:immo/view/on_boarding_screen/components/onboard_cutstom_button.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';

class OnBoardingFirstScreen extends StatelessWidget {
  const OnBoardingFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: whiteStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: whitePrimary,
            elevation: 0,
          ),
          body: Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Container(
                height: displayHeight(context),
                width: displayWidth(context),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                      whitePrimary,
                      greyLight,
                    ])),
                child: Column(
                  children: [
                    OnBoardCustomDesign(
                      image1: Images.onBoardImage1,
                      image2: Images.onBoardImage2,
                      yellowBackGroundImage: Images.yellowBack1,
                      yellowBackgroundText:
                          translate(context, language.languageCode, home)!,
                      shapeColor: whitePrimary,
                      headerText: translate(
                          context, language.languageCode, dreamHouseText)!,
                      bodyText: translate(context, language.languageCode,
                          onBoardDescriptionText)!,
                      sliderIcon: Images.onBoardSliderIcon1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text(
                              translate(context, language.languageCode, skip)!,
                              style: textStyle(
                                  fontSize: 18,
                                  color: blackLight,
                                  fontFamily: satoshiMedium),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  RouterHelper.emailSignInScreen);
                            },
                          ),
                          OnBoardCustomButton(
                              buttonName: translate(
                                  context, language.languageCode, nextText)!,
                              iconName: Images.arrowForwardIcon,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    RouterHelper.onBoardingSecondScreen);
                              })
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
