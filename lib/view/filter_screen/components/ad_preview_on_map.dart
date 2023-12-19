import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/view/filter_screen/components/preview_image_section.dart';
import 'package:provider/provider.dart';

import '../../../data/api_models/detail_arguments.dart';
import '../../../data/api_models/properties/property_list_model.dart';
import '../../../helper/date_format.dart';
import '../../../helper/routes_helper.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/home_page_provider.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../ad_details/components/heading_text.dart';
import '../../widgets/custom_button.dart';

// ignore: must_be_immutable
class AdPreview extends StatelessWidget {
  AdPreview({super.key, required this.data});
  PropertiesData data;

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, HomePageProvider>(
      builder: (context, language, controller, child) {
        return Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  PreviewImageSection(
                    controller: controller,
                    languageProvider: language,
                    detailImages: data.documents?.images,
                    id: data.id,
                  ),
                  //===============================================
                  // Main Data
                  //===============================================
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Title------------------------------------------------
                        Text(
                          data.title == null ? "_" : data.title!,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle(
                            fontSize: 20,
                            color: blackLight,
                            fontFamily: satoshiMedium,
                          ),
                        ),
                        marginHeight(2),
                        // Added Date------------------------------------------------
                        Text(
                          data.availability == null
                              ? "_"
                              : data.availability == "for_date"
                                  ? "${translate(context, language.languageCode, added)!}:  ${dateFormat(data.date!)}"
                                  : "${translate(context, language.languageCode, added)!}: ${data.availability!.toString()}",
                          style: textStyle(
                            fontSize: 14,
                            color: greyLight,
                            fontFamily: satoshiMedium,
                          ),
                        ),
                        marginHeight(11),
                        //Price------------------------------------------------
                        Text(
                          '${translate(context, language.languageCode, price)!}:  ${data.price == null ? "_" : data.price!.toString()}',
                          style: textStyle(
                            fontSize: 22,
                            color: bluePrimary,
                            fontFamily: satoshiBold,
                          ),
                        ),
                        marginHeight(13),
                        //===========================================================
                        // Icons With data
                        //===========================================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Area (m²)------------------------------------------------
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.iconArea,
                                      width: setWidgetWidth(20),
                                      height: setWidgetHeight(20),
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
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                marginHeight(20),
                                // Garage------------------------------------------------
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.iconGarage,
                                      width: setWidgetWidth(20),
                                      height: setWidgetHeight(20),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: setWidgetWidth(5),
                                      ),
                                      child: Text(
                                        data.detail == null ||
                                                data.detail!.exterior == null ||
                                                data.detail!.exterior!.garage ==
                                                    false
                                            ? "_"
                                            : translate(context,
                                                language.languageCode, garage)!,
                                        style: textStyle(
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //Bedrooms------------------------------------------------
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.iconBed,
                                      width: setWidgetWidth(20),
                                      height: setWidgetHeight(20),
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
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //Bathrooms------------------------------------------------
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.iconBath,
                                      width: setWidgetWidth(20),
                                      height: setWidgetHeight(20),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: setWidgetWidth(5),
                                      ),
                                      child: Text(
                                        data.detail == null ||
                                                data.detail!.interior == null ||
                                                data.detail!.interior!
                                                        .numberOfBathrooms ==
                                                    null
                                            ? "_"
                                            : '${data.detail!.interior!.numberOfBathrooms.toString()} ${translate(context, language.languageCode, bathrooms)!}',
                                        style: textStyle(
                                          fontSize: 12,
                                          color: blackPrimary,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        //==============================================
                        // Address
                        //==============================================
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            marginHeight(20),
                            getHeading(translate(
                                context, language.languageCode, address)!),
                            marginHeight(15),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  width: setWidgetWidth(25),
                                  height: setWidgetHeight(25),
                                  image: const AssetImage(
                                    Images.iconLocationOrange,
                                  ),
                                ),
                                marginHeight(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.postcodeCity == null
                                            ? "_"
                                            : data.postcodeCity!,
                                        style: textStyle(
                                          fontSize: 14,
                                          color: greyLight,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                      Text(
                                        translate(
                                            context,
                                            language.languageCode,
                                            fullAddressMsg)!,
                                        style: textStyle(
                                          fontSize: 14,
                                          color: greyLight,
                                          fontFamily: satoshiRegular,
                                        ),
                                      ),
                                      marginHeight(10),
                                      // Full Detail Button------------------------------------------------
                                      FittedBox(
                                        child: CustomButton(
                                          buttonHeight: 40,
                                          buttonWidth: 300,
                                          buttonColor: bluePrimary,
                                          buttonTextColor: whitePrimary,
                                          buttonText: translate(
                                              context,
                                              language.languageCode,
                                              fullDetail)!,
                                          radiusSize: 10,
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              RouterHelper.adDetailsScreen,
                                              arguments: DetailScreenArguments(
                                                data.id!,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
