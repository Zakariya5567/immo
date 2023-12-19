import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';

class PropertiesListShimmer extends StatefulWidget {
  const PropertiesListShimmer({super.key});

  @override
  State<PropertiesListShimmer> createState() => _PropertiesListShimmerState();
}

class _PropertiesListShimmerState extends State<PropertiesListShimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: setWidgetWidth(10),
      ),
      margin: EdgeInsets.symmetric(
        vertical: setWidgetHeight(10),
        horizontal: setWidgetWidth(30),
      ),
      height: setWidgetHeight(230),
      decoration: BoxDecoration(
        color: whitePrimary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: greyShadow,
            spreadRadius: 7,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          marginHeight(10),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyShadow,
                highlightColor: whitePrimary,
                child: Container(
                  width: setWidgetWidth(138),
                  height: setWidgetHeight(145),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: whitePrimary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: greyShadow,
                        highlightColor: whitePrimary,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: setWidgetWidth(8),
                            bottom: setWidgetHeight(8),
                          ),
                          width: setWidgetWidth(41),
                          height: setWidgetHeight(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: whitePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: setWidgetWidth(138),
                  height: setWidgetHeight(145),
                  padding: EdgeInsets.only(
                    left: setWidgetWidth(12),
                    top: setWidgetHeight(6),
                    bottom: setWidgetHeight(6),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: whitePrimary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: greyShadow,
                        highlightColor: whitePrimary,
                        child: Container(
                          height: setWidgetHeight(15),
                          width: setWidgetWidth(150),
                          decoration: const BoxDecoration(
                            color: whitePrimary,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      marginHeight(5),
                      Shimmer.fromColors(
                        baseColor: greyShadow,
                        highlightColor: whitePrimary,
                        child: Container(
                          height: setWidgetHeight(15),
                          width: setWidgetWidth(150),
                          decoration: const BoxDecoration(
                            color: whitePrimary,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      marginHeight(5),
                      Shimmer.fromColors(
                        baseColor: greyShadow,
                        highlightColor: whitePrimary,
                        child: Container(
                          height: setWidgetHeight(15),
                          width: setWidgetWidth(150),
                          decoration: const BoxDecoration(
                            color: whitePrimary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      marginHeight(5),
                      Shimmer.fromColors(
                        baseColor: greyShadow,
                        highlightColor: whitePrimary,
                        child: Container(
                          height: setWidgetHeight(15),
                          width: setWidgetWidth(150),
                          decoration: const BoxDecoration(
                            color: whitePrimary,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      marginHeight(5),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: greyShadow,
                            highlightColor: whitePrimary,
                            child: Container(
                              height: setWidgetHeight(25),
                              width: setWidgetWidth(47),
                              decoration: const BoxDecoration(
                                color: whitePrimary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                              ),
                            ),
                          ),
                          marginWidth(5),
                          Shimmer.fromColors(
                            baseColor: greyShadow,
                            highlightColor: whitePrimary,
                            child: Container(
                              height: setWidgetHeight(25),
                              width: setWidgetWidth(47),
                              decoration: const BoxDecoration(
                                color: whitePrimary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                              ),
                            ),
                          ),
                          marginWidth(5),
                          Shimmer.fromColors(
                            baseColor: greyShadow,
                            highlightColor: whitePrimary,
                            child: Container(
                              height: setWidgetHeight(25),
                              width: setWidgetWidth(47),
                              decoration: const BoxDecoration(
                                color: whitePrimary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),
          // Divider or Seprator Line
          Container(
            margin: const EdgeInsets.only(
              right: (5),
            ),
            height: (0.5),
            decoration: const BoxDecoration(
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: greyShadow,
              highlightColor: whitePrimary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: setWidgetHeight(30),
                    width: setWidgetWidth(60),
                    decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                  Container(
                    height: setWidgetHeight(30),
                    width: setWidgetWidth(60),
                    decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                  Container(
                    height: setWidgetHeight(30),
                    width: setWidgetWidth(60),
                    decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                  Container(
                    height: setWidgetHeight(30),
                    width: setWidgetWidth(60),
                    decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
