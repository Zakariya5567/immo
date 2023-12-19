import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/post_an_ad_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/size.dart';

class AdUploadPDF extends StatefulWidget {
  const AdUploadPDF({super.key, required this.pdfsFile, required this.index});
  // ignore: prefer_typing_uninitialized_variables
  final pdfsFile;
  final int index;

  @override
  State<AdUploadPDF> createState() => _AdUploadPDFState();
}

class _AdUploadPDFState extends State<AdUploadPDF> {
  bool isEditingEnable = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Row(
          children: [
            Consumer<PostAnAdProvider>(
              builder: (context, controller, child) {
                return Container(
                  height: setWidgetHeight(165),
                  width: setWidgetWidth(230),
                  padding: EdgeInsets.only(
                      right: setWidgetWidth(8), top: setWidgetHeight(8)),
                  decoration: BoxDecoration(
                    color: whiteShadow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          marginWidth(20),
                          Image(
                            image: const AssetImage(Images.pdfFile),
                            width: setWidgetWidth(25),
                            height: setWidgetHeight(25),
                          ),
                          marginWidth(10),
                          // Text Field for Editing pdf name
                          isEditingEnable == true
                              ? Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      width: setWidgetWidth(120),
                                      height: setWidgetHeight(30),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(1)),
                                        border: Border.all(
                                          color: greyLight,
                                        ),
                                      ),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        textInputAction: TextInputAction.done,
                                        maxLines: 1,
                                        controller:
                                            controller.editPdfNameController,
                                        keyboardType: TextInputType.name,
                                        scrollController: ScrollController(
                                            keepScrollOffset: true),
                                        onChanged: (value) {
                                          controller.editPdfNameController
                                              .text = value;
                                          controller.editPdfNameController
                                                  .selection =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: controller
                                                          .editPdfNameController
                                                          .text
                                                          .length));
                                        },
                                      ),
                                    ),
                                    const Icon(
                                      Icons.check,
                                      color: bluePrimary,
                                      size: 20,
                                    ).onPress(() {
                                      setState(() {
                                        Future.delayed(Duration.zero, () {
                                          controller.updatePDF(
                                              context,
                                              RouterHelper
                                                  .postAdUploadingDataScreen,
                                              widget.pdfsFile.id!);
                                        }).then(
                                            (value) => isEditingEnable = false);
                                      });
                                    })
                                  ],
                                )
                              : SizedBox(
                                  width: setWidgetWidth(140),
                                  child: Text(
                                    widget.pdfsFile.name!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: blackPrimary,
                                      fontFamily: satoshiRegular,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const ImageIcon(
                                AssetImage(Images.iconEditBorder),
                                size: 20,
                                color: bluePrimary,
                              ),
                              Text(
                                translate(
                                    context, language.languageCode, editPDF)!,
                                style: textStyle(
                                  fontSize: 10,
                                  color: bluePrimary,
                                  fontFamily: satoshiRegular,
                                ),
                              ),
                            ],
                          ).onPress(() {
                            setState(() {
                              isEditingEnable = true;
                              controller.editPdfNameController.text =
                                  widget.pdfsFile.name!.split('.')[0];
                            });
                          }),
                          marginWidth(40),
                          Column(
                            children: [
                              const ImageIcon(
                                AssetImage(Images.trashBin),
                                size: 20,
                                color: bluePrimary,
                              ),
                              Text(
                                translate(
                                    context, language.languageCode, remove)!,
                                style: textStyle(
                                  fontSize: 10,
                                  color: bluePrimary,
                                  fontFamily: satoshiRegular,
                                ),
                              ),
                            ],
                          ).onPress(() {
                            Future.delayed(Duration.zero, () async {
                              await controller.deleteFile(
                                  context,
                                  RouterHelper.postAdUploadingDataScreen,
                                  widget.pdfsFile.fileType!,
                                  widget.pdfsFile.id!,
                                  widget.index);
                            });
                          }),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            marginWidth(20),
          ],
        );
      },
    );
  }
}
