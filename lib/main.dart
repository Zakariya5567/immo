import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/colors.dart';
import 'package:provider/provider.dart';
import 'db/search_history.dart';
import 'helper/notificaton_services.dart';
import 'helper/provider_helper.dart';
import 'helper/scroll_behaviour.dart';
import 'localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // APIS LIST
  List<Future> apiFutures = [
    // TO INITIALIZE FIREBASE
    Firebase.initializeApp(),
    // TO INITIALIZE PUSH NOTIFICATION
    NotificationService().initialize(),
    // TO INITIALIZE Hive database
    Hive.initFlutter(),
  ];
  // CALL MULTIPLE API
  await Future.wait(apiFutures);
  FirebaseMessaging.instance.getToken().then((value) {
    debugPrint("Token =======================>>>>>>>>>>> : $value");
  });
  // NOTIFICATION INSTANCE FOR PERMISSION
  FirebaseMessaging.instance.requestPermission();
  // Hive TO STORE HISTORY OF SEARCHRD QUERY IN DATA BASE
  Hive.registerAdapter(SearchHistoryAdapter());
  await Hive.openBox<SearchHistory>("search_history");
  // FIX THE DEVICE ORIENTATIONTO PORTRAIT
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderHelper.providers,
      child: MaterialApp(
          navigatorKey: navigatorKey,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              ),
            );
          },
          localizationsDelegates: const [
            AppLocalizationsDelegate(locale: Locale("en")),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          title: 'Immo Experte 24',
          theme:
              ThemeData(primarySwatch: MaterialColor(0xFF004999, primaryColor)),
          initialRoute: RouterHelper.initial,
          routes: RouterHelper.routes),
    );
  }
}
