import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/style.dart';

class OptionHeading extends StatelessWidget {
  final String title;

  const OptionHeading(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: textStyle(fontSize: 16, color: greyPrimary, fontFamily: satoshiBold),);
  }
}
