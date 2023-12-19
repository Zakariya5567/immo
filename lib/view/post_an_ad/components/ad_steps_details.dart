import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/string.dart';

class AdsStepsDetails extends StatelessWidget {
  const AdsStepsDetails(
      {super.key,
      required this.steps,
      required this.stepTitle,
      required this.stepDescription});
  final int steps;
  final String stepTitle;
  final String stepDescription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setWidgetHeight(168),
      child: Row(
        children: [
          Column(
            children: [
              marginHeight(30),
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  height: setWidgetWidth(110),
                  width: setWidgetWidth(110),
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    backgroundColor: whiteShadow,
                    valueColor: const AlwaysStoppedAnimation<Color>(bluePrimary),
                    value: steps / 6,
                    color: bluePrimary,
                  ),
                ),
                Consumer<LanguageProvider>(
                    builder: (context, language, child) {
                      return Text('$steps ${translate(context, language.languageCode, ofText)} 6',
                    style: textStyle(
                      fontSize: 18,
                      color: bluePrimary,
                      fontFamily: satoshiMedium,
                    ));},),
              ]),
            ],
          ),
          marginWidth(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              marginHeight(33),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<LanguageProvider>(
                    builder: (context, language, child) {
                      return Text(
                        "${translate(context, language.languageCode, step)!} $steps : ",
                        style: textStyle(
                            fontSize: 16,
                            color: bluePrimary,
                            fontFamily: satoshiMedium),
                      );
                    },
                  ),
                  SizedBox(
                    width: setWidgetWidth(140),
                    child: Text(stepTitle,
                        overflow: TextOverflow.clip,
                        style: textStyle(
                            fontSize: 16,
                            color: bluePrimary,
                            fontFamily: satoshiMedium)),
                  ),
                ],
              ),
              marginHeight(5),
              Text(stepDescription,
                  style: textStyle(
                      fontSize: 12,
                      color: greyLight,
                      fontFamily: satoshiMedium)),
            ],
          ),
        ],
      ),
    );
  }
}
