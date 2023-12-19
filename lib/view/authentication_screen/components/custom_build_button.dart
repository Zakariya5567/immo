import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';

import '../../../utils/colors.dart';

// ignore: must_be_immutable
class CustomBuildButton extends StatelessWidget {
  CustomBuildButton(
      {super.key, required this.buttonName,
      required this.onPressed,
      required this.buttonColor,
      required this.buttonTextColor});

  String buttonName;
  VoidCallback onPressed;
  Color buttonColor;
  Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: setWidgetWidth(20), vertical: setWidgetHeight(5)),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: displayHeight(context) * 0.065,
          width: displayHeight(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
            border: Border.all(
                color: buttonColor == blueLight
                    ? blueLight
                    : buttonColor == redColor
                        ? redColor
                        : bluePrimary),
            boxShadow: [
              BoxShadow(
                color: blueShadow,
                blurRadius: 4,
                offset: buttonColor == bluePrimary
                    ? const Offset(4, 8)
                    : const Offset(0, 0), // Shadow position
              ),
            ],
          ),
          child: Center(
            child: Text(buttonName,
                style: textStyle(
                    fontSize: 16,
                    color: buttonTextColor,
                    fontFamily: satoshiRegular)),
          ),
        ),
      ),
    );
  }
}
