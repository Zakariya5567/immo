import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/filter_screen_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../filter_screen/components/area_range.dart';

class AreaRangeSheet extends StatelessWidget {
  const AreaRangeSheet({super.key, required this.scaffoldKey});
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
                        translate(context, language.languageCode, areaRange)!,
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
                AreaRangeSlider(
                  title: areaRange,
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
