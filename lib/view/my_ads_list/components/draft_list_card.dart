import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/view/my_ads_list/components/duplication_warning.dart';
import 'package:immo/view/widgets/button_with_icon.dart';
import 'package:provider/provider.dart';

import '../../../data/api_models/detail_arguments.dart';
import '../../../data/api_models/properties/property_list_model.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/delete_confirmation_view.dart';

// ignore: must_be_immutable
class DraftListCard extends StatelessWidget {
  DraftListCard(
      {super.key,
      required this.draftProperty,
      required this.controller,
      required this.index});
  final PropertiesData draftProperty;
  HomePageProvider controller;
  int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: setWidgetHeight(10),
            horizontal: setWidgetWidth(25),
          ),
          decoration: BoxDecoration(
            color: whitePrimary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: greyShadow,
                spreadRadius: 7,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: setWidgetWidth(10)),
                child: Row(
                  children: [
                    //Image of Card
                    Container(
                      width: setWidgetWidth(138),
                      height: setWidgetHeight(145),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(draftProperty.mainImage!),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: setWidgetWidth(8),
                              bottom: setWidgetHeight(8),
                            ),
                            height: setWidgetHeight(18),
                            width: setWidgetWidth(41),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: whitePrimary,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage(Images.iconCamera),
                                  size: 8,
                                  color: bluePrimary,
                                ),
                                marginWidth(4),
                                // Number of Images
                                Text(
                                  '${draftProperty.imagesCount!}',
                                  style: textStyle(
                                    fontSize: 8,
                                    color: blackPrimary,
                                    fontFamily: satoshiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Details of Card
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: setWidgetWidth(12), top: setWidgetHeight(4)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Title of Card
                            Text(
                              draftProperty.title!,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle(
                                fontSize: 16,
                                color: blackPrimary,
                                fontFamily: satoshiMedium,
                              ),
                            ),
                            marginHeight(6),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${translate(context, language.languageCode, price)!} :",
                                      style: textStyle(
                                          fontSize: 10,
                                          color: greyPrimary,
                                          fontFamily: satoshiRegular),
                                    ),
                                    marginHeight(11),
                                    Text(
                                      '${translate(context, language.languageCode, id)!} :',
                                      style: textStyle(
                                          fontSize: 10,
                                          color: greyPrimary,
                                          fontFamily: satoshiRegular),
                                    ),
                                    marginHeight(11),
                                    Text(
                                      '${translate(context, language.languageCode, edited)!} :',
                                      style: textStyle(
                                          fontSize: 10,
                                          color: greyPrimary,
                                          fontFamily: satoshiRegular),
                                    ),
                                  ],
                                ),
                                marginWidth(5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Price Value
                                    draftProperty.isPrice == true
                                        ? Column(
                                            children: [
                                              Text(
                                                '${draftProperty.price}',
                                                style: textStyle(
                                                  fontSize: 10,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiMedium,
                                                ),
                                              ),
                                              marginHeight(11),
                                            ],
                                          )
                                        : const SizedBox(),
                                    //ID Number
                                    Text(
                                      '${draftProperty.id!}',
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                    marginHeight(11),
                                    // Edited Date
                                    Text(
                                      draftProperty.editedDate!,
                                      style: textStyle(
                                        fontSize: 10,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: setWidgetHeight(12),
                                    bottom: setWidgetHeight(10),
                                  ),
                                  height: setWidgetHeight(34),
                                  width: setWidgetWidth(60),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: whiteShadow,
                                  ),
                                  child: Center(
                                    // Number of Views
                                    child: Text(
                                      '${draftProperty.viewsCount!} ${translate(context, language.languageCode, views)!}',
                                      textAlign: TextAlign.center,
                                      style: textStyle(
                                        fontSize: 8,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ),
                                ),
                                marginWidth(5),
                                Container(
                                  margin: EdgeInsets.only(
                                    // left: setWidgetWidth(5),
                                    top: setWidgetHeight(12),
                                    bottom: setWidgetHeight(10),
                                  ),
                                  height: setWidgetHeight(34),
                                  width: setWidgetWidth(60),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: whiteShadow,
                                  ),
                                  child: Center(
                                    // Number of Emails
                                    child: Text(
                                      '${draftProperty.emailsCount!} ${translate(context, language.languageCode, emails)!}',
                                      textAlign: TextAlign.center,
                                      style: textStyle(
                                        fontSize: 8,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ),
                                ),
                                marginWidth(5),
                                Container(
                                  margin: EdgeInsets.only(
                                    // left: setWidgetWidth(5),
                                    top: setWidgetHeight(12),
                                    bottom: setWidgetHeight(10),
                                  ),
                                  height: setWidgetHeight(34),
                                  width: setWidgetWidth(60),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: whiteShadow,
                                  ),
                                  child: Center(
                                    // Number of Calls
                                    child: Text(
                                      '${draftProperty.callsCount!} ${translate(context, language.languageCode, calls)!}',
                                      textAlign: TextAlign.center,
                                      style: textStyle(
                                        fontSize: 8,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Divider
              Container(
                margin: EdgeInsets.only(
                    bottom: setWidgetHeight(8),
                    left: setWidgetWidth(10),
                    right: setWidgetWidth(10)),
                height: setWidgetHeight(0.5),
                decoration: const BoxDecoration(
                  color: greyShadow,
                  boxShadow: [
                    BoxShadow(
                      color: greyShadow,
                    ),
                  ],
                ),
              ),
              FittedBox(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: setWidgetHeight(10),
                      left: setWidgetWidth(10),
                      right: setWidgetWidth(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWithIcon(
                        translate(context, language.languageCode, finish)!,
                        Images.iconEditWhite,
                        () {
                          Navigator.pushNamed(
                              context, RouterHelper.postAdMainDetailFirstScreen,
                              arguments: draftProperty);
                        },
                        fontSize: 10,
                        height: 35,
                      ),
                      marginWidth(5),
                      ButtonWithIcon(
                        translate(context, language.languageCode, show)!,
                        Images.iconEye,
                        () {
                          Navigator.of(context).pushNamed(
                            RouterHelper.adDetailsScreen,
                            arguments: DetailScreenArguments(
                              draftProperty.id!,
                            ),
                          );
                        },
                        fontSize: 10,
                        height: 35,
                      ),
                      marginWidth(5),
                      ButtonWithIcon(
                        translate(context, language.languageCode, labelDelete)!,
                        Images.iconDeleteWhite,
                        () {
                          showModalBottomSheet(
                            backgroundColor: whitePrimary,
                            // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                            clipBehavior: Clip.antiAlias,
                            // set shape to make top corners rounded
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return DeleteConfirmationView(
                                  Images.iconDeleteWarning, () {
                                Navigator.of(context).pop();
                                controller
                                    .deleteProperty(
                                        context,
                                        RouterHelper.myAdsListScreen,
                                        draftProperty.id!)
                                    .then((value) {
                                  controller.removePropertyFromList(
                                      index, 0, context);
                                });
                              });
                            },
                          );
                        },
                        fontSize: 10,
                        height: 35,
                      ),
                      marginWidth(5),
                      ButtonWithIcon(
                        translate(context, language.languageCode, duplicate)!,
                        Images.iconDuplicate,
                        () {
                          showModalBottomSheet(
                            backgroundColor: whitePrimary,
                            // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                            clipBehavior: Clip.antiAlias,
                            // set shape to make top corners rounded
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return DuplicationConfirmationView(() {
                                Navigator.of(context).pop();
                                controller
                                    .duplicateProperty(
                                        context,
                                        RouterHelper.myAdsListScreen,
                                        draftProperty.id!)
                                    .then((value) {
                                  if (controller.duplicateModel.error ==
                                      false) {
                                    controller.getActivePropertyList(
                                      context,
                                      0,
                                      1,
                                      0,
                                      RouterHelper.myAdsListScreen,
                                    );
                                  }
                                });
                              });
                            },
                          );
                        },
                        fontSize: 10,
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
