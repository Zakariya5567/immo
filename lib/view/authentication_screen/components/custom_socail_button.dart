import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';

import '../../../utils/colors.dart';

// ignore: must_be_immutable
class CustomSocialButton extends StatelessWidget {
  CustomSocialButton({super.key, 
    required this.image,
    required this.onPressed,
  });

  String image;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: greyShadow,
        child: Image.asset(
          image,
          height: setWidgetHeight(25),
          width: setWidgetHeight(25),
        ),
      ),
    );
  }
}
