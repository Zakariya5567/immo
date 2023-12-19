import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';

class InformationTitle extends StatelessWidget {
  const InformationTitle({super.key, required this.information});
  final String information;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(information,
            style: textStyle(
                fontSize: 18, color: blackPrimary, fontFamily: satoshiMedium)),
      ],
    );
  }
}

class InformationDetails extends StatelessWidget {
  const InformationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Row(
          children: [
            Text(translate(context, language.languageCode,optionsCompulsory)!,
                style: textStyle(
                    fontSize: 12,
                    color: blackPrimary,
                    fontFamily: satoshiRegular)),
          ],
        );
      },
    );
  }
}
