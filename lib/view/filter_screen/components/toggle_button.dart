import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';

class FilterToggleButton extends StatelessWidget {
  const FilterToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterScreenProvider>(
      builder: (context, controller, child) {
        return Consumer<LanguageProvider>(
          builder: (context, language, child) {
            return Container(
              height: displayHeight(context) * 0.05,
              width: displayWidth(context) * 0.7,
              decoration: BoxDecoration(
                color: orangeLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.setButtonFlag(0, context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.toggleIndex == 0
                              ? orangePrimary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: setWidgetWidth(5)),
                              child: Text(
                                translate(
                                    context, language.languageCode, rent)!,
                                style: textStyle(
                                    fontSize: 14,
                                    color: controller.toggleIndex == 0
                                        ? whitePrimary
                                        : blackPrimary,
                                    fontFamily: satoshiRegular),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.setButtonFlag(1, context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.toggleIndex == 1
                              ? orangePrimary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: setWidgetWidth(5)),
                              child: Text(
                                translate(context, language.languageCode, buy)!,
                                style: textStyle(
                                    fontSize: 14,
                                    color: controller.toggleIndex == 1
                                        ? whitePrimary
                                        : blackPrimary,
                                    fontFamily: satoshiRegular),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
