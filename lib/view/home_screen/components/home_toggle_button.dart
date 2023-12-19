import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';

class HomeToggleButton extends StatelessWidget {
  const HomeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
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
                        controller.setButtonFlag(0);
                        controller.getPropertyList(
                            context, 0, 1, RouterHelper.homeScreen);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.getRentButtonColor(),
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
                                    color: controller.getRentButtonTextColor(),
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
                        controller.setButtonFlag(1);
                        controller.getPropertyList(
                            context, 0, 1, RouterHelper.homeScreen);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.getbuyButtonColor(),
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
                                    color: controller.getbuyButtonTextColor(),
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
