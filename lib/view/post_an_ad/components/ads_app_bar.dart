// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../provider/post_an_ad_provider.dart';

// ignore: must_be_immutable
class AdsAppBar extends StatefulWidget implements PreferredSizeWidget {
  AdsAppBar(
      {super.key,
      required this.appBar,
      this.isSaveQuitHidden = false,
      required this.screen});
  final AppBar appBar;
  final String screen;
  bool isSaveQuitHidden;

  @override
  State<AdsAppBar> createState() => _AdsAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _AdsAppBarState extends State<AdsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostAnAdProvider>(
      builder: (context, postAnAdProvider, child) {
        return Consumer<LanguageProvider>(
          builder: (context, language, child) {
            return AppBar(
              backgroundColor: bluePrimary,
              // Back Button
              leading: IconButton(
                onPressed: () {
                  if (widget.screen == propertyDetails) {
                    postAnAdProvider.clearAllPostAdScreen();
                  }
                  Navigator.pop(context);
                },
                icon: const ImageIcon(
                  AssetImage(Images.arrowBackIcon),
                  size: 23,
                ),
              ),
              // Title of Post an Ad Screen 1
              title: Text(
                translate(context, language.languageCode, postAnAd)!,
                overflow: TextOverflow.ellipsis,
              ),
              centerTitle: false,
              titleTextStyle: textStyle(
                fontSize: 18,
                color: whitePrimary,
                fontFamily: satoshiMedium,
              ),
              actions: widget.isSaveQuitHidden == false
                  ? [
                      //Save & quit Button

                      TextButton(
                        onPressed: () {
                          if (widget.screen == details) {
                            // Post An Ad 1st Step (Property Main Detatil)
                            if (postAnAdProvider
                                    .isRequiredFieldsEmpty(context) ==
                                false) {
                              Future.delayed(Duration.zero, () async {
                                await postAnAdProvider.saveProperty(context,
                                    RouterHelper.postAdMainDetailSecondScreen);
                                if (postAnAdProvider
                                        .savePropertiesModel.error ==
                                    false) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      RouterHelper.myAdsListScreen,
                                      (route) => false);
                                }
                              }).then((value) =>
                                  postAnAdProvider.clearAllPostAdScreen());
                            }
                          } else if (widget.screen == imagesVideosPDFs) {
                            // Post An Ad 2nd Step (Details)
                            Future.delayed(Duration.zero, () async {
                              await postAnAdProvider.saveDetails(
                                  context, RouterHelper.postAdDimensionScreen);
                              if (postAnAdProvider.saveDetailsModel.error ==
                                  false) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    RouterHelper.myAdsListScreen,
                                    (route) => false);
                              }
                            }).then((value) =>
                                postAnAdProvider.clearAllPostAdScreen());
                          } else if (widget.screen == contacts) {
                            // Post An Ad 3rd Step (Documents)
                            if (postAnAdProvider.isYoutubeLinkValid(postAnAdProvider.youtubeLink1Controller.text, context) &&
                                postAnAdProvider.isYoutubeLinkValid(
                                    postAnAdProvider
                                        .youtubeLink2Controller.text,
                                    context) &&
                                postAnAdProvider.isWebLinkValid(
                                    postAnAdProvider.webLinkController.text,
                                    context)) {
                              Future.delayed(Duration.zero, () async {
                                await postAnAdProvider.saveDocuments(context,
                                    RouterHelper.postAdUploadingDataScreen);
                                if (postAnAdProvider.saveDocModel.error ==
                                    false) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      RouterHelper.myAdsListScreen,
                                      (route) => false);
                                }
                              }).then((value) =>
                                  postAnAdProvider.clearAllPostAdScreen());
                            }
                          } else if (widget.screen == order) {
                            // Post An Ad 4th Step (Contact)
                            if (postAnAdProvider
                                .isContactFormRequiredFieldsNotEmpty(context)) {
                              Future.delayed(Duration.zero, () async {
                                await postAnAdProvider.saveContactForm(context,
                                    RouterHelper.postAdContactsDetailScreen);
                                if (postAnAdProvider
                                        .saveContactFormModel.error ==
                                    false) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      RouterHelper.myAdsListScreen,
                                      (route) => false);
                                }
                              }).then((value) =>
                                  postAnAdProvider.clearAllPostAdScreen());
                            }
                          } else if (widget.screen == finish) {
                            // Post An Ad 5th Step (order)
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterHelper.myAdsListScreen,
                                  (route) => false);
                            }).then((value) =>
                                postAnAdProvider.clearAllPostAdScreen());
                          } else if (widget.screen == publish) {
                            // Post An Ad 6th Step (Finish)
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterHelper.myAdsListScreen,
                                  (route) => false);
                            }).then((value) =>
                                postAnAdProvider.clearAllPostAdScreen());
                          }
                        },
                        child: Text(
                          translate(context, language.languageCode, saveQuit)!,
                          style: textStyle(
                            fontSize: 12,
                            color: whitePrimary,
                            fontFamily: satoshiMedium,
                          ),
                        ),
                      ),

                      marginWidth(24),
                    ]
                  : [],
            );
          },
        );
      },
    );
  }
}
