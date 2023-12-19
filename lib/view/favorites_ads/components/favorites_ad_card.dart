import 'package:flutter/material.dart';
import 'package:immo/data/api_models/detail_arguments.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../helper/date_format.dart';
import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';

// ignore: must_be_immutable
class FavoritesListCard extends StatelessWidget {
  FavoritesListCard({super.key, required this.controller, required this.index});
  HomePageProvider controller;
  int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        final data = controller.favouriteModel.data![index];
        return Container(
            color: whitePrimary,
            child: int.tryParse(data.status.toString()) == 1
                ? Container(
                    padding: EdgeInsets.only(
                      left: setWidgetWidth(10),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: setWidgetHeight(10),
                      horizontal: setWidgetWidth(25),
                    ),
                    height: setWidgetHeight(165),
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
                    child: Row(
                      children: [
                        //Image of Card
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: setWidgetHeight(10),
                            horizontal: setWidgetHeight(10),
                          ),
                          width: setWidgetWidth(138),
                          height: setWidgetHeight(145),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyLight,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data.mainImage!),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: setWidgetHeight(18),
                                width: setWidgetWidth(48),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: whitePrimary,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    data.ownershipType == null
                                        ? "_"
                                        : data.ownershipType == 'for_rent'
                                            ? translate(context,
                                                language.languageCode, forRent)!
                                            : translate(
                                                context,
                                                language.languageCode,
                                                forSale)!,
                                    style: textStyle(
                                      fontSize: 6,
                                      color: blackPrimary,
                                      fontFamily: satoshiMedium,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
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
                                      data.imagesCount!.toString(),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: setWidgetWidth(12),
                              vertical: setWidgetHeight(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Title of Card
                                Text(
                                  data.title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle(
                                    fontSize: 12,
                                    color: blackPrimary,
                                    fontFamily: satoshiMedium,
                                  ),
                                ),
                                Text(
                                  data.availability == "for_date"
                                      ? "${translate(context, language.languageCode, added)!}: ${data.date == null ? "_" : dateFormat(data.date!)}"
                                      : "${translate(context, language.languageCode, added)!}: ${data.availability!.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle(
                                    fontSize: 8,
                                    color: greyLight,
                                    fontFamily: satoshiRegular,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const ImageIcon(
                                      AssetImage(Images.iconLocation),
                                      size: 14,
                                      color: bluePrimary,
                                    ),
                                    Text(
                                      " ${data.postcodeCity!}",
                                      style: textStyle(
                                        fontSize: 8,
                                        color: bluePrimary,
                                        fontFamily: satoshiBold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: setWidgetHeight(4),
                                  ),
                                  child: data.isPrice == false
                                      ? Text(
                                          '${translate(context, language.languageCode, price)!}: \$ ${data.price}',
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle(
                                            fontSize: 14,
                                            color: bluePrimary,
                                            fontFamily: satoshiBold,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const ImageIcon(
                                              AssetImage(Images.iconArea),
                                              size: 11,
                                              color: bluePrimary,
                                            ),
                                            marginWidth(5),
                                            SizedBox(
                                              width: setWidgetWidth(40),
                                              child: Text(
                                                data.floorSpace == null
                                                    ? "_"
                                                    : "${data.floorSpace.toString()}  m²",
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle(
                                                  fontSize: 8,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiRegular,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        marginHeight(15),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const ImageIcon(
                                              AssetImage(Images.iconBath),
                                              size: 11,
                                              color: bluePrimary,
                                            ),
                                            marginWidth(5),
                                            SizedBox(
                                              width: setWidgetWidth(40),
                                              child: Text(
                                                data.detail == null ||
                                                        data.detail!.interior ==
                                                            null ||
                                                        data.detail!.interior!
                                                                .numberOfBathrooms ==
                                                            null
                                                    ? "_"
                                                    : data.detail!.interior!
                                                        .numberOfBathrooms
                                                        .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle(
                                                  fontSize: 8,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiRegular,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    marginWidth(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const ImageIcon(
                                              AssetImage(Images.iconBed),
                                              size: 11,
                                              color: bluePrimary,
                                            ),
                                            marginWidth(5),
                                            SizedBox(
                                              width: setWidgetWidth(80),
                                              child: Text(
                                                data.numberOfRooms == null
                                                    ? "_"
                                                    : '${data.numberOfRooms!.toString()} ${translate(context, language.languageCode, bedrooms)!}',
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle(
                                                  fontSize: 8,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiRegular,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        marginHeight(15),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const ImageIcon(
                                              AssetImage(Images.iconGarage),
                                              size: 11,
                                              color: bluePrimary,
                                            ),
                                            marginWidth(5),
                                            SizedBox(
                                              width: setWidgetWidth(80),
                                              child: Text(
                                                data.detail == null ||
                                                        data.detail!.exterior ==
                                                            null ||
                                                        data.detail!.exterior!
                                                                .garage ==
                                                            false
                                                    ? "_"
                                                    : translate(
                                                        context,
                                                        language.languageCode,
                                                        garage)!,
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle(
                                                  fontSize: 8,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiRegular,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    marginWidth(5),
                                    InkWell(
                                      onTap: () {
                                        controller
                                            .favouriteUnFavourite(
                                                context,
                                                RouterHelper
                                                    .favoritesListScreen,
                                                data.id!)
                                            .then((value) {
                                          controller
                                              .removeFavouriteFromList(index);
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: setWidgetHeight(20)),
                                        child: const ImageIcon(
                                          AssetImage(
                                            Images.iconFavFilledRed,
                                          ),
                                          size: 20,
                                          color: redColor,
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
                  ).onPress(
                    () {
                      Navigator.of(context).pushNamed(
                          RouterHelper.adDetailsScreen,
                          arguments: DetailScreenArguments(data.id!));
                    },
                  )
                : Container(
                    padding: EdgeInsets.only(
                      left: setWidgetWidth(10),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: setWidgetHeight(10),
                      horizontal: setWidgetWidth(25),
                    ),
                    height: setWidgetHeight(165),
                    decoration: BoxDecoration(
                      color: greyShadow,
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
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            //Image of Card
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: setWidgetHeight(10),
                                horizontal: setWidgetHeight(10),
                              ),
                              width: setWidgetWidth(138),
                              height: setWidgetHeight(145),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: greyLight,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data.mainImage!),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: setWidgetHeight(18),
                                    width: setWidgetWidth(48),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: whitePrimary,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            data.ownershipType!)!,
                                        style: textStyle(
                                          fontSize: 6,
                                          color: blackPrimary,
                                          fontFamily: satoshiMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: setWidgetHeight(18),
                                    width: setWidgetWidth(41),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: whitePrimary,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const ImageIcon(
                                          AssetImage(Images.iconCamera),
                                          size: 8,
                                          color: bluePrimary,
                                        ),
                                        marginWidth(4),
                                        // Number of Images
                                        Text(
                                          data.imagesCount!.toString(),
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: setWidgetWidth(12),
                                  vertical: setWidgetHeight(12),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Title of Card
                                    Text(
                                      data.title!,
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle(
                                        fontSize: 12,
                                        color: blackPrimary,
                                        fontFamily: satoshiMedium,
                                      ),
                                    ),
                                    Text(
                                      data.availability == "for_date"
                                          ? "${translate(context, language.languageCode, added)!}: ${data.date == null ? "_" : dateFormat(data.date!)}"
                                          : "${translate(context, language.languageCode, added)!}: ${data.availability!.toString()}",
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle(
                                        fontSize: 8,
                                        color: greyLight,
                                        fontFamily: satoshiRegular,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const ImageIcon(
                                          AssetImage(Images.iconLocation),
                                          size: 14,
                                          color: bluePrimary,
                                        ),
                                        Text(
                                          " ${data.postcodeCity!}",
                                          style: textStyle(
                                            fontSize: 8,
                                            color: bluePrimary,
                                            fontFamily: satoshiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: setWidgetHeight(4),
                                      ),
                                      child: data.isPrice == false
                                          ? Text(
                                              '${translate(context, language.languageCode, price)!}: \$ ${data.price}',
                                              overflow: TextOverflow.ellipsis,
                                              style: textStyle(
                                                fontSize: 14,
                                                color: bluePrimary,
                                                fontFamily: satoshiBold,
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const ImageIcon(
                                                  AssetImage(Images.iconArea),
                                                  size: 11,
                                                  color: bluePrimary,
                                                ),
                                                marginWidth(5),
                                                Text(
                                                  data.floorSpace == null
                                                      ? "_"
                                                      : "${data.floorSpace.toString()}  m²",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textStyle(
                                                    fontSize: 8,
                                                    color: blackPrimary,
                                                    fontFamily: satoshiRegular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            marginHeight(15),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const ImageIcon(
                                                  AssetImage(Images.iconBath),
                                                  size: 11,
                                                  color: bluePrimary,
                                                ),
                                                marginWidth(5),
                                                Text(
                                                  data.detail == null ||
                                                          data.detail!
                                                                  .interior ==
                                                              null ||
                                                          data.detail!.interior!
                                                                  .numberOfBathrooms ==
                                                              null
                                                      ? "_"
                                                      : data.detail!.interior!
                                                          .numberOfBathrooms
                                                          .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textStyle(
                                                    fontSize: 8,
                                                    color: blackPrimary,
                                                    fontFamily: satoshiRegular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        marginWidth(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const ImageIcon(
                                                  AssetImage(Images.iconBed),
                                                  size: 11,
                                                  color: bluePrimary,
                                                ),
                                                marginWidth(5),
                                                SizedBox(
                                                  width: setWidgetWidth(80),
                                                  child: Text(
                                                    data.numberOfRooms == null
                                                        ? "_"
                                                        : '${data.numberOfRooms!.toString()} ${translate(context, language.languageCode, bedrooms)!}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: textStyle(
                                                      fontSize: 8,
                                                      color: blackPrimary,
                                                      fontFamily:
                                                          satoshiRegular,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            marginHeight(15),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const ImageIcon(
                                                  AssetImage(Images.iconGarage),
                                                  size: 11,
                                                  color: bluePrimary,
                                                ),
                                                marginWidth(5),
                                                Text(
                                                  data.detail == null ||
                                                          data.detail!
                                                                  .exterior ==
                                                              null ||
                                                          data.detail!.exterior!
                                                                  .garage ==
                                                              false
                                                      ? "_"
                                                      : translate(
                                                          context,
                                                          language.languageCode,
                                                          garage)!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textStyle(
                                                    fontSize: 8,
                                                    color: blackPrimary,
                                                    fontFamily: satoshiRegular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        marginWidth(5),
                                        InkWell(
                                          onTap: () {
                                            controller
                                                .favouriteUnFavourite(
                                                    context,
                                                    RouterHelper
                                                        .favoritesListScreen,
                                                    data.id!)
                                                .then((value) {
                                              controller
                                                  .removeFavouriteFromList(
                                                      index);
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: setWidgetHeight(20)),
                                            child: const ImageIcon(
                                              AssetImage(
                                                Images.iconFavFilledRed,
                                              ),
                                              size: 20,
                                              color: redColor,
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
                        Container(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(
                              right: setWidgetHeight(10),
                              top: setWidgetHeight(5),
                            ),
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              translate(
                                  context, language.languageCode, inactive)!,
                              style: textStyle(
                                  fontSize: 12,
                                  color: redColor,
                                  fontFamily: satoshiMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
