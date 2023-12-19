import 'package:flutter/material.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/provider/language_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';

import '../../../utils/images.dart';
import '../../../utils/size.dart';

// ignore: must_be_immutable
class PreviewImageSection extends StatefulWidget {
  PreviewImageSection(
      {super.key, required this.controller,
      required this.languageProvider,
      required this.detailImages,
      required this.id});
  HomePageProvider controller;
  LanguageProvider languageProvider;
  List? detailImages;
  int? id;

  @override
  State<PreviewImageSection> createState() => _PreviewImageSectionState();
}

class _PreviewImageSectionState extends State<PreviewImageSection> {
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
                          "https://www.re-expozitia.ro/wp-content/themes/qube/assets/images/no-image/No-Image-Found-400x264.png")
                      : NetworkImage(
                          widget.detailImages![index].file!,
                        ),
                );
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
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: setWidgetHeight(30),
              right: setWidgetWidth(25),
            ),
            child: const ImageIcon(
              AssetImage(
                Images.iconClose,
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
