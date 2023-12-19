import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/style.dart';

class SearchListBedroomSelection extends StatelessWidget {
  const SearchListBedroomSelection(
      {super.key, required this.totalItems, required this.isBedroom});
  final int totalItems;
  final int isBedroom;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: setWidgetWidth(20),
        crossAxisSpacing: setWidgetHeight(10),
        mainAxisExtent: setWidgetHeight(50),
      ),
      itemCount: totalItems,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, position) =>
          Consumer<FilterScreenProvider>(
        builder: (context, controller, child) {
          return Container(
            height: setWidgetHeight(45),
            decoration: BoxDecoration(
                color: isBedroom == 1 && controller.bedRoomIndex == position ||
                        isBedroom == 0 && controller.bathRoomIndex == position
                    ? blueLight
                    : greyShadow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isBedroom == 1 &&
                              controller.bedRoomIndex == position ||
                          isBedroom == 0 && controller.bathRoomIndex == position
                      ? bluePrimary
                      : greyShadow,
                )),
            child: Center(
              child: Text(
                position == (totalItems - 1)
                    ? "${position + 1}+"
                    : "${position + 1}",
                style: textStyle(
                    fontSize: 14,
                    color:
                        isBedroom == 1 && controller.bedRoomIndex == position ||
                                isBedroom == 0 &&
                                    controller.bathRoomIndex == position
                            ? bluePrimary
                            : greyLight,
                    fontFamily: satoshiMedium),
              ),
            ).onPress(() {
              if (isBedroom == 1) {
                controller.setBedRoomCurrentIndex(position, context);
              } else {
                controller.setBathRoomCurrentIndex(position, context);
              }
            }),
          );
        },
      ),
    );
  }
}
