// ignore_for_file: file_names

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerListTile extends StatefulWidget {
  const ShimmerListTile({super.key});

  @override
  State<ShimmerListTile> createState() => _ShimmerListTileState();
}

class _ShimmerListTileState extends State<ShimmerListTile> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyShadow,
      highlightColor: whitePrimary,
      child: Column(
        children: [
          marginHeight(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              marginWidth(10),
              Column(
                children: [
                  Container(
                    width: setWidgetHeight(60),
                    height: setWidgetHeight(60),
                    decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ],
              ),
              marginWidth(10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: setWidgetHeight(20),
                    width: setWidgetWidth(190),
                    decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  marginHeight(5),
                  Container(
                    height: setWidgetHeight(20),
                    width: setWidgetWidth(190),
                    decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ],
              )),
              Column(
                children: [
                  Image.asset(
                    Images.iconEdit,
                    width: setWidgetWidth(24),
                    height: setWidgetHeight(24),
                  )
                ],
              ),
              marginWidth(10),
            ],
          ),
        ],
      ),
    );
  }
}
