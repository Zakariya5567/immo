import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';

class ShimmerContactUsDetail extends StatefulWidget {
  const ShimmerContactUsDetail({super.key});

  @override
  State<ShimmerContactUsDetail> createState() => _ShimmerContactUsDetailState();
}

class _ShimmerContactUsDetailState extends State<ShimmerContactUsDetail> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyShadow,
      highlightColor: whitePrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: setWidgetHeight(50),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          marginHeight(50),
          Container(
            width: setWidgetWidth(200),
            height: setWidgetHeight(14),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          marginHeight(8),
          Container(
            width: setWidgetWidth(160),
            height: setWidgetHeight(12),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          marginHeight(8),
          Container(
            width: setWidgetWidth(160),
            height: setWidgetHeight(12),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          marginHeight(8),
          Container(
            width: setWidgetWidth(160),
            height: setWidgetHeight(12),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          marginHeight(8),
          Container(
            width: setWidgetWidth(160),
            height: setWidgetHeight(12),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }
}
