import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../filter_screen/components/price_range.dart';

class PriceRangeSheet extends StatelessWidget {
  const PriceRangeSheet({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterScreenProvider>(
      builder: (context, controller, child) {
        return Consumer<LanguageProvider>(
          builder: (context, language, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate(context, language.languageCode, priceRange)!,
                        style: textStyle(
                          fontSize: 22,
                          color: blackPrimary,
                          fontFamily: satoshiBold,
                        ),
                      ),
                      //Close Button
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const ImageIcon(
                          AssetImage(
                            Images.iconClose,
                          ),
                          size: 24,
                          color: blackPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                PriceRangeSlider(
                  title: priceRange,
                  controller: controller,
                  scaffoldKey: scaffoldKey,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
