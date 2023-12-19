import 'package:flutter/material.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class DetailDescription extends StatelessWidget {
  DetailDescription(
      {super.key, required this.controller, required this.language});
  HomePageProvider controller;
  LanguageProvider language;

  @override
  Widget build(BuildContext context) {
    final data = controller.propertiesDetailModel.data!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        marginHeight(20),
        getHeading(translate(context, language.languageCode, description)!),
        marginHeight(15),
        Text(
          data.description == null ? "_" : data.description!,
          style: textStyle(
              fontSize: 14, color: blackLight, fontFamily: satoshiRegular),
        ),
      ],
    );
  }
}
