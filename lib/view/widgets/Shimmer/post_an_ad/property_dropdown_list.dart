import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';

class PropertyDropdownListShimmer extends StatefulWidget {
  const PropertyDropdownListShimmer({super.key, required this.textWidth});
  final double textWidth;

  @override
  State<PropertyDropdownListShimmer> createState() =>
      _PropertyDropdownListShimmerState();
}

class _PropertyDropdownListShimmerState
    extends State<PropertyDropdownListShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyShadow,
      highlightColor: whitePrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: setWidgetWidth(widget.textWidth),
            height: setWidgetHeight(12),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          marginHeight(8),
          Container(
            height: setWidgetHeight(50),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          marginHeight(19),
        ],
      ),
    );
  }
}
