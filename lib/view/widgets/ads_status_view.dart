import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/view/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/property_apraisal_provider.dart';
import '../../utils/size.dart';

class AdPublished extends StatefulWidget {
  const AdPublished({
    super.key,
    required this.textLine,
  });
  final String textLine;

  @override
  State<AdPublished> createState() => _AdPublishedState();
}

class _AdPublishedState extends State<AdPublished> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return WillPopScope(
          onWillPop: 
          () async => false,
          child: SizedBox(
            height: setWidgetHeight(360),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage(Images.adPublished),
                      width: setWidgetWidth(100),
                      height: setWidgetHeight(100),
                    ),
                  ],
                ),
                Text(
                  widget.textLine ==
                          translate(context, language.languageCode,
                              successfullyPublished)!
                      ? translate(
                          context, language.languageCode, successfullyPublished)!
                      : translate(
                          context, language.languageCode, successfullyRequested)!,
                  style: textStyle(
                    fontSize: 22,
                    color: blackPrimary,
                    fontFamily: satoshiMedium,
                  ),
                ),
                marginHeight(5),
                Consumer<PropertyAppraisalProvider>(
                  builder: (context, propertyAppraisal, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Home Button
                        CustomButton(
                            buttonHeight: 50,
                            buttonWidth: 168,
                            buttonColor: orangePrimary,
                            buttonBorderColor: orangeLight,
                            buttonTextColor: whitePrimary,
                            buttonText:
                                translate(context, language.languageCode, home)!,
                            radiusSize: 12,
                            // Function of Home button
                            onPressed: () {
                              Future.delayed(Duration.zero, () {
                                propertyAppraisal.setCurrentStep(4);
                              });
                              Navigator.of(context)
                                  .pushReplacementNamed(RouterHelper.homeScreen);
                            }),
                        marginWidth(28),
                        //My Ads Button
                        CustomButton(
                            buttonHeight: 50,
                            buttonWidth: 168,
                            buttonColor: bluePrimary,
                            buttonTextColor: whitePrimary,
                            buttonText: widget.textLine ==
                                    translate(context, language.languageCode,
                                        successfullyPublished)!
                                ? translate(
                                    context, language.languageCode, myAds)!
                                : translate(context, language.languageCode,
                                    reAssessment)!,
                            radiusSize: 12,
                            // Function of My ads button
                            onPressed: () {
                              widget.textLine ==
                                      translate(context, language.languageCode,
                                          successfullyPublished)!
                                  ? Navigator.pushReplacementNamed(
                                      context, RouterHelper.myAdsListScreen)
                                  : Future.delayed(Duration.zero, () {
                                      propertyAppraisal.setCurrentStep(4);
                                      Navigator.pushReplacementNamed(
                                          context, RouterHelper.moreOptions);
                                    });
                            }),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: non_constant_identifier_names
Future AdPublishingStatus(
  String languageCode,
  BuildContext context,
  String textLine,
) {
  return showModalBottomSheet(
    backgroundColor: whitePrimary,
    clipBehavior: Clip.antiAlias,
    enableDrag: false,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) {
      return AdPublished(
        textLine: textLine,
      );
    },
  );
}
