import 'package:flutter/material.dart';
import 'package:immo/provider/authentication_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/style.dart';

class LanguageTextButton extends StatelessWidget {
  const LanguageTextButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, AuthProvider>(
      builder: (context, language, authProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidgetWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textButton(
                translate(context, language.languageCode, deutsch)!,
                () {
                  language.changeLanguage("de");
                  formKey.currentState!.reset();
                },
                language.isGermenSelected,
              ),
              textButton(
                translate(context, language.languageCode, francais)!,
                () {
                  language.changeLanguage("fr");
                  formKey.currentState!.reset();
                },
                language.isFrenchSelected,
              ),
              textButton(
                translate(context, language.languageCode, italiano)!,
                () {
                  language.changeLanguage("it");
                  formKey.currentState!.reset();
                },
                language.isItalianSelected,
              ),
              textButton(
                translate(context, language.languageCode, english)!,
                () {
                  language.changeLanguage("en");
                  formKey.currentState!.reset();
                },
                language.isEnglishSelected,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget textButton(String text, VoidCallback onPressed, bool isSelected) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            text,
            style: textStyle(
              fontSize: 12,
              color: isSelected ? bluePrimary : blackPrimary,
              fontFamily: satoshiMedium,
            ),
          ),
          marginHeight(2),
          isSelected
              ? Container(
                  color: bluePrimary,
                  height: 2,
                  width: 30,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
