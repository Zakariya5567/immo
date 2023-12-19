// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/view/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/input_field.dart';
import '../../widgets/input_label.dart';

// ignore: must_be_immutable
class CreateAlert extends StatefulWidget {
  CreateAlert({super.key, required this.formKey, required this.scaffoldKey});
  GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CreateAlert> createState() => _CreateAlertState();
}

class _CreateAlertState extends State<CreateAlert> {
  @override
  void initState() {
    super.initState();
    setEmailField();
  }

  setEmailField() async{
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final filterScreenProvider =
          Provider.of<FilterScreenProvider>(context, listen: false);
      filterScreenProvider.emailController.text =
          sharedPreferences.getString(AppConstant.userEmail)!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Consumer<FilterScreenProvider>(
            builder: (context, controller, child) {
              return Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translate(
                              context, language.languageCode, createAlert)!,
                          style: textStyle(
                              fontSize: 22,
                              color: blackLight,
                              fontFamily: satoshiBold),
                        ),
                        Image.asset(
                          Images.iconClose,
                          width: setWidgetWidth(24),
                          height: setWidgetHeight(24),
                        ).onPress(
                          () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: setWidgetHeight(24),
                    ),
                    Text(
                      translate(context, language.languageCode,
                          createAlertDescription)!,
                      style: textStyle(
                          fontSize: 12,
                          color: blackPrimary,
                          fontFamily: satoshiRegular),
                    ),
                    SizedBox(
                      height: setWidgetHeight(24),
                    ),
                    InputLabel(
                        translate(context, language.languageCode, alertName)!),
                    SizedBox(
                      height: setWidgetHeight(8),
                    ),
                    CustomInputFormField(
                        translate(
                            context, language.languageCode, hintAlertName)!,
                        TextInputType.text,
                        controller.alertNameController),
                    SizedBox(
                      height: setWidgetHeight(24),
                    ),
                    //email
                    InputLabel(
                        translate(context, language.languageCode, yourEmail)!),
                    SizedBox(
                      height: setWidgetHeight(8),
                    ),
                    CustomInputFormField(
                      translate(context, language.languageCode, hintEmail)!,
                      TextInputType.emailAddress,
                      controller.emailController,
                      backGroundColor: greyShadow,
                      isReadOnly: true,
                      isFilled: true,
                    ),
                    SizedBox(
                      height: setWidgetHeight(24),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: translate(context, language.languageCode,
                            alertPolicyMessage)!,
                        style: textStyle(
                            fontSize: 12,
                            color: blackPrimary,
                            fontFamily: satoshiRegular),
                        children: <TextSpan>[
                          TextSpan(
                              text: translate(context, language.languageCode,
                                  privacyPolicy)!,
                              style: textStyle(
                                  fontSize: 12,
                                  color: bluePrimary,
                                  fontFamily: satoshiRegular)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: setWidgetHeight(24),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        buttonHeight: 50,
                        buttonWidth: 168,
                        buttonColor: bluePrimary,
                        buttonTextColor: whitePrimary,
                        buttonText: translate(context, language.languageCode,
                            controller.isEdit == 0 ? create : update)!,
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            Navigator.of(widget.scaffoldKey.currentContext!)
                                .pop();
                            if (controller.isEdit == 0) {
                              controller.createAlert(
                                  widget.scaffoldKey.currentContext!,
                                  RouterHelper.filterScreen);
                              controller.clearAlertTextField();
                            } else {
                              controller.updateAlert(
                                  widget.scaffoldKey.currentContext!,
                                  RouterHelper.filterScreen);
                            }
                          }
                        },
                        radiusSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: setWidgetHeight(24),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
