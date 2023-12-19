import 'package:flutter/material.dart';

import '../../utils/size.dart';

// ignore: must_be_immutable
class WidthSizedBox extends StatelessWidget {
  WidthSizedBox({super.key, required this.width});
  double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth(context) * width,
    );
  }
}
