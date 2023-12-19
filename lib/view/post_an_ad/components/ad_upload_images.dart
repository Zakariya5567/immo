// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/localization/app_localizations.dart';
import 'package:immo/provider/language_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../provider/post_an_ad_provider.dart';
import '../../../utils/size.dart';

class UploadedImages extends StatefulWidget {
  const UploadedImages(
      {super.key, required this.imageModel, required this.index});
  // ignore: prefer_typing_uninitialized_variables
  final imageModel;
  final int index;

  @override
  State<UploadedImages> createState() => _UploadedImagesState();
}

class _UploadedImagesState extends State<UploadedImages> {
  Future<File> urlToFile(String imageUrl, String fileExt, bool isNet) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/$fileExt.jpg');
    if (!isNet) return file;
    Uri uri = Uri.parse(imageUrl);
    http.Response response = await http.get(uri);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  cropImage(String url, int id, int index, String languageCode) async {
    CroppedFile? croppedFile;

    Future.delayed(Duration.zero, () async {
      File imageFile = await urlToFile(url, 'New Image', true);
      croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: translate(context, languageCode, cropper),
              toolbarColor: blackPrimary,
              toolbarWidgetColor: whitePrimary,
              activeControlsWidgetColor: bluePrimary,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: translate(context, languageCode, cropImag),
            cancelButtonTitle: translate(context, languageCode, cancel),
            doneButtonTitle: translate(context, languageCode, save),
            minimumAspectRatio: 1.0,
            aspectRatioLockEnabled: false,
          ),
        ],
      );
      if (croppedFile != null) {
        File imge = File(croppedFile!.path);
        final postAnAdProvider =
            Provider.of<PostAnAdProvider>(context, listen: false);
        postAnAdProvider.setImage(imge);

        await postAnAdProvider.updateImage(
            context, RouterHelper.postAdUploadingDataScreen, id, index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostAnAdProvider>(
      builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: setWidgetHeight(165),
              width: setWidgetWidth(165),
              padding: EdgeInsets.only(
                right: setWidgetWidth(8),
                top: setWidgetHeight(8),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.imageModel.file!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: setWidgetHeight(24),
                    width: setWidgetWidth(24),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: whitePrimary),
                    child: const Align(
                      alignment: Alignment.center,
                      child: ImageIcon(
                        AssetImage(Images.trashBin),
                        size: 12,
                        color: bluePrimary,
                      ),
                    ),
                  ).onPress(() {
                    Future.delayed(Duration.zero, () async {
                      await controller.deleteFile(
                          context,
                          RouterHelper.postAdUploadingDataScreen,
                          widget.imageModel.fileType!,
                          widget.imageModel.id!,
                          widget.index);
                    });
                  }),
                  marginHeight(12),
                  Consumer<LanguageProvider>(
                    builder: (context, language, child) {
                      return InkWell(
                        onTap: () {
                          cropImage(
                              widget.imageModel.file!,
                              widget.imageModel.id!,
                              widget.index,
                              language.languageCode);
                        },
                        child: Container(
                          height: setWidgetHeight(24),
                          width: setWidgetWidth(24),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: whitePrimary),
                          child: const Align(
                            alignment: Alignment.center,
                            child: ImageIcon(
                              AssetImage(Images.viewIcon),
                              size: 12,
                              color: bluePrimary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            marginWidth(20),
          ],
        );
      },
    );
  }
}
