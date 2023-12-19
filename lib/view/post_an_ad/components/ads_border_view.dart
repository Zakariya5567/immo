import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';

class BorderView extends StatelessWidget {
  const BorderView(
      {super.key,
      required this.child,
      this.leftMargin = 0,
      this.rightMargin = 0,
      required this.height});
  final double leftMargin;
  final double rightMargin;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: setWidgetWidth(leftMargin),
        right: setWidgetWidth(rightMargin),
      ),
      height: setWidgetHeight(height),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: greyLight,
        ),
      ),
      child: child,
    );
  }
}
