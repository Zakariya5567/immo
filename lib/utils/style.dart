import 'package:flutter/material.dart';

// fontFamily
const String satoshiRegular = "Satoshi-Regular";
const String satoshiBold = "Satoshi-Bold";
const String satoshiLight = "Satoshi-Light";
const String satoshiMedium = "Satoshi-Medium";
const String satoshiItalic = "Satoshi-Italic";

// TextStyle
TextStyle textStyle(
    {required double fontSize,
    required Color color,
    required String fontFamily}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontFamily: fontFamily,
    overflow: TextOverflow.clip,
  );
}
