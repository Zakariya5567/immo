// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';
import '../../utils/constants.dart';
import '../../utils/size.dart';
import '../../utils/style.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/input_field.dart';
import 'components/ad_dashed_reactangle.dart';
import '../widgets/custom_button.dart';
import 'components/ad_steps_details.dart';
import 'components/ad_upload_images.dart';
import 'components/ad_upload_pdf.dart';
import 'components/ads_app_bar.dart';
import '../widgets/ads_bottom_buttons.dart';
import 'components/ads_screen_information_title.dart';

class UploadingData extends StatefulWidget {
  const UploadingData({super.key});

  @override
  State<UploadingData> createState() => _UploadingDataState();
}

class _UploadingDataState extends State<UploadingData> {
  FilePickerResult? result;
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

  pickFile(BuildContext context) async {
    final provider = Provider.of<PostAnAdProvider>(context, listen: false);
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result!.files.first.path!);
      //If flie size is greater then 12 MB(Mega Byte) then file will not be uploaded
      if (file.lengthSync() > maximumPdfFileSize) {
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar(context, fileSizeError, 1));
      } else {
        Future.delayed(Duration.zero, () {
          provider.setPDFFile(file);
        }).then(
          (value) async {
            await provider.savePDF(
                context, RouterHelper.postAdUploadingDataScreen);
          },
        );

        debugPrint("file: $file");
      }
    } else {
      debugPrint("result: $result");
      // User canceled the picker
    }
  }

  File? image;
  final picker = ImagePicker();
  void showPicker(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          didChangeDependencies();
          return SafeArea(
              child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: setWidgetHeight(20),
                  right: setWidgetWidth(20),
                  bottom: setWidgetWidth(10),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: setWidgetWidth(10), top: setWidgetHeight(10)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomIconButton(
                        icon: Images.iconClose,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        height: setWidgetWidth(20),
                        width: setWidgetWidth(20),
                        color: blackPrimary),
                  ),
                ),
              ),
              Consumer<PostAnAdProvider>(
                builder: (context, controller, child) {
                  return ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Consumer<LanguageProvider>(
                      builder: (context, language, child) {
                        return Text(
                          translate(context, language.languageCode, gallery)!,
                        );
                      },
                    ),
                    onTap: () {
                      final postAdProvider =
                          Provider.of<PostAnAdProvider>(context, listen: false);
                      imageFromGallery().then((value) async {
                        if (image != null) {
                          await controller.setImage(image!);
                          Future.delayed(Duration.zero, () async {
                            await postAdProvider.saveImage(context,
                                RouterHelper.postAdUploadingDataScreen);
                          }).then((value) => Navigator.pop(context));
                        } else {
                          Navigator.pop(context);
                        }
                      });
                    },
                  );
                },
              ),
              Consumer<PostAnAdProvider>(
                builder: (context, controller, child) {
                  return ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: Consumer<LanguageProvider>(
                      builder: (context, language, child) {
                        return Text(
                          translate(context, language.languageCode, camera)!,
                        );
                      },
                    ),
                    onTap: () {
                      final postAdProvider =
                          Provider.of<PostAnAdProvider>(context, listen: false);
                      imageFromCamera().then((value) async {
                        if (image != null) {
                          await controller.setImage(image!);
                          Future.delayed(Duration.zero, () async {
                            await postAdProvider.saveImage(context,
                                RouterHelper.postAdUploadingDataScreen);
                          }).then((value) => Navigator.pop(context));
                        } else {
                          Navigator.pop(context);
                        }
                      });
                      // .then((value) => controller.setImage(image!))
                      // .then((value) =>
                      //     Future.delayed(Duration.zero, () async {
                      //       await postAdProvider.saveImage(context,
                      //           RouterHelper.postAdUploadingDataScreen);
                      //     }).then((value) => Navigator.pop(context)));
                    },
                  );
                },
              ),
            ],
          ));
        });
  }

  Future imageFromCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1000,
        maxWidth: 1000,
        imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        debugPrint('$image');
        debugPrint(image!.path);
      } else {
        image = null;
        debugPrint('No image selected.');
      }
    });
  }

  Future imageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
      imageQuality: 50,
      requestFullMetadata: false,
    );
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        debugPrint('$image');
        debugPrint(image!.path);
      } else {
        image = null;
        debugPrint('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AdsAppBar(
            appBar: AppBar(),
            screen: contacts,
          ),
          body: Consumer<PostAnAdProvider>(
            builder: (context, controller, child) {
              return Consumer<LanguageProvider>(
                builder: (context, language, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: setWidgetWidth(30),
                                ),
                                child: Column(
                                  children: [
                                    AdsStepsDetails(
                                        steps: 3,
                                        stepTitle: translate(
                                            context,
                                            language.languageCode,
                                            imagesVideosPDFs)!,
                                        stepDescription:
                                            '${translate(context, language.languageCode, nextText)!}: ${translate(context, language.languageCode, contacts)!}'),
                                    marginHeight(28),
                                    InformationTitle(
                                        information: translate(context,
                                            language.languageCode, images)!),
                                    marginHeight(7),
                                    const InformationDetails(),
                                    marginHeight(28),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: setWidgetWidth(354),
                                              height: setWidgetHeight(140),
                                              color: whiteShadow,
                                              child: const DashedRectangle(
                                                color: greyPrimary,
                                                strokeWidth: 1.0,
                                                gap: 5.0,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const ImageIcon(
                                                  AssetImage(
                                                    Images.uploadIcon,
                                                  ),
                                                  size: 35,
                                                  color: greyLight,
                                                ),
                                                Text(
                                                  translate(
                                                      context,
                                                      language.languageCode,
                                                      uploadImageDescription)!,
                                                  style: textStyle(
                                                    fontSize: 10,
                                                    color: blackPrimary,
                                                    fontFamily: satoshiMedium,
                                                  ),
                                                ),
                                                marginHeight(16),
                                                CustomButton(
                                                  buttonHeight: 35,
                                                  buttonWidth: 122,
                                                  buttonColor: bluePrimary,
                                                  buttonTextColor: whitePrimary,
                                                  buttonText: translate(
                                                      context,
                                                      language.languageCode,
                                                      select)!,
                                                  onPressed: () {
                                                    if (controller
                                                            .imageModelList
                                                            .length <
                                                        17) {
                                                      showPicker(context);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              customSnackBar(
                                                                  context,
                                                                  imagesQuantityError,
                                                                  1));
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              marginHeight(20),
                              controller.imageModelList.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: setWidgetHeight(165),
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(
                                          left: setWidgetWidth(30),
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.imageModelList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return UploadedImages(
                                            // Images can be changed according to the image picker
                                            imageModel: controller
                                                .imageModelList[index],
                                            index: index,
                                          );
                                        },
                                      ),
                                    ),
                              marginHeight(28),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: setWidgetWidth(30),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          translate(context,
                                              language.languageCode, videos)!,
                                          style: textStyle(
                                            fontSize: 18,
                                            color: blackPrimary,
                                            fontFamily: satoshiMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    marginHeight(7),
                                    Row(
                                      children: [
                                        Text(
                                          translate(
                                              context,
                                              language.languageCode,
                                              videoDescription)!,
                                          style: textStyle(
                                            fontSize: 10,
                                            color: blackPrimary,
                                            fontFamily: satoshiMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    marginHeight(19),

                                    // Text Field Youtube Link 1
                                    CustomInputFormField(
                                      "${translate(context, language.languageCode, example)!}: https://www.youtube.com/kshffhyeue",
                                      TextInputType.url,
                                      controller.youtubeLink1Controller,
                                    ),
                                    marginHeight(8),

                                    // Text Field YouTube Link 2
                                    CustomInputFormField(
                                      "${translate(context, language.languageCode, example)!}: https://www.youtube.com/kshffhyeue",
                                      TextInputType.url,
                                      controller.youtubeLink2Controller,
                                    ),
                                    marginHeight(28),
                                    Row(
                                      children: [
                                        Text(
                                          translate(
                                              context,
                                              language.languageCode,
                                              virtualTour)!,
                                          style: textStyle(
                                            fontSize: 18,
                                            color: blackPrimary,
                                            fontFamily: satoshiMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    marginHeight(7),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: displayWidth(context) -
                                              setWidgetWidth(60),
                                          child: Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                virtualTourdescription)!,
                                            style: textStyle(
                                              fontSize: 14,
                                              color: blackPrimary,
                                              fontFamily: satoshiRegular,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    marginHeight(19),
                                    Row(
                                      children: [
                                        Text(
                                          translate(
                                              context,
                                              language.languageCode,
                                              virtualTourTextTitle)!,
                                          style: textStyle(
                                            fontSize: 10,
                                            color: blackPrimary,
                                            fontFamily: satoshiMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    marginHeight(7),

                                    // Text Field Virtual Tour Link
                                    CustomInputFormField(
                                      "${translate(context, language.languageCode, example)!}: http://360.casatour.in/kshffhyeue",
                                      TextInputType.url,
                                      controller.webLinkController,
                                    ),
                                    marginHeight(28),
                                    Row(
                                      children: [
                                        Text(
                                          translate(
                                              context,
                                              language.languageCode,
                                              documentPDF)!,
                                          style: textStyle(
                                            fontSize: 18,
                                            color: blackPrimary,
                                            fontFamily: satoshiMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    marginHeight(7),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: displayWidth(context) -
                                              setWidgetWidth(60),
                                          child: Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                documentPDFDescription)!,
                                            style: textStyle(
                                              fontSize: 13,
                                              color: blackPrimary,
                                              fontFamily: satoshiRegular,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    marginHeight(28),
                                    Row(
                                      children: [
                                        CustomButton(
                                          buttonHeight: 40,
                                          buttonWidth: 180,
                                          buttonColor: bluePrimary,
                                          buttonTextColor: whitePrimary,
                                          buttonText: translate(
                                              context,
                                              language.languageCode,
                                              uploadPDF)!,
                                          onPressed: () {
                                            if (controller.pdfModelList.length <
                                                5) {
                                              pickFile(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(customSnackBar(
                                                      context,
                                                      pdfsQuantityError,
                                                      1));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              marginHeight(28),
                              controller.pdfModelList.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: setWidgetHeight(165),
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(
                                          left: setWidgetWidth(30),
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.pdfModelList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return AdUploadPDF(
                                            pdfsFile:
                                                controller.pdfModelList[index],
                                            index: index,
                                          );
                                        },
                                      ),
                                    ),

                              //Bottom Padding
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: setWidgetHeight(30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BottomButtons(
                        screen: translate(
                            context, language.languageCode, contacts)!,
                        rightButtonName: translate(
                            context, language.languageCode, saveNext)!,
                        leftButtonName:
                            translate(context, language.languageCode, back)!,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
