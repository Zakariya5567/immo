import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double displayWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// ignore: prefer_typing_uninitialized_variables
var mediaQuerry;

double setWidgetHeight(double pixels) {
  double designHeight = 896;
  return mediaQuerry.height / (designHeight / pixels);
}

double setWidgetWidth(double pixels) {
  double designWidth = 414;
  return mediaQuerry.width / (designWidth / pixels);
}

// SizedBox for Width Margin
SizedBox marginWidth(double width) {
  return SizedBox(
    width: setWidgetWidth(width),
  );
}

//SizedBox for Height Margin
SizedBox marginHeight(double height) {
  return SizedBox(
    height: setWidgetHeight(height),
  );
}

setMediaQuery(BuildContext context) {
  mediaQuerry = MediaQuery.of(context).size;
}

double bodyTextSize8 = 8;
double bodyTextSize10 = 10;
double bodyTextSize12 = 12;
double bodyTextSize14 = 14;
double bodyTextSize16 = 16;
double bodyTextSize18 = 18;
double bodyTextSize20 = 20;
double bodyTextSize22 = 22;
double bodyTextSize24 = 24;
double bodyTextSize26 = 26;
double bodyTextSize28 = 28;
double bodyTextSize30 = 30;
double bodyTextSize32 = 32;
double bodyTextSize34 = 34;
double bodyTextSize36 = 36;

double headerTextSize8 = 8;
double headerTextSize10 = 10;
double headerTextSize12 = 12;
double headerTextSize14 = 14;
double headerTextSize16 = 16;
double headerTextSize18 = 18;
double headerTextSize20 = 20;
double headerTextSize22 = 22;
double headerTextSize24 = 24;
double headerTextSize26 = 26;
double headerTextSize28 = 28;
double headerTextSize30 = 30;
double headerTextSize32 = 32;
double headerTextSize34 = 34;
double headerTextSize36 = 36;

double buttonTextSize8 = 8;
double buttonTextSize10 = 10;
double buttonTextSize12 = 12;
double buttonTextSize14 = 14;
double buttonTextSize16 = 16;
double buttonTextSize18 = 18;
double buttonTextSize20 = 20;
double buttonTextSize22 = 22;
double buttonTextSize24 = 24;
double buttonTextSize26 = 26;
double buttonTextSize28 = 28;
double buttonTextSize30 = 30;
double buttonTextSize32 = 32;
double buttonTextSize34 = 34;
double buttonTextSize36 = 36;
