
import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../data/connection_model.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/images.dart';
import '../../utils/size.dart';

class Connection extends StatelessWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayHeight(context),
      width: displayWidth(context),
      child: Center(
        child: SizedBox(
          height: setWidgetHeight(260),
          width: setWidgetWidth(330),
          child: Image.asset(
            Images.connection,
          ),
        ),
      ),
    );
  }
}

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectionModel args =
        ModalRoute.of(context)!.settings.arguments as ConnectionModel;
    debugPrint("screen is : ${args.screen}");
    debugPrint("message is : ${args.message}");

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, args.screen);
        return Future.value(true);
      },
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const ImageIcon(
                      AssetImage(Images.arrowBackIcon),
                      color: bluePrimary,
                      size: 23,
                    ),
                  ),
                ],
              )),
          body: SizedBox(
            height: displayHeight(context),
            width: displayWidth(context),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: setWidgetHeight(260),
                    width: setWidgetWidth(330),
                    child: Image.asset(
                      Images.connection,
                    ),
                  ),
                  Consumer<LanguageProvider>(
                    builder: (context, language, child) {
                      return Text(
                        translate(
                          context,
                          language.languageCode,
                          args.message,
                        )!,
                        style: textStyle(
                          fontSize: 20,
                          color: bluePrimary,
                          fontFamily: satoshiBold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
