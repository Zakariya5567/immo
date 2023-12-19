import 'package:flutter/material.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/provider/language_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helper/routes_helper.dart';
import '../../../utils/api_url.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';

// ignore: must_be_immutable
class ImageSection extends StatefulWidget {
  ImageSection({super.key, 
    required this.controller,
    required this.languageProvider,
    required this.detailImages,
    required this.isFavourite,
    required this.id,
    required this.createdBy,
  });
  HomePageProvider controller;
  LanguageProvider languageProvider;
  List? detailImages;
  bool? isFavourite;
  int? id;
  String createdBy;

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageScrollListener();
  }

  pageScrollListener() {
    pageController.addListener(() {
      widget.controller.setImageSelectedIndex(pageController.page!.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setWidgetHeight(280),
      width: double.infinity,
      child: Stack(children: [
        SizedBox(
          height: setWidgetHeight(270),
          child: PageView.builder(
              controller: pageController,
              itemCount: widget.detailImages!.isEmpty
                  ? 1
                  : widget.detailImages!.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, int index) {
                // Active page
                return Image(
                    fit: BoxFit.cover,
                    image: widget.detailImages!.isEmpty
                        ? const NetworkImage(
                            "https://www.re-expozitia.ro/wp-content/themes/qube/assets/images/no-image/No-Image-Found-400x264.png"
                            )
                        : NetworkImage(
                            widget.detailImages![index].file!,
                          ));
              }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: setWidgetWidth(10),
                  vertical: 2,
                ),
                height: setWidgetHeight(12),
                decoration: BoxDecoration(
                  color: greyPrimary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.detailImages!.isEmpty
                        ? 1
                        : widget.detailImages!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return (position == widget.controller.imageSelectedIndex
                          ? _indicator(true)
                          : _indicator(false));
                    }),
              )),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
                top: setWidgetHeight(50), left: setWidgetWidth(20)),
            child: const ImageIcon(
              AssetImage(
                Images.arrowBackIcon,
              ),
              color: whitePrimary,
              size: 23,
            ).onPress(
              () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.only(right: setWidgetWidth(25)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  width: setWidgetWidth(38),
                  height: setWidgetWidth(38),
                  decoration: const BoxDecoration(
                      color: whitePrimary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: greyShadow,
                          blurRadius: 5,
                          offset: Offset(1, 5), // Shadow position
                        ),
                      ]),
                  child: const Center(
                    child: ImageIcon(
                      AssetImage(
                        Images.iconShare,
                      ),
                      size: 18,
                    ),
                  ),
                ).onPress(() {
                  Share.share("${ApiUrl.propertyShareUrl}${widget.id!}");
                }),
                marginHeight(8),
                widget.controller.userId == widget.createdBy
                    ? const SizedBox()
                    : Container(
                        width: setWidgetWidth(38),
                        height: setWidgetWidth(38),
                        decoration: const BoxDecoration(
                            color: whitePrimary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: greyShadow,
                                blurRadius: 5,
                                offset: Offset(1, 5), // Shadow position
                              ),
                            ]),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              widget.controller
                                  .favouriteUnFavourite(context,
                                      RouterHelper.adDetailsScreen, widget.id!)
                                  .then((value) {
                                if (widget.controller.favouriteUnFavouriteModel
                                        .error ==
                                    false) {
                                  widget.controller
                                      .setPropertyFavouriteIconById(
                                          widget.id!, context);
                                }
                              });
                            },
                            child: Image.asset(
                              widget.isFavourite == true
                                  ? Images.iconFavFilledRed
                                  : Images.iconFavUnfilled,
                              width: setWidgetWidth(22),
                              height: setWidgetHeight(20),
                            ),
                          ),
                        ),
                      )
              ])),
        ),
      ]),
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10),
        margin: EdgeInsets.symmetric(horizontal: setWidgetWidth(1)),
        height: isActive ? 10 : 6.0,
        width: isActive ? 10 : 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? whitePrimary : whitePrimary.withOpacity(0.5),
        ),
      ),
    );
  }
}
