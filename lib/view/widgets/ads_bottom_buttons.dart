// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:immo/provider/post_an_ad_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/property_apraisal_provider.dart';
import 'ads_status_view.dart';

class BottomButtons extends StatefulWidget {
  final String screen;
  final String rightButtonName;
  final String leftButtonName;
  const BottomButtons({
    super.key,
    required this.screen,
    required this.rightButtonName,
    required this.leftButtonName,
  });

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Consumer<PostAnAdProvider>(
          builder: (context, postAnAdProvider, child) {
            return Container(
              height: setWidgetHeight(90),
              decoration: BoxDecoration(
                color: whitePrimary,
                boxShadow: [
                  BoxShadow(
                    color: blackPrimary.withOpacity(0.1),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: const Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: setWidgetWidth(25),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Back Button
                    InkWell(
                      child: Container(
                        width: setWidgetWidth(168),
                        height: setWidgetHeight(60),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: whitePrimary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: greyLight),
                          boxShadow: [
                            BoxShadow(
                              color: greyShadow.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 12,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          widget.leftButtonName,
                          style: textStyle(
                            fontSize: 16,
                            color: blackPrimary,
                            fontFamily: satoshiMedium,
                          ),
                        ),
                      ),
                      // Function of Cencel Button
                      onTap: () {
                        if (widget.leftButtonName ==
                            translate(
                                context, language.languageCode, cancel)!) {
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouterHelper.homeScreen, (route) => false);
                          }).then((value) =>
                              postAnAdProvider.clearAllPostAdScreen());
                        } else if (widget.leftButtonName ==
                            translate(context, language.languageCode, back)!) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SizedBox(
                      width: setWidgetWidth(28),
                    ),
                    // Save & Next Button
                    Consumer<PropertyAppraisalProvider>(
                      builder: (context, propertyAppraisal, child) {
                        return InkWell(
                          child: Container(
                            width: setWidgetWidth(168),
                            height: setWidgetHeight(60),
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(bottom: setWidgetHeight(5)),
                            decoration: BoxDecoration(
                              color: widget.rightButtonName ==
                                      translate(context, language.languageCode,
                                          publish)!
                                  ? bluePrimary
                                  : orangePrimary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                color: blueLight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.rightButtonName ==
                                          translate(context,
                                              language.languageCode, publish)!
                                      ? whitePrimary.withOpacity(0.1)
                                      : orangePrimary.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                              widget.rightButtonName ==
                                      translate(context, language.languageCode,
                                          publish)!
                                  ? widget.rightButtonName
                                  : widget.rightButtonName ==
                                          translate(context,
                                              language.languageCode, nextText)!
                                      ? translate(context,
                                          language.languageCode, nextText)!
                                      : widget.rightButtonName ==
                                              translate(
                                                  context,
                                                  language.languageCode,
                                                  requestAppraisal)!
                                          ? translate(
                                              context,
                                              language.languageCode,
                                              requestAppraisal)!
                                          : widget.rightButtonName ==
                                                  translate(
                                                      context,
                                                      language.languageCode,
                                                      apply)!
                                              ? widget.rightButtonName
                                              : translate(
                                                  context,
                                                  language.languageCode,
                                                  saveNext)!,
                              textAlign: TextAlign.center,
                              style: textStyle(
                                fontSize: 16,
                                color: whitePrimary,
                                fontFamily: satoshiMedium,
                              ),
                            ),
                          ),
                          //Function of Apply Button
                          onTap: () {
                            if (widget.screen ==
                                translate(context, language.languageCode,
                                    propertyDetails)!) {
                                      if(postAnAdProvider.isSubCategoryLoading == false) {
                                        Navigator.of(context).pushNamed(
                                  RouterHelper.postAdMainDetailSecondScreen);
                                      }
                            }
                            if (widget.screen ==
                                translate(
                                    context, language.languageCode, details)!) {
                              if (postAnAdProvider
                                      .isRequiredFieldsEmpty(context) ==
                                  false) {
                                Future.delayed(Duration.zero, () async {
                                  await postAnAdProvider.saveProperty(
                                      context,
                                      RouterHelper
                                          .postAdMainDetailSecondScreen);
                                  if (postAnAdProvider
                                          .savePropertiesModel.error ==
                                      false) {
                                    Navigator.of(context).pushNamed(
                                        RouterHelper.postAdDimensionScreen);
                                  }
                                });
                              }
                            }
                            if (widget.screen ==
                                translate(context, language.languageCode,
                                    imagesVideosPDFs)!) {
                              Future.delayed(Duration.zero, () async {
                                await postAnAdProvider.saveDetails(context,
                                    RouterHelper.postAdDimensionScreen);
                                if (postAnAdProvider.saveDetailsModel.error ==
                                    false) {
                                  Navigator.of(context).pushNamed(
                                      RouterHelper.postAdUploadingDataScreen);
                                }
                              });
                            }
                            if (widget.screen ==
                                translate(context, language.languageCode,
                                    contacts)!) {
                              if (postAnAdProvider.isYoutubeLinkValid(postAnAdProvider.youtubeLink1Controller.text, context) &&
                                  postAnAdProvider.isYoutubeLinkValid(
                                      postAnAdProvider
                                          .youtubeLink2Controller.text,
                                      context) &&
                                  postAnAdProvider.isWebLinkValid(
                                      postAnAdProvider.webLinkController.text,
                                      context)) {
                                Future.delayed(Duration.zero, () async {
                                  await postAnAdProvider.saveDocuments(context,
                                      RouterHelper.postAdUploadingDataScreen);
                                  if (postAnAdProvider.saveDocModel.error ==
                                      false) {
                                    Navigator.of(context).pushNamed(RouterHelper
                                        .postAdContactsDetailScreen);
                                  }
                                });
                              }
                            }
                            if (widget.screen ==
                                translate(
                                    context, language.languageCode, order)!) {
                              if (postAnAdProvider
                                  .isContactFormRequiredFieldsNotEmpty(
                                      context)) {
                                Future.delayed(Duration.zero, () async {
                                  await postAnAdProvider.saveContactForm(
                                      context,
                                      RouterHelper.postAdContactsDetailScreen);
                                  if (postAnAdProvider
                                          .saveContactFormModel.error ==
                                      false) {
                                    Navigator.of(context).pushNamed(
                                        RouterHelper.postAdOrderDetailScreen);
                                  }
                                });
                              }
                            }
                            if (widget.screen ==
                                translate(
                                    context, language.languageCode, finish)!) {
                              Navigator.of(context).pushNamed(
                                  RouterHelper.postAdFinishingDetailScreen);
                            }
                            if (widget.screen ==
                                translate(
                                    context, language.languageCode, publish)!) {
                              Future.delayed(Duration.zero, () async {
                                await postAnAdProvider.publishAd(context,
                                    RouterHelper.postAdFinishingDetailScreen);
                              }).then((value) => AdPublishingStatus(
                                      language.languageCode,
                                      context,
                                      translate(context, language.languageCode,
                                          successfullyPublished)!)
                                  .then((value) =>
                                      postAnAdProvider.clearAllPostAdScreen()));
                            }
                            //Online Property Appraisal Screen
                            if (widget.screen ==
                                translate(context, language.languageCode,
                                    onlinePropertyAppraisal)!) {
                              Navigator.of(context).pushNamed(RouterHelper
                                  .informationPropertyDetailsScreen);
                            }
                            if (widget.screen ==
                                translate(context, language.languageCode,
                                    informationProperty)!) {
                              Navigator.of(context).pushNamed(
                                  RouterHelper.otherPropertyDetailsScreen);
                            }
                            if (widget.screen ==
                                translate(
                                    context, language.languageCode, other)!) {
                              Navigator.of(context).pushNamed(
                                  RouterHelper.yourContactDetailsScreen);
                            }
                            if (widget.screen ==
                                translate(context, language.languageCode,
                                    yourContactDetails)!) {
                              propertyAppraisal.setCurrentStep(5);
                              AdPublishingStatus(
                                  language.languageCode,
                                  context,
                                  translate(context, language.languageCode,
                                      successfullyRequested)!);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
