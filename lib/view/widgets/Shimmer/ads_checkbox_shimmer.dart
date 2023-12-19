import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/size.dart';

class AdsCheckBoxShimmer extends StatelessWidget {
  const AdsCheckBoxShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SizedBox(
        height: setWidgetHeight(260),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: greyShadow,
                    highlightColor: whitePrimary,
                    child: Container(
                      width: setWidgetWidth(30),
                      height: setWidgetHeight(30),
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: whitePrimary,
                        ),
                      ),
                    ),
                  ),
                  marginWidth(10),
                  Shimmer.fromColors(
                    baseColor: greyShadow,
                    highlightColor: whitePrimary,
                    child: Container(
                      width: setWidgetWidth(200),
                      height: setWidgetHeight(30),
                      decoration: BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: whitePrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
