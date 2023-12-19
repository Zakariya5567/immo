import 'package:flutter/material.dart';



extension WidgetExtensions on Widget {


  Widget onPress(VoidCallback onTap, {bool hideSplashColor = false}) => InkWell(
      onTap: onTap,
      highlightColor: hideSplashColor ? Colors.transparent : null,
      splashColor: hideSplashColor ? Colors.transparent : null,
      child: this);


  Widget get expanded => Expanded(child: this);

  Widget get center => Center(child: this);

  Widget align(AlignmentGeometry align) => Align(alignment: align, child: this);

  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingOnly(
          {double left = 0.0,
          double right = 0.0,
          double top = 0.0,
          double bottom = 0.0}) =>
      Padding(
          padding: EdgeInsets.only(
              left: left, right: right, top: top, bottom: bottom),
          child: this);
}
