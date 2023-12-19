import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';

import '../../utils/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.buttonText,
    this.radiusSize = 6,
    required this.onPressed,
    this.buttonBorderColor = blueShadow,
  });
  final String buttonText;
  final double buttonHeight;
  final double buttonWidth;
  final Color buttonColor;
  final Color buttonBorderColor;
  final Color buttonTextColor;
  final double radiusSize;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: setWidgetWidth(buttonWidth),
        height: setWidgetHeight(buttonHeight),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(radiusSize)),
          border: Border.all(
            color: buttonBorderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          buttonText,
          style: textStyle(
            fontSize: 16,
            color: buttonTextColor,
            fontFamily: satoshiMedium,
          ),
        ),
      ),
    );
  }
}
