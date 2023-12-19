import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:immo/localization/app_localizations.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../provider/language_provider.dart';
import '../../utils/size.dart';

class AccessLocationPermission extends StatelessWidget {
  const AccessLocationPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return AlertDialog(
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            Container(
              height: setWidgetHeight(50),
              width: setWidgetWidth(300),
              decoration: BoxDecoration(
                  color: whitePrimary, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  translate(context, language.languageCode, goToSettings)!,
                  style: textStyle(
                      fontSize: 14,
                      color: bluePrimary,
                      fontFamily: satoshiBold),
                ),
              ),
            ).onPress(() async {
              await AppSettings.openAppSettings()
                  .then((value) => Navigator.pop(context));
            }),
          ],
          content: Text(
            translate(context, language.languageCode, locationAccessQoute)!,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
