import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';

import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';
import '../../widgets/sizedbox_height.dart';

// ignore: must_be_immutable
class TitleSection extends StatelessWidget {
  TitleSection({
    super.key,
    required this.title,
    required this.description,
    required this.iconColor,
  });

  String title;
  String description;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: textStyle(
              fontSize: 22, color: blackPrimary, fontFamily: satoshiBold),
        ),
        HeightSizedBox(height: 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidgetWidth(20)),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: textStyle(
                fontSize: 12, color: greyLight, fontFamily: satoshiRegular),
          ),
        ),
        marginHeight(70),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidgetWidth(30)),
          child: Image.asset(
            Images.logo,
          ),
        ),
        marginHeight(85),
      ],
    );
  }
}
