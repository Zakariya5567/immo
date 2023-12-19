import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class ButtonWithLeftIcon extends StatelessWidget {
  String title;
  String image;
  VoidCallback onPressed;
  double height;
  double iconSize;
  double fontSize;
  Color bgColor;
  Color textColor;

  ButtonWithLeftIcon(
    this.title,
    this.image,
    this.onPressed, {
    super.key,
    this.height = 38,
    this.iconSize = 8,
    this.fontSize = 10,
    this.bgColor = bluePrimary,
    this.textColor = whitePrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: setWidgetWidth(15),
        ),
        height: setWidgetHeight(height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
          border: Border.all(color: bgColor),
          boxShadow: [
            bgColor == bluePrimary
                ? const BoxShadow(
                    color: blueShadow,
                    blurRadius: 4,
                    offset: Offset(1, 1) // Shadow position
                    )
                : const BoxShadow(
                    color: blueShadow,
                    blurRadius: 4,
                    offset: Offset(0, 0) // Shadow position
                    )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: textStyle(
                fontSize: fontSize,
                color: textColor,
                fontFamily: satoshiMedium,
              ),
            ),
            marginWidth(5),
            Image.asset(
              image,
              width: setWidgetWidth(iconSize),
              height: setWidgetHeight(iconSize),
            ),
          ],
        ),
      ),
    );
  }
}
