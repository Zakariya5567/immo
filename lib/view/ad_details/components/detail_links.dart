import 'package:flutter/material.dart';
import 'package:immo/utils/extension/widget_extension.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/launch_url.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import 'heading_text.dart';

// ignore: must_be_immutable
class DetailsLinks extends StatelessWidget {
  DetailsLinks({super.key, required this.controller, required this.language});
  HomePageProvider controller;
  LanguageProvider language;

  @override
  Widget build(BuildContext context) {
    final data = controller.propertiesDetailModel.data!;
    return Column(
      children: [
        // Video Links
        marginHeight(20),
        Row(
          children: [
            getHeading(translate(context, language.languageCode, videoLinks)!),
          ],
        ),
        marginHeight(15),
        data.documents!.youtubeVideos![0] == null &&
                data.documents!.youtubeVideos![1] == null
            ? const Row(
                children: [
                  Text("_"),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: displayWidth(context) - 60,
                        child: data.documents!.youtubeVideos![0] == null
                            ? const Text("_")
                            : Text(
                                "${data.documents!.youtubeVideos![0]} ",
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    decoration: TextDecoration.underline,
                                    fontFamily: satoshiRegular,
                                    fontSize: 16,
                                    color: bluePrimary),
                              ).onPress(() {
                                launchInAppURL(data.documents!.youtubeVideos![0]
                                    .toString());
                              }),
                      ),
                    ],
                  ),
                  marginHeight(20),
                  Row(
                    children: [
                      SizedBox(
                        width: displayWidth(context) - 60,
                        child: data.documents!.youtubeVideos![1] == null
                            ? const Text("_")
                            : Text(
                                "${data.documents!.youtubeVideos![1]} ",
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    decoration: TextDecoration.underline,
                                    fontFamily: satoshiRegular,
                                    fontSize: 16,
                                    color: bluePrimary),
                              ).onPress(() {
                                launchInAppURL(data.documents!.youtubeVideos![1]
                                    .toString());
                              }),
                      ),
                    ],
                  ),
                ],
              ),
        marginHeight(20),
        Row(
          children: [
            getHeading(translate(context, language.languageCode, virtualTour)!),
          ],
        ),
        marginHeight(15),
        Row(
          children: [
            SizedBox(
              width: displayWidth(context) - 60,
              child: data.documents!.virtualTourLink == null
                  ? const Text("_")
                  : Text(
                      data.documents!.virtualTourLink == null
                          ? "_"
                          : "${data.documents!.virtualTourLink} ",
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          decoration: TextDecoration.underline,
                          fontFamily: satoshiRegular,
                          fontSize: 16,
                          color: bluePrimary),
                    ).onPress(() {
                      launchInAppURL(
                          data.documents!.virtualTourLink.toString());
                    }),
            ),
          ],
        ),
      ],
    );
  }
}
