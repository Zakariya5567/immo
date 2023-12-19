import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/view/widgets/Shimmer/property_type_shimmer.dart';
import 'package:immo/view/widgets/property_type.dart';
import 'package:provider/provider.dart';

import '../../../data/api_models/post_an_ad/step_one/step_one_category_model.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';

class PropertyTypeFilter extends StatelessWidget {
  const PropertyTypeFilter(
      {Key? key, required this.list, required this.controller})
      : super(key: key);
  final List<CategoryData> list;
  final FilterScreenProvider controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: setWidgetWidth(24), top: setWidgetHeight(24)),
              child: Row(
                children: [
                  Image.asset(
                    Images.iconProperty,
                    width: setWidgetWidth(24),
                    height: setWidgetHeight(24),
                  ),
                  SizedBox(
                    width: setWidgetWidth(15),
                  ),
                  Text(translate(context, language.languageCode, propertyType)!,
                      style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiMedium))
                ],
              ),
            ),
            SizedBox(
              height: setWidgetHeight(17),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: setWidgetHeight(24)),
              child: SizedBox(
                height: setWidgetHeight(40),
                child: controller.isLoading == true
                    ? const PropertyTypeShimmer()
                    : PropertyTypeWidget(
                        list: list,
                        isHome: 0,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
