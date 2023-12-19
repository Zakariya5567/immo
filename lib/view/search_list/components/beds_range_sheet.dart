import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/number_list.dart';

class BedRoomsSelectionRange extends StatelessWidget {
  const BedRoomsSelectionRange({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate(context, language.languageCode, bedrooms)!,
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
                  marginHeight(30),
                  Row(
                    children: [
                      Image.asset(
                        Images.iconBedroomOrange,
                        width: setWidgetWidth(24),
                        height: setWidgetHeight(24),
                      ),
                      marginWidth(15),
                      Text(
                        translate(context, language.languageCode, bedrooms)!,
                        style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiMedium,
                        ),
                      ),
                    ],
                  ),
                  marginHeight(17),
                  const SearchListBedroomSelection(
                    totalItems: 10,
                    isBedroom: 1,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
