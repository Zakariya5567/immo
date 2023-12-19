import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/view/home_screen/components/home_toggle_button.dart';
import 'package:immo/view/widgets/sizedbox_width.dart';
import 'package:provider/provider.dart';

import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/images.dart';
import '../../filter_screen/components/select_city_dialog.dart';

// ignore: must_be_immutable
class HomeSearchWidget extends StatelessWidget {
  HomeSearchWidget(
      {super.key, required this.controller, required this.scaffoldKey});
  HomePageProvider controller = HomePageProvider();
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Container(
          height: setWidgetHeight(120),
          width: displayWidth(context),
          decoration: const BoxDecoration(
              color: bluePrimary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: setWidgetWidth(20),
              vertical: setWidgetHeight(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: setWidgetHeight(55),
                  decoration: const BoxDecoration(
                      color: whitePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: setWidgetWidth(20)),
                        child: Row(
                          children: [
                            Image.asset(
                              Images.iconSearch,
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: setWidgetWidth(10)),
                              child: Text(
                                translate(context, language.languageCode,
                                    searchHere)!,
                                style: textStyle(
                                    fontSize: 16,
                                    color: greyLight,
                                    fontFamily: satoshiMedium),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          height: setWidgetHeight(45),
                          width: setWidgetWidth(120),
                          decoration: const BoxDecoration(
                            color: orangeLight,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const HomeToggleButton(),
                        ),
                      ),
                    ],
                  ).onPress(() {
                    debugPrint("pressed");
                    Future.delayed(Duration.zero, () {
                      Provider.of<FilterScreenProvider>(context, listen: false)
                          .setIsEdit(0);
                      Navigator.of(context)
                          .pushNamed(RouterHelper.filterScreen);
                    });
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        Images.iconCurrentLocation,
                        width: setWidgetHeight(20),
                        height: setWidgetHeight(20),
                      ),
                      WidthSizedBox(width: .02),
                      Text(
                        controller.selectedCity == null
                            ? translate(
                                context, language.languageCode, selectCityName)!
                            : controller.selectedCity!,
                        style: textStyle(
                            fontSize: 12,
                            color: whitePrimary,
                            fontFamily: satoshiMedium),
                      ),
                      WidthSizedBox(width: 0.01),
                      Image.asset(
                        Images.iconNext,
                        width: 10,
                        height: 12,
                      ),
                    ],
                  ).onPress(() {
                    controller.clearSearch();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: whitePrimary,
                      // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                      clipBehavior: Clip.antiAlias,
                      // set shape to make top corners rounded
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.vertical,
                            ),
                            child: SelectCityDialog(
                              isHome: 1,
                              scaffoldKey: scaffoldKey,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
