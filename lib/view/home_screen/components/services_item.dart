import 'package:flutter/material.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/launch_url.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class ServicesItem extends StatelessWidget {
  ServicesItem({Key? key, required this.position}) : super(key: key);
  int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidgetWidth(294),
      height: setWidgetHeight(160),
      padding: EdgeInsets.all(setWidgetWidth(6)),
      decoration: const BoxDecoration(
        color: whitePrimary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: greyShadow, blurRadius: 5, offset: Offset(7, 7))
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  position == 0
                      ? Images.movingServices
                      : Images.financialServices,
                ),
              ),
              color: greyShadow,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          )),
          Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: setWidgetWidth(5),
                      vertical: setWidgetHeight(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate(context, language.languageCode,
                            position == 0 ? movingService : financeServices)!,
                        style: textStyle(
                            fontSize: 14,
                            color: orangePrimary,
                            fontFamily: satoshiMedium),
                      ),
                      SizedBox(height: setWidgetHeight(2)),
                      Expanded(
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the and typesetting. Lorem Ipsum is simply dummy text of the and.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: textStyle(
                              fontSize: 10,
                              color: blackLight,
                              fontFamily: satoshiRegular),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ).onPress(() {
      if (position == 0) {
        launchInAppURL(offerten365);
      } else if (position == 1) {
        launchInAppURL(combinvest);
      }
    });
  }
}
