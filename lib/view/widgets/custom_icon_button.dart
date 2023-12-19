import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {super.key, required this.icon,
      required this.onTap,
      required this.height,
      required this.width,
      required this.color});

  String icon;
  VoidCallback onTap;
  Color color;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        icon,
        color: color,
        height: height,
        width: width,
      ),
    );
  }
}
