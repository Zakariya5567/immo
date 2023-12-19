import 'package:flutter/material.dart';
import 'package:immo/localization/app_localizations.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../provider/filter_screen_provider.dart';
import '../../../provider/language_provider.dart';

class SortRadioList extends StatelessWidget {
  const SortRadioList({
    super.key,
    required this.controller,
    required this.list,
    required this.scaffoldKey,
  });
  final List<String> list;
  final FilterScreenProvider controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: setWidgetHeight(40),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (_, index) {
        String value = list[index];
        return GestureDetector(
          onTap: (() {
            Navigator.of(scaffoldKey.currentContext!).pop();
            controller.setCurrentIndexSortRadioList(
                index, scaffoldKey.currentContext!);
          }),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<LanguageProvider>(
                builder: (context, language, child) {
                  return Text(
                    translate(context, language.languageCode, value)!,
                    style: textStyle(
                        fontSize: 20,
                        color: blackLight,
                        fontFamily: satoshiRegular),
                  );
                },
              ),
              Container(
                width: setWidgetWidth(24),
                height: setWidgetHeight(24),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: controller.currentIndexSortRadioList == index
                          ? bluePrimary
                          : greyLight,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
