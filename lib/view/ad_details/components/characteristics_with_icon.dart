// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:immo/utils/api_url.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/view/widgets/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/launch_url.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class CharacteristicsWithIcon extends StatefulWidget {
  CharacteristicsWithIcon(
      {super.key,
      required this.controller,
      required this.language,
      required this.id,
      required this.slug});
  HomePageProvider controller;
  LanguageProvider language;
  String? slug;
  int? id;

  @override
  State<CharacteristicsWithIcon> createState() =>
      _CharacteristicsWithIconState();
}

class _CharacteristicsWithIconState extends State<CharacteristicsWithIcon> {
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
        marginHeight(20),
        getHeading(
            translate(context, widget.language.languageCode, characteristics)!),
        marginHeight(20),
        Row(
          children: [
            Expanded(
                child: SizedBox(
              child: Row(
                children: [
                  Image.asset(
                    Images.iconPdfRounded,
                    width: setWidgetWidth(40),
                    height: setWidgetWidth(40),
                  ),
                  marginWidth(10),
                  Text(
                    translate(context, widget.language.languageCode, pdf)!,
                    style: textStyle(
                        fontSize: 16,
                        color: bluePrimary,
                        fontFamily: satoshiRegular),
                  )
                ],
              ),
            ).onPress(() async {
              if (data.documents!.pdfFiles!.isNotEmpty) {
                String pdfurl = data.documents!.pdfFiles![0].file!;

                await _prepareSaveDir();
                Future.delayed(Duration.zero, () {
                  widget.controller.downloadCsvFile(context,
                      RouterHelper.adDetailsScreen, pdfurl, _localPath);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(context, noFileAvalilableToDownload, 1));
              }
            })),
            Expanded(
                child: SizedBox(
              child: Row(
                children: [
                  Image.asset(
                    Images.iconFacebookRounded,
                    width: setWidgetWidth(40),
                    height: setWidgetWidth(40),
                  ),
                  marginWidth(10),
                  Text(
                    translate(context, widget.language.languageCode, facebook)!,
                    style: textStyle(
                        fontSize: 16,
                        color: bluePrimary,
                        fontFamily: satoshiRegular),
                  )
                ],
              ),
            ).onPress(() async {
              try {
                String message = "${ApiUrl.propertyShareUrl}${widget.slug!}";
                String messangerURL =
                    'fb-messenger://share/?link=${Uri.encodeComponent(message)}';
                if (await canLaunchUrl(Uri.parse(messangerURL))) {
                  launchInAppURL(messangerURL);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(context, installlMessanger, 1));
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(context, installlMessanger, 1));
              }
            })),
          ],
        ),
        marginHeight(10),
        Row(
          children: [
            Expanded(
                child: SizedBox(
              child: Row(
                children: [
                  Image.asset(
                    Images.iconPrintRounded,
                    width: setWidgetWidth(40),
                    height: setWidgetWidth(40),
                  ),
                  marginWidth(10),
                  Text(
                    translate(
                        context, widget.language.languageCode, printText)!,
                    style: textStyle(
                        fontSize: 16,
                        color: bluePrimary,
                        fontFamily: satoshiRegular),
                  )
                ],
              ),
            ).onPress(() async {
              if (data.documents!.pdfFiles!.isNotEmpty) {
                String pdfurl = data.documents!.pdfFiles![0].file!;

                await _prepareSaveDir();
                Future.delayed(Duration.zero, () {
                  widget.controller.downloadCsvFile(context,
                      RouterHelper.adDetailsScreen, pdfurl, _localPath);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(context, noFileAvalilableToDownload, 1));
              }
            })),
            Expanded(
                child: SizedBox(
              child: Row(
                children: [
                  Image.asset(
                    Images.iconWhatsappRounded,
                    width: setWidgetWidth(40),
                    height: setWidgetWidth(40),
                  ),
                  marginWidth(10),
                  Text(
                    translate(context, widget.language.languageCode, whatsapp)!,
                    style: textStyle(
                        fontSize: 16,
                        color: bluePrimary,
                        fontFamily: satoshiRegular),
                  )
                ],
              ),
            ).onPress(() async {
              try {
                String message = "${ApiUrl.propertyShareUrl}${widget.slug!}";
                String whatsappURL =
                    "whatsapp://send?text=${Uri.encodeComponent(message)}";
                if (await canLaunchUrl(Uri.parse(whatsappURL))) {
                  launchInAppURL(whatsappURL);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(context, installWhatsapp, 1));
                }
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(customSnackBar(context, installWhatsapp, 1));
              }
            })),
          ],
        ),
        marginHeight(10),
        Row(
          children: [
            //Email
            Expanded(
              child: SizedBox(
                child: Row(
                  children: [
                    Image.asset(
                      Images.iconEmailRounded,
                      width: setWidgetWidth(40),
                      height: setWidgetWidth(40),
                    ),
                    marginWidth(10),
                    Text(
                      translate(
                          context, widget.language.languageCode, labelEmail)!,
                      style: textStyle(
                          fontSize: 16,
                          color: bluePrimary,
                          fontFamily: satoshiRegular),
                    )
                  ],
                ),
              ).onPress(() async {
                String body = Uri.encodeComponent(
                    "${ApiUrl.propertyShareUrl}${widget.slug!}");
                launchInAppURL("mailto:?subject=&body=$body");
              }),
            ),
            Expanded(
              child: SizedBox(
                child: Row(
                  children: [
                    Image.asset(
                      Images.iconCopyLinkRounded,
                      width: setWidgetWidth(40),
                      height: setWidgetWidth(40),
                    ),
                    marginWidth(10),
                    Text(
                      translate(
                          context, widget.language.languageCode, copyLink)!,
                      style: textStyle(
                          fontSize: 16,
                          color: bluePrimary,
                          fontFamily: satoshiRegular),
                    )
                  ],
                ),
              ).onPress(() async {
                try {
                  await FlutterClipboard.copy(
                      "${ApiUrl.propertyShareUrl}${widget.slug}");
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(context, copiedToClipboard, 0));
                } catch (e) {
                  debugPrint('saved');
                }
              }),
            )
          ],
        )
      ],
    );
  }
}
