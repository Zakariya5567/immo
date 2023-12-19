import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/style.dart';

SnackBar customSnackBar(BuildContext context, String message, int isError) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    dismissDirection: DismissDirection.up,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    padding: EdgeInsets.zero,
    content: Container(
      decoration: BoxDecoration(
          color: isError == 0 ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(-4, 4),
            ),
          ]),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Text(
                translate(context, language.languageCode, message)!,
                textAlign: TextAlign.start,
                style: textStyle(
                    fontSize: 14,
                    color: whitePrimary,
                    fontFamily: satoshiRegular),
              );
            },
          ),
        ),
      ),
    ),
  );
}
