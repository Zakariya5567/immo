import 'package:flutter/material.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/view/ad_details/components/key_value_item.dart';
import 'package:immo/view/ad_details/components/report_an_ad.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class ReportSection extends StatelessWidget {
  ReportSection(
      {super.key, required this.controller,
      required this.language,
      required this.scaffoldKey,
      required this.formKey});
  HomePageProvider controller;
  LanguageProvider language;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final data = controller.propertiesDetailModel.data!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        marginHeight(20),
        getHeading(
            translate(context, language.languageCode, doesThisAdSuspicious)!),
        marginHeight(15),
        getKeyValueItem(
            translate(context, language.languageCode, immoExperte24)!,
            "1234567"),
        getKeyValueItem(translate(context, language.languageCode, reference)!,
            "123456789000"),
        marginHeight(10),
        Text(
          translate(context, language.languageCode, reportTheAd)!,
          style: const TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: satoshiRegular,
              fontSize: 14,
              color: bluePrimary),
        ).onPress(() {
          controller.clearTextField();
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
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                    child: ReportAnAd(
                  formKey: formKey,
                  scaffoldKey: scaffoldKey,
                  id: data.id!,
                )),
              );
            },
          );
        }),
      ],
    );
  }
}
