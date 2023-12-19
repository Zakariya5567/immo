import 'package:flutter/services.dart';
import 'package:immo/utils/colors.dart';

//status bar

splashStatusBar() {
  return const SystemUiOverlayStyle(
    statusBarColor: statusBarWhite,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

whiteStatusBar() {
  return const SystemUiOverlayStyle(
    statusBarColor: statusBarWhite,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}

blueStatusBar() {
  return const SystemUiOverlayStyle(
    statusBarColor: statusBarBlue,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
