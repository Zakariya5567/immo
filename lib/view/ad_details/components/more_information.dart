import 'dart:io';

import 'package:flutter/material.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/view/ad_details/components/key_value_item.dart';
import 'package:path_provider/path_provider.dart';

import '../../../helper/date_format.dart';
import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/custom_snackbar.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class MoreInformation extends StatefulWidget {
  MoreInformation(
      {super.key, required this.controller, required this.language});
  HomePageProvider controller;
  LanguageProvider language;

  @override
  State<MoreInformation> createState() => _MoreInformationState();
}

class _MoreInformationState extends State<MoreInformation> {
  late String _localPath;
  late TargetPlatform? platform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    debugPrint(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.controller.propertiesDetailModel.data!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        marginHeight(25),
        getHeading(
            translate(context, widget.language.languageCode, mainInformation)!),
        marginHeight(15),
        getKeyValueItem(
            translate(context, widget.language.languageCode, category)!,
            " ${data.propertyCategory!.title == null ? "_" : "${data.propertyCategory!.title}"}"),
        getKeyValueItem(
            translate(context, widget.language.languageCode, typeOfProperty)!,
            " ${data.propertySubCategory == null || data.propertySubCategory!.title == null ? "_" : "${data.propertySubCategory!.title}"}"),
        getKeyValueItem(
            translate(context, widget.language.languageCode, typeOfOwnership)!,
            " ${data.ownershipType == null ? "_" : data.ownershipType == 'for_rent' ? translate(context, widget.language.languageCode, forRent)! : translate(context, widget.language.languageCode, forSale)!}"),
        getKeyValueItem(
            translate(
                context, widget.language.languageCode, numberOfHousingUnits)!,
            " ${data.numberOfHousingUnits == null ? "_" : "${data.numberOfHousingUnits}"}"),
        getKeyValueItem(
            translate(context, widget.language.languageCode, numberOfRooms)!,
            " ${data.numberOfRooms == null ? "_" : "${data.numberOfRooms}"}"),
        getKeyValueItem(
            translate(context, widget.language.languageCode, livingSpace)!,
            " ${data.livingSpace == null ? "_" : "${data.livingSpace} m²"}"),
        getKeyValueItem(
            translate(context, widget.language.languageCode, plotArea)!,
            " ${data.plotArea == null ? "_" : "${data.plotArea}"}"),
        getKeyValueItem(
            translate(context, widget.language.languageCode, floor)!,
            " ${data.floor == null ? "_" : data.floortext.toString()}"),
        getKeyValueItem(
          translate(context, widget.language.languageCode, floorSpace)!,
          " ${data.floorSpace == null ? "_" : "${data.floorSpace} m²"}",
        ),
        getKeyValueItem(
          translate(context, widget.language.languageCode, availability)!,
          data.availability == null
              ? "_"
              : data.availability == "for_date"
                  ? "${dateFormat(data.date!)}"
                  : data.availability!.toString() == "immediately"
                      ? translate(context, widget.language.languageCode,
                          data.availability!.toString())!
                      : data.availability!.toString() == "on_request"
                          ? translate(
                              context, widget.language.languageCode, onRequest)!
                          : data.date.toString(),
        ),
        Padding(
          padding: EdgeInsets.only(top: setWidgetHeight(10)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                      translate(
                          context, widget.language.languageCode, pdfFileIfAny)!,
                      style: textStyle(
                          fontSize: 14,
                          color: greyLight,
                          fontFamily: satoshiRegular))),
              Expanded(
                  child: SizedBox(
                height: setWidgetHeight(50),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.documents!.pdfFiles!.length,
                    itemBuilder: (context, position) {
                      return Padding(
                          padding: EdgeInsets.only(right: setWidgetWidth(10)),
                          child: Image.asset(
                            Images.iconPdfRounded,
                            width: setWidgetWidth(40),
                            height: setWidgetWidth(40),
                          ).onPress(() async {
                            if (data.documents!.pdfFiles!.isNotEmpty) {
                              String pdfurl =
                                  data.documents!.pdfFiles![position].file!;
                              await _prepareSaveDir();
                              Future.delayed(Duration.zero, () {
                                widget.controller.downloadCsvFile(
                                    context,
                                    RouterHelper.adDetailsScreen,
                                    pdfurl,
                                    _localPath);
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                      context, noFileAvalilableToDownload, 1));
                            }
                          }));
                    }),
              ))
            ],
          ),
        )
      ],
    );
  }
}
