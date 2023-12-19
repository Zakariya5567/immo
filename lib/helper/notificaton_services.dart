import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api_models/detail_arguments.dart';
import '../main.dart';
import '../utils/app_constant.dart';

// To initialized notification to handel notification in background
Future<void> backgroundHandler(RemoteMessage message) async {}

// initialized FlutterLocalNotificationsPlugin

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  // To initialized notification
  Future<void> initialize() async {
    //initialization for background
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // initializationSettings  for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    // initializationSettings  for IOS
    const DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // Initialization of setting for both android and ios

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("Payload=====================.>>>>>>: ${response.payload}");

        navigatorKey.currentState!.pushNamed(RouterHelper.adDetailsScreen,
            arguments: DetailScreenArguments(int.tryParse(response.payload!)!));
      },
    );
  }

  // Notification detail for android

  static const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    "high_importance_channel", // id
    'High Importance Notifications', // title
    importance: Importance.max,
    priority: Priority.high,
  );

  // Notification detail for Ios
  static const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // After initialize we create channel in displayNotification method

  Future<void> displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: iosNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['id']);
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> displayAlertNotification() async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: iosNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
        id,
        "Immo Experte 24",
        "File dawnload succesfully",
        notificationDetails,
        payload: "NOTIFY",
      );
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> handleNotification(context) async {
    //, SplashIntent splashIntent) async {
    final homeProvider = Provider.of<HomePageProvider>(context, listen: false);

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    // final messageInstance =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (messageInstance != null) {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        debugPrint("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          if (message.notification != null) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            bool? isLogin = sharedPreferences.getBool(AppConstant.isLogin);
            debugPrint("New Notification");

            if (isLogin == true) {
              // splashIntent.forNotification(message);
              navigatorKey.currentState!.pushNamed(RouterHelper.adDetailsScreen,
                  arguments:
                      DetailScreenArguments(int.tryParse(message.data['id'])!));

              homeProvider.setNotificationStatus(true);
            } else {
              navigatorKey.currentState!.pushNamed(RouterHelper.emailSignInScreen);
            }
          }
        }
      },
    );
    // } else {
    //   splashIntent.forApplication();
    // }

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        debugPrint("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          debugPrint(message.notification!.title);
          debugPrint(message.notification!.body);
          debugPrint("message.data ${message.data}");
          homeProvider.setNotificationStatus(true);
          displayNotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          debugPrint(message.notification!.title);
          debugPrint(message.notification!.body);
          debugPrint("message.data ${message.data}");
          homeProvider.setNotificationStatus(true);

          navigatorKey.currentState!.pushNamed(RouterHelper.adDetailsScreen,
              arguments:
                  DetailScreenArguments(int.tryParse(message.data['id'])!));
        }
      },
    );
  }
}
