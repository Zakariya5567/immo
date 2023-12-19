import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/my_alerts/components/my_alert_item.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/filter_screen_provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/style.dart';

class MyAlertsScreen extends StatefulWidget {
  const MyAlertsScreen({Key? key}) : super(key: key);

  @override
  State<MyAlertsScreen> createState() => _MyAlertsScreenState();
}

class _MyAlertsScreenState extends State<MyAlertsScreen> {
  @override
  void initState() {
    callingAPIs();
    super.initState();
  }

  callingAPIs() {
    Future.delayed(Duration.zero, () {
      final filterScreenProvider =
          Provider.of<FilterScreenProvider>(context, listen: false);
      filterScreenProvider.setLoading(true);
      filterScreenProvider.getAlertList(context, RouterHelper.myAdsListScreen);
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
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
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
                  translate(context, language.languageCode, myAlerts)!,
                  style: textStyle(
                      fontSize: 18,
                      color: whitePrimary,
                      fontFamily: satoshiMedium),
                );
              },
            ),
          ),
          body: const MyAlertItem(),
        ),
      ),
    );
  }
}
