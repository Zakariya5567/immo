import 'package:flutter/material.dart';
import 'package:immo/localization/app_localizations.dart';

String? provideKeyToValue(
    BuildContext context, String languagecode, String? key) {
  if (key != null) {
    return translate(context, languagecode, key)!;
  } else {
    return key;
  }
}
