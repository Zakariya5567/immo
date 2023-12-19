// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/notificaton_services.dart';
import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/app_constant.dart';
import '../../utils/size.dart';
import '../../utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //implements SplashIntent {
  @override
  void initState() {
    //Calling notification for listen the app is in which state (foreground,background,terminated)
    super.initState();
    _determinePosition();
    // requestStoragePermission();
    routes();
  }

  Future handleNotification() async {
    await NotificationService().handleNotification(context); //, this);
  }

  void routes() async {
    Timer(const Duration(seconds: 5), () async {
      handleNotification();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool? isLogin = sharedPreferences.getBool(AppConstant.isLogin);
      if (isLogin == true) {
        Navigator.of(context).pushReplacementNamed(RouterHelper.homeScreen);
      } else if (isLogin == false) {
        Navigator.of(context).pushReplacementNamed(RouterHelper.emailSignInScreen);
      } else if (isLogin == null) {
        Navigator.of(context)
            .pushReplacementNamed(RouterHelper.onBoardingFirstScreen);
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    setMediaQuery(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: splashStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset(
                  Images.logo,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: setWidgetHeight(12)),
                child: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    language.updateLanguage();
                    return Text(
                      translate(context, language.languageCode, versionText)!,
                      style: textStyle(
                          fontSize: 12,
                          color: blackLight,
                          fontFamily: satoshiMedium),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void forApplication() {
  //   routes();
  // }

  // @override
  // void forNotification(RemoteMessage? message) {
  //   navigatorKey.currentState!.pushNamed(RouterHelper.adDetailsScreen,
  //       arguments: DetailScreenArguments(int.tryParse(message!.data['id'])!));
  // }
}

// class SplashIntent {
//   void forNotification(RemoteMessage? message) {}
//   void forApplication() {}
// }
