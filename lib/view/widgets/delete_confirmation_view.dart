import 'package:flutter/material.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/size.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class DeleteConfirmationView extends StatelessWidget {
  String image;
  VoidCallback onPress;

  DeleteConfirmationView(this.image, this.onPress, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: setWidgetWidth(20), vertical: setWidgetHeight(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  Images.iconClose,
                  width: setWidgetWidth(24),
                  height: setWidgetHeight(24),
                ).onPress(
                  () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Image(
                image: AssetImage(image),
                width: setWidgetWidth(130),
                height: setWidgetHeight(115),
              ),
              SizedBox(
                height: setWidgetHeight(28),
              ),
              Text(
                translate(context, language.languageCode,areYouSure)!,
                style: textStyle(
                    fontSize: 28, color: blackLight, fontFamily: satoshiMedium),
              ),
              SizedBox(
                height: setWidgetHeight(60),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    buttonHeight: 52,
                    buttonWidth: 162,
                    buttonColor: bluePrimary,
                    buttonTextColor: whitePrimary,
                    buttonText: translate(context, language.languageCode,no)!,
                    radiusSize: 10,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    buttonHeight: 52,
                    buttonWidth: 162,
                    buttonColor: redColor,
                    buttonBorderColor: redColor.withOpacity(0.1),
                    buttonTextColor: whitePrimary,
                    buttonText: translate(context, language.languageCode,yes)!,
                    radiusSize: 10,
                    onPressed: onPress,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
