import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../data/api_models/post_an_ad/step_one/step_one_category_model.dart';

class PropertyTypeWidget extends StatelessWidget {
  const PropertyTypeWidget({super.key, required this.list, required this.isHome});
  final List<CategoryData> list;
  final int isHome;

  @override
  Widget build(BuildContext context) {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    final filterScreenProvider =
        Provider.of<FilterScreenProvider>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, position) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: setWidgetWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: isHome == 1 &&
                          homePageProvider.propertySelectedIndex == position ||
                      isHome == 0 &&
                          filterScreenProvider.propertySelectedIndex == position
                  ? blueShadow
                  : greyShadow,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isHome == 1 &&
                            homePageProvider.propertySelectedIndex ==
                                position ||
                        isHome == 0 &&
                            filterScreenProvider.propertySelectedIndex ==
                                position
                    ? bluePrimary
                    : greyShadow,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: setWidgetWidth(15),
                vertical: setWidgetHeight(5),
              ),
              child: Center(
                child: Text(
                  list[position].title,
                  style: textStyle(
                    fontSize: 12,
                    color: isHome == 1 &&
                                homePageProvider.propertySelectedIndex ==
                                    position ||
                            isHome == 0 &&
                                filterScreenProvider.propertySelectedIndex ==
                                    position
                        ? bluePrimary
                        : greyLight,
                    fontFamily: satoshiMedium,
                  ),
                ),
              ),
            ),
          ).onPress(() {
            if (isHome == 1) {
              homePageProvider.setPropertySelectedIndex(index: position, newCategoryId: list[position].id);
              homePageProvider.getPropertyList(context,0,1, RouterHelper.homeScreen);
            } else if (isHome == 0) {
              filterScreenProvider.setPropertySelectedIndex(index: position,newCategoryId: list[position].id,context: context);
            } else {
              debugPrint(
                  "ISSUE PLEASE CHECK CODE ======================================>>>>>>>>>>>>>>>>>>");
            }
          }),
        );
      },
    );
  }
}
