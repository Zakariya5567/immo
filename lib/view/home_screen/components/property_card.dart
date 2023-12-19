import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';

import '../../../data/api_models/detail_arguments.dart';
import '../../../helper/date_format.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/images.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class PropertyCard extends StatelessWidget {
  bool isActive;
  HomePageProvider controller = HomePageProvider();
  int index;
  PropertyCard(this.isActive,
      {super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        final data = controller.propertiesListModel.data![index];
        return Container(
          width: setWidgetWidth(230),
          height: setWidgetHeight(290),
          padding: EdgeInsets.all(setWidgetWidth(6)),
          decoration: const BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Stack(children: [
                    Container(
                      width: setWidgetWidth(230),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              data.mainImage!,
                            )),
                        color: greyShadow,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: setWidgetHeight(13),
                          left: setWidgetWidth(10)),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                              width: setWidgetWidth(isActive ? 58 : 50),
                              height: setWidgetHeight(isActive ? 18 : 16),
                              decoration: BoxDecoration(
                                  color: whitePrimary,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: greyShadow)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: setWidgetWidth(2),
                                  ),
                                  child: Center(
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
                                        fontSize: isActive ? 8 : 6,
                                        color: blackLight,
                                        fontFamily: satoshiMedium),
                                  ))))),
                    )
                  ])),
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: setWidgetHeight(7)),
                        Text(
                          data.title!,
                          style: textStyle(
                              fontSize: isActive ? 12 : 10,
                              color: blackLight,
                              fontFamily: satoshiMedium),
                        ),
                        SizedBox(height: setWidgetHeight(2)),
                        Text(
                          data.availability == "for_date"
                              ? "${translate(context, language.languageCode, added)!}:  ${data.date == null ? "_" : dateFormat(data.date!)}"
                              : "${translate(context, language.languageCode, added)!}: ${data.availability!.toString()}",
                          style: textStyle(
                              fontSize: isActive ? 8 : 6,
                              color: greyLight,
                              fontFamily: satoshiMedium),
                        ),
                        SizedBox(height: setWidgetHeight(2)),
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Image.asset(
                                  Images.iconLocation,
                                  width: setWidgetWidth(12.6),
                                  height: setWidgetHeight(12.6),
                                ),
                              ),
                              TextSpan(
                                  text: "",
                                  style: textStyle(
                                      fontSize: 8,
                                      color: bluePrimary,
                                      fontFamily: satoshiRegular)),
                              TextSpan(
                                  text: data.postcodeCity!,
                                  style: textStyle(
                                      fontSize: 8,
                                      color: bluePrimary,
                                      fontFamily: satoshiRegular)),
                            ],
                          ),
                        ),
                        SizedBox(height: setWidgetHeight(isActive ? 11 : 5)),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: setWidgetWidth(180),
                              child: Text(
                                '${translate(context, language.languageCode, price)!}: ${data.price}',
                                overflow: TextOverflow.ellipsis,
                                style: textStyle(
                                    fontSize: isActive ? 14 : 10,
                                    color: bluePrimary,
                                    fontFamily: satoshiBold),
                              ),
                            ),
                            controller.userId == data.createdBy.toString()
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      controller
                                          .favouriteUnFavourite(context,
                                              RouterHelper.homeScreen, data.id!)
                                          .then((value) {
                                        if (controller.favouriteUnFavouriteModel
                                                .error ==
                                            false) {
                                          controller
                                              .setPropertyFavouriteIconById(
                                                  data.id!, context);
                                        }
                                      });
                                    },
                                    child: Image.asset(
                                      data.isFavourite == true
                                          ? Images.iconFavFilledRed
                                          : Images.iconFavUnfilled,
                                      width: setWidgetWidth(isActive ? 22 : 14),
                                      height:
                                          setWidgetHeight(isActive ? 20 : 12),
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: setWidgetHeight(isActive ? 13 : 8),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: setWidgetWidth(100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Images.iconArea,
                                        width: setWidgetWidth(10.1),
                                        height: setWidgetHeight(10.1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: setWidgetWidth(5),
                                        ),
                                        child: Text(
                                          data.floorSpace == null
                                              ? "_"
                                              : "${data.floorSpace.toString()}  m²",
                                          style: textStyle(
                                              fontSize: 7,
                                              color: blackPrimary,
                                              fontFamily: satoshiRegular),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: setWidgetHeight(isActive ? 12 : 8),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        Images.iconGarage,
                                        width: setWidgetWidth(10.1),
                                        height: setWidgetHeight(10.1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: setWidgetWidth(5),
                                        ),
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
                                          style: textStyle(
                                              fontSize: 7,
                                              color: blackPrimary,
                                              fontFamily: satoshiRegular),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          Images.iconBed,
                                          width: setWidgetWidth(10.1),
                                          height: setWidgetHeight(10.1),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: setWidgetWidth(5),
                                          ),
                                          child: Text(
                                            data.numberOfRooms == null
                                                ? "_"
                                                : '${data.numberOfRooms!.toString()} ${translate(context, language.languageCode, bedrooms)!}',
                                            style: textStyle(
                                                fontSize: 7,
                                                color: blackPrimary,
                                                fontFamily: satoshiRegular),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: setWidgetHeight(isActive ? 12 : 8),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          Images.iconBath,
                                          width: setWidgetWidth(10.1),
                                          height: setWidgetHeight(10.1),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: setWidgetWidth(5),
                                          ),
                                          child: Text(
                                            data.detail == null ||
                                                    data.detail!.interior ==
                                                        null ||
                                                    data.detail!.interior!
                                                            .numberOfBathrooms ==
                                                        null
                                                ? "_"
                                                : '${data.detail!.interior!.numberOfBathrooms.toString()} ${translate(context, language.languageCode, bathrooms)!}',
                                            style: textStyle(
                                                fontSize: 7,
                                                color: blackPrimary,
                                                fontFamily: satoshiRegular),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ).onPress(() {
          Navigator.of(context).pushNamed(RouterHelper.adDetailsScreen,
              arguments: DetailScreenArguments(
                data.id!,
              ));
        });
      },
    );
  }
}
