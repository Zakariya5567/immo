import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../../../utils/size.dart';

class ShimmerDetail extends StatelessWidget {
  const ShimmerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyShadow,
      highlightColor: whitePrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: setWidgetWidth(440),
            height: setWidgetHeight(240),
            decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          marginHeight(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: setWidgetWidth(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: setWidgetWidth(300),
                  height: setWidgetHeight(30),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(10),
                Container(
                  width: setWidgetWidth(200),
                  height: setWidgetHeight(20),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(20),
                Container(
                  width: setWidgetWidth(220),
                  height: setWidgetHeight(30),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: setWidgetWidth(100),
                      height: setWidgetHeight(35),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    Container(
                      width: setWidgetWidth(100),
                      height: setWidgetHeight(35),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    Container(
                      width: setWidgetWidth(100),
                      height: setWidgetHeight(35),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    )
                  ],
                ),
                marginHeight(20),
                Container(
                  width: setWidgetWidth(150),
                  height: setWidgetHeight(25),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(15),
                Container(
                  width: setWidgetWidth(200),
                  height: setWidgetHeight(20),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(5),
                Container(
                  width: setWidgetWidth(180),
                  height: setWidgetHeight(20),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(5),
                Container(
                  width: setWidgetWidth(220),
                  height: setWidgetHeight(20),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(20),
                Container(
                  width: setWidgetWidth(300),
                  height: setWidgetHeight(30),
                  decoration: const BoxDecoration(
                    color: whitePrimary,
                  ),
                ),
                marginHeight(10),
                Row(
                  children: [
                    Container(
                      width: setWidgetWidth(150),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                    marginWidth(10),
                    Container(
                      width: setWidgetWidth(180),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                  ],
                ),
                marginHeight(10),
                Row(
                  children: [
                    Container(
                      width: setWidgetWidth(150),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                    marginWidth(10),
                    Container(
                      width: setWidgetWidth(120),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                  ],
                ),
                marginHeight(10),
                Row(
                  children: [
                    Container(
                      width: setWidgetWidth(150),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                    marginWidth(10),
                    Container(
                      width: setWidgetWidth(180),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                  ],
                ),
                marginHeight(10),
                Row(
                  children: [
                    Container(
                      width: setWidgetWidth(150),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                    marginWidth(10),
                    Container(
                      width: setWidgetWidth(180),
                      height: setWidgetHeight(20),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                      ),
                    ),
                  ],
                ),
                marginHeight(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: setWidgetWidth(150),
                      height: setWidgetHeight(50),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Container(
                      width: setWidgetWidth(180),
                      height: setWidgetHeight(50),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
