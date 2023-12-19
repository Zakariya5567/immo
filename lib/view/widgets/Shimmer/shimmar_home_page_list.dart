// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../../../utils/size.dart';

class ShimmarPageViewList extends StatefulWidget {
  const ShimmarPageViewList({Key? key}) : super(key: key);

  @override
  State<ShimmarPageViewList> createState() => _ShimmarPageViewListState();
}

class _ShimmarPageViewListState extends State<ShimmarPageViewList> {
  final PageController ctrl = PageController(
    viewportFraction: 0.55,
  );

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      int pos = ctrl.page!.round();
      if (currentPage != pos) {
        {
          setState(() {
            currentPage = pos;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: setWidgetHeight(290),
      child: PageView.builder(
          controller: ctrl,
          itemCount: 8,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, int index) {
            // Active page
            bool active = index == currentPage;
            return _buildStoryPage(active, context);
          }),
    );
  }
}

_buildStoryPage(bool active, BuildContext context) {
  // Animated Properties
  final double blur = active ? 10 : 5;
  final double offset = active ? 5 : 2;
  final double top = active ? 0 : setWidgetHeight(50);

  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeOutQuint,
    margin: EdgeInsets.only(top: top, bottom: setWidgetHeight(5), right: setWidgetWidth(10)),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: greyShadow,
              blurRadius: blur,
              offset: Offset(offset, offset))
        ]),
    child: ShimmerPropertyCard(active),
  );
}

class ShimmerPropertyCard extends StatelessWidget {
  bool isActive;

  ShimmerPropertyCard(this.isActive);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidgetWidth(230),
      height: setWidgetHeight(290),
      padding: EdgeInsets.all(setWidgetWidth(6)),
      decoration: const BoxDecoration(
          color: whitePrimary,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: greyShadow,
                  highlightColor: whitePrimary,
                  child: Container(
                    width: setWidgetWidth(230),
                    decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: setWidgetHeight(13), left: setWidgetWidth(10)),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Shimmer.fromColors(
                      baseColor: greyShadow,
                      highlightColor: whitePrimary,
                      child: Container(
                        width: setWidgetWidth(isActive ? 58 : 50),
                        height: setWidgetHeight(isActive ? 18 : 16),
                        decoration: BoxDecoration(
                          color: whitePrimary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: setWidgetHeight(7)),
                  Shimmer.fromColors(
                    baseColor: greyShadow,
                    highlightColor: whitePrimary,
                    child: Container(
                      height: setWidgetHeight(20),
                      width: setWidgetWidth(190),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: setWidgetHeight(2)),
                  Shimmer.fromColors(
                    baseColor: greyShadow,
                    highlightColor: whitePrimary,
                    child: Container(
                      height: setWidgetHeight(20),
                      width: setWidgetWidth(150),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: setWidgetHeight(2)),
                  Shimmer.fromColors(
                    baseColor: greyShadow,
                    highlightColor: whitePrimary,
                    child: Container(
                      height: setWidgetHeight(20),
                      width: setWidgetWidth(170),
                      decoration: const BoxDecoration(
                        color: whitePrimary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: setWidgetHeight(isActive ? 5 : 5)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: greyShadow,
                        highlightColor: whitePrimary,
                        child: Container(
                          height: setWidgetHeight(20),
                          width: setWidgetWidth(150),
                          decoration: const BoxDecoration(
                            color: whitePrimary,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: greyShadow,
                        highlightColor: whitePrimary,
                        child: Container(
                          height: setWidgetHeight(30),
                          width: setWidgetWidth(30),
                          decoration: const BoxDecoration(
                            color: whitePrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: setWidgetHeight(isActive ? 5 : 8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: greyShadow,
                                highlightColor: whitePrimary,
                                child: Container(
                                  height: setWidgetHeight(20),
                                  width: setWidgetWidth(200),
                                  decoration: const BoxDecoration(
                                    color: whitePrimary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: setWidgetHeight(6),
                          ),
                          Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: greyShadow,
                                highlightColor: whitePrimary,
                                child: Container(
                                  height: setWidgetHeight(20),
                                  width: setWidgetWidth(200),
                                  decoration: const BoxDecoration(
                                    color: whitePrimary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
