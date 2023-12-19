import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/style.dart';

class InputLabel extends StatelessWidget {
  final String text;

  const InputLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          textStyle(fontSize: 12, color: blackLight, fontFamily: satoshiMedium),
    );
  }
}
