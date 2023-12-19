import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';

import '../../../utils/colors.dart';
import '../../../utils/style.dart';

Padding getKeyValueItem(String key, String value) {
  return Padding(
    padding: EdgeInsets.only(top: setWidgetHeight(10)),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(key,
                style: textStyle(
                    fontSize: 14,
                    color: greyLight,
                    fontFamily: satoshiRegular))),
        Expanded(
            child: Text(value,
                style: textStyle(
                    fontSize: 14,
                    color: blackLight,
                    fontFamily: satoshiRegular)))
      ],
    ),
  );
}
