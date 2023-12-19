import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../../../utils/size.dart';

class ShimmerFavourite extends StatelessWidget {
  const ShimmerFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return const ShimmerFavoriteCard();
      },
    );
  }
}

class ShimmerFavoriteCard extends StatelessWidget {
  const ShimmerFavoriteCard({super.key});

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
      height: setWidgetHeight(165),
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
      child: Row(
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
                            borderRadius: BorderRadius.all(Radius.circular(3)),
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
                            borderRadius: BorderRadius.all(Radius.circular(3)),
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
                            borderRadius: BorderRadius.all(Radius.circular(3)),
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
    );
  }
}
