// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/user_profile_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/input_label.dart';
import 'package:provider/provider.dart';

import '../../helper/debouncer.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../authentication_screen/components/custom_build_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_telephone_field.dart';
import '../widgets/input_field.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({Key? key}) : super(key: key);

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  File? image;
  final picker = ImagePicker();
  final debouncer = DeBouncer(milliseconds: 300);
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
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    return Text(
                      translate(context, language.languageCode, gallery)!,
                    );
                  },
                ),
                onTap: () {
                  imageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    return Text(
                      translate(context, language.languageCode, camera)!,
                    );
                  },
                ),
                onTap: () {
                  imageFromCamera();
                  Navigator.pop(context);
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
        imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        image = null;
        debugPrint('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    callingProfileAPI();
  }

  callingProfileAPI() {
    final profileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((value) async {
      await profileProvider.getProfile(context, moreOptions, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: blueStatusBar(),
        child: SafeArea(
          top: Platform.isAndroid ? true : false,
          bottom: Platform.isAndroid ? true : false,
          child: WillPopScope(
            onWillPop: () async {
              final userProfileProvider =
                  Provider.of<UserProfileProvider>(context, listen: false);
              userProfileProvider.clearMarker();
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    final userProfileProvider =
                        Provider.of<UserProfileProvider>(context,
                            listen: false);
                    userProfileProvider.clearDataFields();
                    Navigator.pop(context);
                  },
                  icon: const ImageIcon(
                    AssetImage(Images.arrowBackIcon),
                    size: 23,
                  ),
                ),
                title: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    return Text(
                      translate(context, language.languageCode, profile)!,
                      style: textStyle(
                          fontSize: 18,
                          color: whitePrimary,
                          fontFamily: satoshiMedium),
                    );
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Consumer<UserProfileProvider>(
                      builder: (context, controller, child) {
                        return Consumer<LanguageProvider>(
                          builder: (context, language, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  heightFactor: setWidgetHeight(1.5),
                                  alignment: Alignment.center,
                                  child: image != null
                                      ? Container(
                                          width: setWidgetHeight(120),
                                          height: setWidgetHeight(120),
                                          decoration: BoxDecoration(
                                            color: blueShadow,
                                            image: DecorationImage(
                                                image: FileImage(
                                                  image!,
                                                ),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              radius: setWidgetWidth(15),
                                              backgroundColor: bluePrimary,
                                              child: Image.asset(
                                                Images.iconEdit,
                                                color: whitePrimary,
                                                height: setWidgetWidth(16),
                                                width: setWidgetWidth(16),
                                              ),
                                            ).onPress(
                                              () {
                                                showPicker(context);
                                              },
                                            ),
                                          ),
                                        )
                                      : controller.currentUserModel.data!
                                                  .avatar !=
                                              null
                                          ? Container(
                                              width: setWidgetHeight(120),
                                              height: setWidgetHeight(120),
                                              decoration: BoxDecoration(
                                                color: blueShadow,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        controller
                                                            .currentUserModel
                                                            .data!
                                                            .avatar!),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: setWidgetWidth(15),
                                                  backgroundColor: bluePrimary,
                                                  child: Image.asset(
                                                    Images.iconEdit,
                                                    color: whitePrimary,
                                                    height: setWidgetWidth(16),
                                                    width: setWidgetWidth(16),
                                                  ),
                                                ).onPress(
                                                  () {
                                                    showPicker(context);
                                                  },
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: setWidgetHeight(120),
                                              height: setWidgetHeight(120),
                                              decoration: const BoxDecoration(
                                                color: blueShadow,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Images.userPlaceholder),
                                                    fit: BoxFit.cover),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: setWidgetWidth(15),
                                                  backgroundColor: bluePrimary,
                                                  child: Image.asset(
                                                    Images.iconEdit,
                                                    color: whitePrimary,
                                                    height: setWidgetWidth(16),
                                                    width: setWidgetWidth(16),
                                                  ),
                                                ).onPress(
                                                  () {
                                                    showPicker(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                ),
                                SizedBox(
                                  height: setWidgetHeight(20),
                                ),
                                //username or company name
                                InputLabel(translate(
                                    context,
                                    language.languageCode,
                                    controller.currentUserModel.data!
                                                .isCompany ==
                                            1
                                        ? companyName
                                        : userNameValue)!),
                                SizedBox(
                                  height: setWidgetHeight(8),
                                ),
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      hintUserName)!,
                                  TextInputType.text,
                                  controller.userNameController,
                                ),
                                SizedBox(
                                  height: setWidgetHeight(24),
                                ),
                                //email
                                InputLabel(translate(context,
                                    language.languageCode, emailAddress)!),
                                SizedBox(
                                  height: setWidgetHeight(8),
                                ),
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      hintEmail)!,
                                  TextInputType.emailAddress,
                                  controller.emailController,
                                  backGroundColor:
                                      controller.currentUserModel.data!.email !=
                                              null
                                          ? greyShadow
                                          : whitePrimary,
                                  isReadOnly:
                                      controller.currentUserModel.data!.email !=
                                              null
                                          ? true
                                          : false,
                                  isFilled:
                                      controller.currentUserModel.data!.email !=
                                              null
                                          ? true
                                          : false,
                                ),
                                SizedBox(
                                  height: setWidgetHeight(24),
                                ),
                                // address
                                InputLabel(translate(
                                    context, language.languageCode, address)!),
                                SizedBox(
                                  height: setWidgetHeight(8),
                                ),
                                CustomInputFormField(
                                    translate(context, language.languageCode,
                                        hintAddress)!,
                                    TextInputType.text,
                                    controller.addressController),
                                SizedBox(
                                  height: setWidgetHeight(24),
                                ),
                                // phone number
                                InputLabel(translate(context,
                                    language.languageCode, phoneNumber)!),
                                SizedBox(
                                  height: setWidgetHeight(8),
                                ),
                                CustomPhoneFormField(
                                  translate(context, language.languageCode,
                                      hintPhone)!,
                                  controller.phoneNumberController,
                                ),
                                SizedBox(
                                  height: setWidgetHeight(24),
                                ),
                                // website
                                InputLabel(translate(
                                    context, language.languageCode, website)!),
                                SizedBox(
                                  height: setWidgetHeight(8),
                                ),
                                CustomInputFormField(
                                  translate(context, language.languageCode,
                                      hintWebsite)!,
                                  TextInputType.url,
                                  controller.websiteController,
                                ),
                                SizedBox(
                                  height: setWidgetHeight(24),
                                ),
                                // Location
                                InputLabel(translate(
                                    context, language.languageCode, location)!),
                                SizedBox(
                                  height: setWidgetHeight(8),
                                ),
                                CustomInputFormField(
                                    translate(context, language.languageCode,
                                        enterLocation)!,
                                    TextInputType.text,
                                    controller.locationController),
                                SizedBox(
                                  height: setWidgetHeight(10),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Wrap(
                                      children: [
                                        Image.asset(
                                          Images.iconMap,
                                          width: setWidgetWidth(24),
                                          height: setWidgetHeight(24),
                                        ),
                                        SizedBox(
                                          width: setWidgetWidth(5),
                                        ),
                                        Text(
                                            translate(
                                                context,
                                                language.languageCode,
                                                selectOnMap)!,
                                            style: textStyle(
                                                fontSize: 16,
                                                color: bluePrimary,
                                                fontFamily: satoshiRegular))
                                      ],
                                    ).onPress(() async {
                                      debouncer.run(() async {
                                        await controller
                                            .getCurrentCameraPosition(context)
                                            .then((value) {
                                          Navigator.pushNamed(
                                              context,
                                              RouterHelper
                                                  .selectLocationScreen);
                                        });
                                      });
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  height: setWidgetHeight(16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: CustomBuildButton(
                                    buttonName: translate(context,
                                        language.languageCode, setProfile)!,
                                    buttonColor: bluePrimary,
                                    buttonTextColor: whitePrimary,
                                    onPressed: () async {
                                      if (controller
                                          .userNameController.text.isNotEmpty) {
                                        if (controller.validaPhoneNumber(
                                            controller
                                                .phoneNumberController.text)) {
                                          if (image != null) {
                                            controller.setImage(image!);
                                          }
                                          await controller.updateProfile(
                                              context, RouterHelper.setProfile);
                                          if (controller
                                                  .updateUserModel.error ==
                                              false) {
                                            image == null;

                                            Navigator.pop(context);
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            customSnackBar(
                                                context, validPhoneNumber, 1),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          customSnackBar(
                                              context, pleaseEnterUserName, 1),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            deleteAccount)!,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 16,
                                            color: redColor,
                                            fontFamily: satoshiMedium),
                                      ).onPress(() {
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      setWidgetWidth(20),
                                                  vertical:
                                                      setWidgetHeight(20)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Image.asset(
                                                      Images.iconClose,
                                                      width: setWidgetWidth(24),
                                                      height:
                                                          setWidgetHeight(24),
                                                    ).onPress(
                                                      () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  Image(
                                                    image: const AssetImage(
                                                        Images
                                                            .iconDeleteWarning),
                                                    width: setWidgetWidth(130),
                                                    height:
                                                        setWidgetHeight(115),
                                                  ),
                                                  marginHeight(20),
                                                  Text(
                                                    translate(
                                                        context,
                                                        language.languageCode,
                                                        deleteAccountConfermation)!,
                                                    textAlign: TextAlign.center,
                                                    style: textStyle(
                                                        fontSize: 20,
                                                        color: blackLight,
                                                        fontFamily:
                                                            satoshiMedium),
                                                  ),
                                                  marginHeight(20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      CustomButton(
                                                        buttonHeight: 52,
                                                        buttonWidth: 162,
                                                        buttonColor:
                                                            bluePrimary,
                                                        buttonTextColor:
                                                            whitePrimary,
                                                        buttonText: translate(
                                                            context,
                                                            language
                                                                .languageCode,
                                                            no)!,
                                                        radiusSize: 10,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      CustomButton(
                                                        buttonHeight: 52,
                                                        buttonWidth: 162,
                                                        buttonColor: redColor,
                                                        buttonBorderColor:
                                                            redColor
                                                                .withOpacity(
                                                                    0.1),
                                                        buttonTextColor:
                                                            whitePrimary,
                                                        buttonText: translate(
                                                            context,
                                                            language
                                                                .languageCode,
                                                            yes)!,
                                                        radiusSize: 10,
                                                        onPressed: () {
                                                          Future.delayed(
                                                              Duration.zero,
                                                              () async {
                                                            await controller
                                                                .deleteAccount(
                                                                    context,
                                                                    RouterHelper
                                                                        .setProfile);
                                                            if (controller
                                                                    .deleteAccountModel
                                                                    .error ==
                                                                false) {
                                                              Navigator.pushNamedAndRemoveUntil(
                                                                  context,
                                                                  RouterHelper
                                                                      .emailSignInScreen,
                                                                  (route) =>
                                                                      false);
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(customSnackBar(
                                                                      context,
                                                                      controller
                                                                          .deleteAccountModel
                                                                          .message
                                                                          .toString(),
                                                                      controller.deleteAccountModel.error ==
                                                                              false
                                                                          ? 0
                                                                          : 1));
                                                            }
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      })),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
