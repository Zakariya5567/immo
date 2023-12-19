import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import '../../utils/style.dart';

// ignore: must_be_immutable
class ButtonWithIcon extends StatelessWidget {
  String title;
  String image;
  VoidCallback onPressed;
  double height;
  double iconSize;
  double fontSize;
  double borderRadius;
  Color bgColor;
  Color textColor;

  ButtonWithIcon(this.title, this.image, this.onPressed,
      {super.key,
      this.height = 40,
      this.iconSize = 12,
      this.fontSize = 10,
      this.bgColor = bluePrimary,
      this.borderRadius = 5,
      this.textColor = whitePrimary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: setWidgetWidth(12)),
        height: setWidgetHeight(height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
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
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: setWidgetWidth(iconSize),
                height: setWidgetHeight(iconSize),
              ),
              marginWidth(5),
              Text(
                title,
                style: textStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontFamily: satoshiMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
