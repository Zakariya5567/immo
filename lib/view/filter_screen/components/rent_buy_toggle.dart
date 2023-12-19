import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/view/filter_screen/components/toggle_button.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/style.dart';

class RentBuyToggle extends StatelessWidget {
  const RentBuyToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    Images.iconTick,
                    width: setWidgetWidth(24),
                    height: setWidgetHeight(24),
                  ),
                  SizedBox(
                    width: setWidgetWidth(15),
                  ),
                  Text(translate(context, language.languageCode, iWant)!,
                      style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiMedium))
                ],
              ),
              Container(
                  height: setWidgetHeight(45),
                  width: setWidgetWidth(120),
                  decoration: BoxDecoration(
                      color: orangeLight.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: const FilterToggleButton())
            ],
          ),
        );
      },
    );
  }
}
