import 'package:flutter/material.dart';
import 'package:immo/provider/contact_us_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';

// ignore: must_be_immutable
class RadioListHorizontal extends StatelessWidget {
  final List<String> list;
  double fontSize;
  int selectedIndex;

  RadioListHorizontal(this.list,
      {super.key, this.fontSize = 20, this.selectedIndex = 0});

  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final postAdProvider =
        Provider.of<PostAnAdProvider>(context, listen: false);
    final contactUsProvider =
        Provider.of<ContactUsProvider>(context, listen: false);
    // if (postAdProvider.categoryListId == 23) {
    //   selectedIndex = 0;
    // }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemExtent: list.length == 2 ? setWidgetWidth(200) : setWidgetWidth(130),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (_, index) {
        String value = list[index];
        return GestureDetector(
          onTap: (() {
            if (list == postAdProvider.radioListPage1) {
              postAdProvider.setCurrentIndexForPage1(index);
              selectedIndex = postAdProvider.currentIndexForPage1List;
            } else if (list == postAdProvider.radioListIndicationPrice) {
              postAdProvider.setCurrentIndexForIndicationPrice(index);
              selectedIndex = postAdProvider.currentIndexForIndicationPriceList;
            } else if (list == postAdProvider.radioListIndicationPriceForSale) {
              postAdProvider.setCurrentIndexForIndicationPrice(index);
              selectedIndex = postAdProvider.currentIndexForIndicationPriceList;
            } else if (list == postAdProvider.horizontalRadioListPage2) {
              postAdProvider.setCurrentIndexHorizontalRadioListPage2(index);
              selectedIndex =
                  postAdProvider.currentIndexHorizontalRadioListPage2;
            } else if (list == contactUsProvider.contactUsRadioList) {
              contactUsProvider.setCurrentIndexContactUsRadioList(index);
              selectedIndex = contactUsProvider.currentIndexContactUsRadioList;
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
                selectedIndex == index
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
              Consumer<LanguageProvider>(
                builder: (context, language, child) {
                  return Expanded(
                    child: Text(
                      translate(context, language.languageCode, value)!,
                      overflow: TextOverflow.clip,
                      style: textStyle(
                          fontSize: fontSize,
                          color: blackLight,
                          fontFamily: satoshiRegular),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
