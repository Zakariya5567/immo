import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/post_an_ad_provider.dart';
import '../../utils/size.dart';
import 'components/ad_steps_details.dart';
import 'components/ads_app_bar.dart';
import '../widgets/ads_bottom_buttons.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AdsAppBar(
            appBar: AppBar(), screen: finish,
          ),
          body: Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Consumer<PostAnAdProvider>(
                builder: (context, controller, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: setWidgetWidth(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AdsStepsDetails(
                                    steps: 5,
                                    stepTitle: translate(
                                        context, language.languageCode, order)!,
                                    stepDescription:
                                        '${translate(context, language.languageCode, nextText)!}: ${translate(context, language.languageCode, finish)!}'),
                                marginHeight(28),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          order)!,
                                      style: textStyle(
                                        fontSize: 18,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(7),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          orderDetail1)!,
                                      style: textStyle(
                                        fontSize: 12,
                                        color: blackPrimary,
                                        fontFamily: satoshiRegular,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(23),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: setWidgetWidth(330),
                                      child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            orderDetail2)!,
                                        style: textStyle(
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(23),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          pleaseNote)!,
                                      style: textStyle(
                                        fontSize: 16,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: setWidgetHeight(5)),
                                      width: setWidgetWidth(10),
                                      height: setWidgetHeight(10),
                                      decoration: const BoxDecoration(
                                        color: orangePrimary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    marginWidth(8),
                                    SizedBox(
                                      width: setWidgetWidth(330),
                                      child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            noteDetail1)!,
                                        style: textStyle(
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: setWidgetHeight(5)),
                                      width: setWidgetWidth(10),
                                      height: setWidgetHeight(10),
                                      decoration: const BoxDecoration(
                                        color: orangePrimary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    marginWidth(8),
                                    SizedBox(
                                      width: setWidgetWidth(330),
                                      child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            noteDetail2)!,
                                        style: textStyle(
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(23),
                                Row(
                                  children: [
                                    Text(
                                      translate(context, language.languageCode,
                                          selectDuration)!,
                                      style: textStyle(
                                        fontSize: 16,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(28),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: setWidgetWidth(334),
                                        height: setWidgetHeight(266),
                                        decoration: BoxDecoration(
                                          color: whitePrimary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                          border: Border.all(
                                            color: orangePrimary,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    marginHeight(10),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              standardPackage)!,
                                                          style: textStyle(
                                                            fontSize: 14,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiBold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    marginHeight(14),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              free)!,
                                                          style: textStyle(
                                                            fontSize: 14,
                                                            color: bluePrimary,
                                                            fontFamily:
                                                                satoshiMedium,
                                                          ),
                                                        ),
                                                        marginWidth(7),
                                                        Text(
                                                          translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              forFirstYear)!,
                                                          style: textStyle(
                                                            fontSize: 10,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    marginHeight(14),
                                                    Row(
                                                      children: [
                                                        const ImageIcon(
                                                          AssetImage(
                                                              Images.iconCheck),
                                                          size: 14,
                                                          color: orangePrimary,
                                                        ),
                                                        marginWidth(10),
                                                        Text(
                                                          "Lorem Ipsum Lorem Ipsum",
                                                          style: textStyle(
                                                            fontSize: 10,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    marginHeight(9),
                                                    Row(
                                                      children: [
                                                        const ImageIcon(
                                                          AssetImage(
                                                              Images.iconCheck),
                                                          size: 14,
                                                          color: orangePrimary,
                                                        ),
                                                        marginWidth(10),
                                                        Text(
                                                          "Lorem Ipsum Lorem Ipsum",
                                                          style: textStyle(
                                                            fontSize: 10,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    marginHeight(9),
                                                    Row(
                                                      children: [
                                                        const ImageIcon(
                                                          AssetImage(
                                                              Images.iconCheck),
                                                          size: 14,
                                                          color: orangePrimary,
                                                        ),
                                                        marginWidth(10),
                                                        Text(
                                                          "Lorem Ipsum Lorem Ipsum",
                                                          style: textStyle(
                                                            fontSize: 10,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    marginHeight(9),
                                                    Row(
                                                      children: [
                                                        const ImageIcon(
                                                          AssetImage(
                                                              Images.iconCheck),
                                                          size: 14,
                                                          color: orangePrimary,
                                                        ),
                                                        marginWidth(10),
                                                        Text(
                                                          "Lorem Ipsum Lorem Ipsum",
                                                          style: textStyle(
                                                            fontSize: 10,
                                                            color: blackPrimary,
                                                            fontFamily:
                                                                satoshiMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                marginWidth(2),
                                                Column(
                                                  children: [
                                                    controller
                                                            .isSubscriptionPackegeSelected
                                                        ? Container(
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    setWidgetHeight(
                                                                        21)),
                                                            width:
                                                                setWidgetWidth(
                                                                    32),
                                                            height:
                                                                setWidgetHeight(
                                                                    32),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  orangePrimary,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    orangePrimary,
                                                              ),
                                                            ),
                                                            child:
                                                                const ImageIcon(
                                                              AssetImage(
                                                                Images
                                                                    .simpleTick,
                                                              ),
                                                              size: 16,
                                                              color:
                                                                  whitePrimary,
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            width:
                                                                setWidgetWidth(
                                                                    30),
                                                            height:
                                                                setWidgetHeight(
                                                                    30),
                                                          ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            marginHeight(14),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: setWidgetHeight(10)),
                                              width: setWidgetWidth(180),
                                              height: setWidgetHeight(40),
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: orangePrimary,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                              ),
                                              child: Text(
                                                translate(
                                                    context,
                                                    language.languageCode,
                                                    select)!,
                                                style: textStyle(
                                                  fontSize: 16,
                                                  color: whitePrimary,
                                                  fontFamily: satoshiMedium,
                                                ),
                                              ),
                                            ),
                                            marginHeight(8),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        controller.isPackageSelected();
                                      },
                                    ),
                                  ],
                                ),
                                //Bottom Padding
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: setWidgetHeight(30),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BottomButtons(
                        screen:
                            translate(context, language.languageCode, finish)!,
                        rightButtonName: translate(
                            context, language.languageCode, saveNext)!,
                        leftButtonName:
                            translate(context, language.languageCode, back)!,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
