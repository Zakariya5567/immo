import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: setWidgetHeight(1),
      color: greyShadow,
    );
  }
}
