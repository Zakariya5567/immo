import 'package:flutter/material.dart';
import 'package:immo/localization/app_localizations.dart';
import 'package:immo/provider/more_option_provider.dart';
import 'package:immo/provider/property_apraisal_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';

int languageCurrentIndex = 0;

// ignore: must_be_immutable
class RadioList extends StatelessWidget {
  final List<String> list;
  bool isLeftSideRadio;
  double fontSize;
  double heightSpace;
  int currentIndex;
  RadioList(this.list,
      {super.key,
      this.fontSize = 20,
      this.isLeftSideRadio = false,
      this.heightSpace = 40,
      this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final postAdProvider =
        Provider.of<PostAnAdProvider>(context, listen: false);
    final propertyAppraisalProvider =
        Provider.of<PropertyAppraisalProvider>(context, listen: false);
    final moreOptionProvider =
        Provider.of<MoreOptionProvider>(context, listen: true);
    return ListView.builder(
      itemExtent: setWidgetHeight(heightSpace),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (_, index) {
        String value = list[index];
        return isLeftSideRadio
            ? GestureDetector(
                onTap: (() {
                  if (list == postAdProvider.verticalRadioListPage2) {
                    postAdProvider.setCurrentIndexVerticalRadioListPage2(index);
                    currentIndex =
                        postAdProvider.currentIndexVerticalRadioListPage2;
                  } else if (list == postAdProvider.verticalRadioListPage5) {
                    postAdProvider.setCurrentIndexVerticalRadioListPage5(index);
                    currentIndex =
                        postAdProvider.currentIndexVerticalRadioListPage5;
                    if (currentIndex == 1) {
                      postAdProvider.telephoneController.clear();
                    }
                    // else if (currentIndex == 2) {
                    //   postAdProvider.emailController.clear();
                    // }
                  } else if (list == postAdProvider.contactFormListPage7) {
                    postAdProvider.setCurrentIndexContactFormListPage7(index);
                    currentIndex =
                        postAdProvider.currentIndexContactFormListPage7;
                  } else if (list == postAdProvider.standardListPage7) {
                    postAdProvider.setCurrentIndexStandardListPage7(index);
                    currentIndex = postAdProvider.currentIndexStandardListPage7;
                  } else if (list == postAdProvider.otherFeatureRadioList) {
                    postAdProvider
                        .setCurrentIndexForOtherFeatureRadioList(index);
                    currentIndex =
                        postAdProvider.currentIndexOtherFeatureRadioList;
                  } else if (list ==
                      propertyAppraisalProvider.verticalRadioList1) {
                    propertyAppraisalProvider
                        .setCurrentIndexVerticalRadioList1(index);
                    currentIndex = propertyAppraisalProvider
                        .currentIndexVerticalRadioList1;
                  } else if (list ==
                      propertyAppraisalProvider.verticalRadioList2) {
                    propertyAppraisalProvider
                        .setCurrentIndexVerticalRadioList2(index);
                    currentIndex = propertyAppraisalProvider
                        .currentIndexVerticalRadioList2;
                  }
                }),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(alignment: AlignmentDirectional.center, children: [
                      Container(
                        width: setWidgetWidth(24),
                        height: setWidgetHeight(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: greyPrimary,
                          ),
                        ),
                      ),
                      currentIndex == index
                          ? Container(
                              width: setWidgetWidth(12),
                              height: setWidgetHeight(12),
                              decoration: const BoxDecoration(
                                color: bluePrimary,
                                shape: BoxShape.circle,
                              ),
                            )
                          : const SizedBox(),
                    ]),
                    marginWidth(10),
                    FittedBox(
                      child: SizedBox(
                        width: setWidgetWidth(320),
                        child: Consumer<LanguageProvider>(
                          builder: (context, language, child) {
                            return Text(
                              translate(context, language.languageCode, value)!,
                              style: textStyle(
                                  fontSize: fontSize,
                                  color: blackLight,
                                  fontFamily: satoshiRegular),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: (() {
                  if (list == moreOptionProvider.languageRadioList) {
                    moreOptionProvider.setCurrentIndexLanguageRadioList(
                        index, context);
                    languageCurrentIndex =
                        moreOptionProvider.currentIndexLanguageRadioList;
                  }
                  debugPrint('$languageCurrentIndex');
                  debugPrint(value);
                  debugPrint('$index');
                }),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<LanguageProvider>(
                      builder: (context, language, child) {
                        return Text(
                          translate(context, language.languageCode, value)!,
                          style: textStyle(
                              fontSize: fontSize,
                              color: blackLight,
                              fontFamily: satoshiRegular),
                        );
                      },
                    ),
                    Container(
                      width: setWidgetWidth(24),
                      height: setWidgetHeight(24),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: currentIndex == index &&
                                      list !=
                                          moreOptionProvider
                                              .languageRadioList ||
                                  languageCurrentIndex == index &&
                                      list ==
                                          moreOptionProvider.languageRadioList
                              ? bluePrimary
                              : greyLight,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
