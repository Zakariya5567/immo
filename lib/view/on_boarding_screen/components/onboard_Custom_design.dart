// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class OnBoardCustomDesign extends StatelessWidget {
  OnBoardCustomDesign({super.key, 
    required this.image1,
    required this.image2,
    required this.yellowBackGroundImage,
    required this.yellowBackgroundText,
    required this.shapeColor,
    required this.headerText,
    required this.bodyText,
    required this.sliderIcon,
  });

  String image1;
  String image2;
  String yellowBackGroundImage;
  String yellowBackgroundText;
  Color shapeColor;
  String headerText;
  String bodyText;
  String sliderIcon;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.onBoardIcon,
              height:
                  Platform.isIOS ? setWidgetHeight(64) : setWidgetHeight(68),
              width: setWidgetWidth(42),
            ),
            SizedBox(
              height: setWidgetHeight(445),
              width: displayWidth(context),
              child: Stack(
                children: [
                  Positioned(
                    left: setWidgetWidth(170),
                    top: setWidgetHeight(50),
                    child: Image.asset(
                      image2,
                      height: setWidgetHeight(400),
                      width: setWidgetWidth(185),
                    ),
                  ),
                  Positioned(
                    left: setWidgetWidth(35),
                    top: setWidgetHeight(-35),
                    child: Image.asset(
                      image1,
                      height: setWidgetHeight(460),
                      width: setWidgetWidth(210),
                    ),
                  ),
                  Positioned(
                    left: setWidgetWidth(30),
                    top: setWidgetHeight(50),
                    child: Container(
                        height: setWidgetHeight(42),
                        width: setWidgetWidth(70),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            yellowBackGroundImage,
                          ),
                        )),
                        child: Center(
                            child: Text(
                          yellowBackgroundText,
                          style: textStyle(
                              fontSize: 14,
                              color: whitePrimary,
                              fontFamily: satoshiRegular),
                        ))),
                  ),
                  Positioned(
                    left: setWidgetWidth(195),
                    top: setWidgetHeight(230),
                    child: Container(
                      height: setWidgetHeight(86),
                      width: setWidgetWidth(86),
                      decoration: BoxDecoration(
                          color: shapeColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: setWidgetHeight(10),
                              width: setWidgetWidth(15),
                              decoration: BoxDecoration(
                                  color: orangePrimary,
                                  borderRadius: BorderRadius.circular(2)),
                              child: Image.asset(Images.subtractIcon)),
                          SizedBox(
                            height: setWidgetHeight(2),
                          ),
                          Text(
                            translate(context, language.languageCode, chf)!,
                            style: textStyle(
                                fontSize: 14,
                                color: shapeColor == bluePrimary
                                    ? whitePrimary
                                    : bluePrimary,
                                fontFamily: satoshiMedium),
                          ),
                          Text(
                            "5500",
                            style: textStyle(
                                fontSize: 16,
                                color: shapeColor == bluePrimary
                                    ? whitePrimary
                                    : bluePrimary,
                                fontFamily: satoshiMedium),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              headerText,
              style: textStyle(
                  fontSize: 24, color: blackLight, fontFamily: satoshiBold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: setWidgetWidth(30),
                vertical:
                    Platform.isIOS ? setWidgetHeight(5) : setWidgetHeight(10),
              ),
              child: Text(
                bodyText,
                style: textStyle(
                    fontSize: 16,
                    color: greyPrimary,
                    fontFamily: satoshiRegular),
                textAlign: TextAlign.center,
              ),
            ),
            Platform.isIOS ? marginHeight(10) : marginHeight(10),
            Image.asset(
              sliderIcon,
              width: setWidgetWidth(30),
              height: setWidgetHeight(40),
            ),
            Platform.isIOS ? marginHeight(20) : marginHeight(40),
          ],
        );
      },
    );
  }
}
