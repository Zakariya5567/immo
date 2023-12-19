import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/style.dart';

Text getHeading(String title) {
  return Text(title,
      style:
          textStyle(fontSize: 16, color: blackLight, fontFamily: satoshiBold));
}
