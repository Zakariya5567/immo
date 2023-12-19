import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';

class AppraisalAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AppraisalAppBar({super.key, required this.appBar});
  final AppBar appBar;

  @override
  State<AppraisalAppBar> createState() => _AppraisalAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _AppraisalAppBarState extends State<AppraisalAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return AppBar(
          backgroundColor: bluePrimary,
          // Back Button
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const ImageIcon(
              AssetImage(Images.arrowBackIcon),
              size: 23,
            ),
          ),
          // Title of Online Property Appraisal Screen
          title: Text(
            translate(context, language.languageCode,onlinePropertyAppraisal)!,
          ),
          centerTitle: false,
          titleTextStyle: textStyle(
            fontSize: 18,
            color: whitePrimary,
            fontFamily: satoshiMedium,
          ),
        );
      },
    );
  }
}
