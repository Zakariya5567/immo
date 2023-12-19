import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';

import '../../../utils/colors.dart';

// ignore: must_be_immutable
class OnBoardCustomButton extends StatelessWidget {
  OnBoardCustomButton(
      {super.key, required this.buttonName,
      required this.onPressed,
      required this.iconName});

  String buttonName;
  String iconName;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: setWidgetHeight(55),
        width: setWidgetWidth(155),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: bluePrimary),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(buttonName,
                  style: textStyle(
                      fontSize: 20,
                      color: whitePrimary,
                      fontFamily: satoshiRegular)),
              marginWidth(8),
              iconName == ""
                  ? const SizedBox()
                  : ImageIcon(
                      AssetImage(iconName),
                      size: 22,
                      color: whitePrimary,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
