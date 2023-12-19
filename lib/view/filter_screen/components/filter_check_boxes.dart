import 'package:flutter/material.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../data/api_models/filter_model/ads_with_model.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';
import '../../widgets/Shimmer/ads_checkbox_shimmer.dart';

class FilterCheckBoxes extends StatelessWidget {
  const FilterCheckBoxes({super.key, required this.list, required this.controller});
  final List<AdsWithData> list;
  final FilterScreenProvider controller;

  @override
  Widget build(BuildContext context) {
    return controller.isLoading == true
        ? const AdsCheckBoxShimmer()
        : SizedBox(
            height: setWidgetHeight(260),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.setAdsWithCurrentIndex(index, context);
                        },
                        child: list[index].isSelected!
                            ? const Icon(
                                Icons.check_box,
                                size: 30.0,
                                color: bluePrimary,
                              )
                            : const ImageIcon(
                                AssetImage(
                                  Images.iconCheckboxUnfilled,
                                ),
                                size: 30,
                              ),
                      ),
                      marginWidth(13),
                      Consumer<LanguageProvider>(
                        builder: (context, language, child) {
                          return Text(
                            translate(context, language.languageCode,
                                list[index].value!)!,
                            style: textStyle(
                              fontSize: 14,
                              color: blackPrimary,
                              fontFamily: satoshiRegular,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
