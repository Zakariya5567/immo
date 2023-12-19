import 'dart:io';

import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/more_option_provider.dart';
import 'package:immo/utils/launch_url.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/view/widgets/no_data_found.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/style.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    callingApi();
    super.initState();
  }

  callingApi() {
    Future.delayed(Duration.zero, () {
      final moreOptionProvider =
          Provider.of<MoreOptionProvider>(context, listen: false);
      moreOptionProvider.getPrivacyPolicy(context, RouterHelper.moreOptions);
      debugPrint(
          "Privacy Policy =============>  ${moreOptionProvider.privacyPolicyModel.data}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: Platform.isAndroid ? true : false,
      bottom: Platform.isAndroid ? true : false,
      child: Consumer2<LanguageProvider, MoreOptionProvider>(
        builder: (context, language, controller, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  translate(context, language.languageCode, pPrivacyPolicy)!,
                  style: textStyle(
                    fontSize: 20,
                    color: whitePrimary,
                    fontFamily: satoshiBold,
                  ),
                ),
              ),
              backgroundColor: bluePrimary,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const ImageIcon(
                  AssetImage(Images.arrowBackIcon),
                  color: whitePrimary,
                  size: 23,
                ),
              ),
            ),
            body: controller.privacyPolicyModel.data == null
                ? const NoDataFound()
                : ListView.builder(
                    itemCount: controller.privacyPolicyModel.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: setWidgetWidth(25)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            marginHeight(20),
                            Text(
                              controller.privacyPolicyModel.data![index].title!,
                              style: textStyle(
                                  fontSize: 18,
                                  color: blackPrimary,
                                  fontFamily: satoshiBold),
                            ),
                            marginHeight(10),
                            Html(
                              data: controller
                                  .privacyPolicyModel.data![index].content!,
                              onLinkTap: (url, attributes, element) {
                                debugPrint(
                                    "URL========================>   $url");
                                debugPrint(
                                    "attributes========================>   $attributes");
                                debugPrint(
                                    "element========================>   $element");
                                launchInAppURL(url!);
                              },
                              // style: {
                              //   'p': Style(margin: Margins.all(0)),
                              // },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
