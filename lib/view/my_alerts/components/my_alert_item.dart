import 'dart:async';

import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/view/widgets/button_with_icon.dart';
import 'package:provider/provider.dart';

import '../../../helper/debouncer.dart';
import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/launch_url.dart';
import '../../../utils/string.dart';
import '../../widgets/Shimmer/shimmer_favourite.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/delete_confirmation_view.dart';
import '../../widgets/no_data_found.dart';

class MyAlertItem extends StatelessWidget {
  const MyAlertItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final debouncer = DeBouncer(milliseconds: 300);
    return Consumer2<LanguageProvider, FilterScreenProvider>(
      builder: (context, language, controller, child) {
        return controller.isLoading == true
            ? const ShimmerFavourite()
            : controller.getAlertModel.data == null ||
                    controller.getAlertModel.data!.isEmpty
                ? const NoDataFound()
                : ListView.builder(
                    itemCount: controller.getAlertModel.data!.length,
                    itemBuilder: (context, position) {
                      final data = controller.getAlertModel.data![position];
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: setWidgetWidth(20),
                            vertical: setWidgetHeight(10)),
                        margin: EdgeInsets.only(
                            left: setWidgetWidth(25),
                            right: setWidgetWidth(25),
                            top: setWidgetHeight(20)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whitePrimary,
                          border: Border.all(width: 1, color: greyShadow),
                          boxShadow: const [
                            BoxShadow(
                                color: greyShadow,
                                blurRadius: 5,
                                offset: Offset(1, 1))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name == null ? "_" : data.name!,
                                  style: textStyle(
                                      fontSize: 16,
                                      color: blackLight,
                                      fontFamily: satoshiMedium),
                                ),
                                Text(
                                  translate(context, language.languageCode,
                                      searchCriteria)!,
                                  style: textStyle(
                                      fontSize: 10,
                                      color: greyLight,
                                      fontFamily: satoshiRegular),
                                ),
                                SizedBox(
                                  height: setWidgetHeight(8),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.iconLocationColored,
                                                width: setWidgetWidth(12),
                                                height: setWidgetHeight(15),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: setWidgetWidth(5),
                                                ),
                                                child: SizedBox(
                                                  width: setWidgetWidth(140),
                                                  child: Text(
                                                    data.address == null
                                                        ? "_"
                                                        : data.address!
                                                            .postcodeCity!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: textStyle(
                                                        fontSize: 12,
                                                        color: blackPrimary,
                                                        fontFamily:
                                                            satoshiRegular),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: setWidgetHeight(10),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.iconHomeColored,
                                                width: setWidgetWidth(12),
                                                height: setWidgetHeight(15),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: setWidgetWidth(5),
                                                ),
                                                child: Text(
                                                  data.ownershipType == null
                                                      ? "_"
                                                      : data.ownershipType ==
                                                              'for_rent'
                                                          ? translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              forRent)!
                                                          : translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              forSale)!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: textStyle(
                                                      fontSize: 12,
                                                      color: blackPrimary,
                                                      fontFamily:
                                                          satoshiRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: setWidgetHeight(10),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.iconDollerColored,
                                                width: setWidgetWidth(12),
                                                height: setWidgetHeight(15),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: setWidgetWidth(5),
                                                ),
                                                child: SizedBox(
                                                  width: setWidgetWidth(140),
                                                  child: Text(
                                                    "${data.priceRange!.min == null ? "_" : data.priceRange!.min.toString()}  - "
                                                    "${data.priceRange!.max == null ? "_" : data.priceRange!.max.toString()} ",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: textStyle(
                                                        fontSize: 12,
                                                        color: blackPrimary,
                                                        fontFamily:
                                                            satoshiRegular),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: setWidgetHeight(10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: setWidgetWidth(5),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.iconBedBlack,
                                                width: setWidgetWidth(12),
                                                height: setWidgetHeight(15),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: setWidgetWidth(5),
                                                ),
                                                child: SizedBox(
                                                  width: setWidgetWidth(140),
                                                  child: Text(
                                                    data.bedRooms == null
                                                        ? "_"
                                                        : data.bedRooms!
                                                            .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: textStyle(
                                                        fontSize: 12,
                                                        color: blackPrimary,
                                                        fontFamily:
                                                            satoshiRegular),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: setWidgetHeight(15),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.iconAreaColored,
                                                width: setWidgetWidth(12),
                                                height: setWidgetHeight(15),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: setWidgetWidth(5),
                                                ),
                                                child: SizedBox(
                                                  width: setWidgetWidth(140),
                                                  child: Text(
                                                    data.livingSpaceRange ==
                                                            null
                                                        ? "_"
                                                        : "${data.livingSpaceRange!.min == null ? "_" : data.livingSpaceRange!.min.toString()}  - "
                                                            "${data.livingSpaceRange!.max == null ? "_" : data.livingSpaceRange!.max.toString()} ",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: textStyle(
                                                        fontSize: 12,
                                                        color: blackPrimary,
                                                        fontFamily:
                                                            satoshiRegular),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${translate(context, language.languageCode, alertActiveMsg)!} ${data.validTill}',
                                    style: textStyle(
                                        fontSize: 12,
                                        color: greyPrimary,
                                        fontFamily: satoshiRegular),
                                  ),
                                ),
                                const Divider(),
                                SizedBox(
                                  height: setWidgetHeight(2),
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      ButtonWithIcon(
                                        translate(context,
                                            language.languageCode, labelEdit)!,
                                        Images.iconEditWhite,
                                        () {
                                          Future.delayed(
                                            Duration.zero,
                                            () {
                                              controller.setIsEdit(1);
                                              controller.setAlertId(
                                                  data.id!, position);
                                            },
                                          );

                                          Navigator.of(context)
                                              .pushNamed(
                                                  RouterHelper.filterScreen)
                                              .then(
                                            (value) {
                                              controller.getAlertList(context,
                                                  RouterHelper.myAdsListScreen);
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: setWidgetWidth(10),
                                      ),
                                      ButtonWithIcon(
                                        translate(
                                            context,
                                            language.languageCode,
                                            labelDelete)!,
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
                                                Images.iconDeleteWarning,
                                                () {
                                                  Navigator.of(context).pop();
                                                  controller
                                                      .deleteAlert(
                                                          context,
                                                          RouterHelper.myAlerts,
                                                          data.id!)
                                                      .then(
                                                    (value) {
                                                      controller
                                                          .removeAlertFromList(
                                                        position,
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: setWidgetWidth(10),
                                      ),
                                      ButtonWithIcon(
                                        translate(context,
                                            language.languageCode, showOnMap)!,
                                        Images.iconMapWhite,
                                        () {
                                          debouncer.run(
                                            () {
                                              if (data.address != null) {
                                                final url =
                                                    'https://www.google.com/maps/search/?api=1&query=${data.address!.lat},${data.address!.lng}';
                                                launchInAppURL(url);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  // ignore: use_build_context_synchronously
                                                  customSnackBar(
                                                    context,
                                                    locationNotAvailable,
                                                    1,
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
      },
    );
  }
}
