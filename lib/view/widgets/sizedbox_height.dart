import 'package:flutter/material.dart';

import '../../utils/size.dart';

// ignore: must_be_immutable
class HeightSizedBox extends StatelessWidget {
  HeightSizedBox({super.key, required this.height});
  double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayWidth(context) * height,
    );
  }
}
