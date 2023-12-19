import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';

class ShimmerNotification extends StatelessWidget {
  const ShimmerNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return const ShimmerNotificationCard();
      },
    );
  }
}

class ShimmerNotificationCard extends StatelessWidget {
  const ShimmerNotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyShadow,
      highlightColor: whitePrimary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: setWidgetHeight(82),
          decoration: BoxDecoration(border: Border.all(color: whitePrimary)),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: setWidgetWidth(50),
            ),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image(
                image: const AssetImage(
                  Images.iconNotificationGrey,
                ),
                width: setWidgetWidth(54),
                height: setWidgetHeight(54),
              ),
              marginWidth(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: setWidgetHeight(20),
                      width: setWidgetWidth(250),
                      color: whitePrimary,
                    ),
                    marginHeight(5),
                    Container(
                      height: setWidgetHeight(15),
                      width: setWidgetWidth(220),
                      color: whitePrimary,
                    ),
                    marginHeight(5),
                    Container(
                      height: setWidgetHeight(13),
                      width: setWidgetWidth(200),
                      color: whitePrimary,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
