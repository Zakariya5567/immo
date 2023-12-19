import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/size.dart';

class PropertyTypeShimmer extends StatelessWidget {
  const PropertyTypeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyShadow,
                highlightColor: whitePrimary,
                child: Container(
                  width: setWidgetWidth(100),
                  height: setWidgetHeight(30),
                  decoration: BoxDecoration(
                    color: whitePrimary,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: whitePrimary,
                    ),
                  ),
                ),
              ),
              marginWidth(10),
            ],
          );
        },
      ),
    );
  }
}
