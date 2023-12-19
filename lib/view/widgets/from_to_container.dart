import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';

// ignore: must_be_immutable
class FromToWidget extends StatelessWidget {
  FromToWidget({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Container(
          height: setWidgetHeight(45),
          width: setWidgetWidth(170),
          decoration: const BoxDecoration(
              color: greyShadow,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    left: setWidgetWidth(20),
                  ),
                  child: Text(
                    translate(context, language.languageCode, title)!,
                    style: textStyle(
                        fontSize: 14,
                        color: blackLight,
                        fontFamily: satoshiMedium),
                  )),
              Padding(
                padding: EdgeInsets.only(
                  right: setWidgetWidth(20),
                ),
                child: Image.asset(
                  Images.iconArrowDown,
                  width: setWidgetWidth(11),
                  height: setWidgetHeight(7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
