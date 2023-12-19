import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/style.dart';

Padding getFacilityItem(
  String title,
) {
  return Padding(
    padding: EdgeInsets.only(top: setWidgetHeight(15)),
    child: Row(
      children: [
        Image.asset(
          Images.iconTick,
          width: setWidgetWidth(20),
          height: setWidgetHeight(20),
        ),
        SizedBox(
          width: setWidgetWidth(15),
        ),
        Text(title,
            style: textStyle(
                fontSize: 14, color: blackLight, fontFamily: satoshiMedium))
      ],
    ),
  );
}

getListFacilityItem(String title, var value) {
  return value == false || value == null || value == "null"
      ? const SizedBox()
      : Padding(
          padding: EdgeInsets.only(top: setWidgetHeight(15)),
          child: Row(
            children: [
              Image.asset(
                Images.iconTick,
                width: setWidgetWidth(20),
                height: setWidgetHeight(20),
              ),
              SizedBox(
                width: setWidgetWidth(15),
              ),
              Text(title,
                  style: textStyle(
                      fontSize: 14,
                      color: blackLight,
                      fontFamily: satoshiMedium))
            ],
          ),
        );
}
