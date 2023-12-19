import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';

class DateShimmer extends StatefulWidget {
  const DateShimmer({super.key});

  @override
  State<DateShimmer> createState() => _DateShimmerState();
}

class _DateShimmerState extends State<DateShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyShadow,
      highlightColor: whitePrimary,
      child: Container(
        width: setWidgetWidth(170),
        height: setWidgetHeight(50),
        decoration: const BoxDecoration(
          color: whitePrimary,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
