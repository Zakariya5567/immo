import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/data/api_models/detail_arguments.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/ad_details/components/contact_form.dart';
import 'package:immo/view/ad_details/components/detail_dimension.dart';
import 'package:immo/view/widgets/button_with_icon.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/date_format.dart';
import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/images.dart';
import '../../utils/launch_url.dart';
import '../../utils/size.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../widgets/Shimmer/shimmer_detail.dart';
import '../widgets/custom_snackbar.dart';
import 'components/characteristics_with_icon.dart';
import 'components/detail_address.dart';
import 'components/detail_description.dart';
import 'components/detail_links.dart';
import 'components/detail_other_feature.dart';
import 'components/detail_price.dart';
import 'components/detail_surrounding.dart';
import 'components/exterior_data.dart';
import 'components/heading_text.dart';
import 'components/image_section.dart';
import 'components/interior_data.dart';
import 'components/more_information.dart';
import 'components/report_section.dart';
import 'components/technics_data.dart';

class AdDetailsScreen extends StatefulWidget {
  const AdDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? userId;

  @override
  void initState() {
    super.initState();
    callingApi();
  }

  callingApi() {
    Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context)?.settings.arguments as DetailScreenArguments;
      final homeController =
          Provider.of<HomePageProvider>(context, listen: false);
      homeController.setDetailLoading(true);

      homeController.getPropertyById(
          context, RouterHelper.adDetailsScreen, args.id);
      if (homeController.reportList.isEmpty) {
        homeController.getReportAdList(context, RouterHelper.adDetailsScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          key: scaffoldKey,
          body: Consumer2<LanguageProvider, HomePageProvider>(
            builder: (context, language, controller, child) {
              final data = controller.propertiesDetailModel.data;

              return controller.isDetailLoading == true || data == null
                  ? const ShimmerDetail()
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              ImageSection(
                                controller: controller,
                                languageProvider: language,
                                detailImages: data.documents?.images,
                                isFavourite: data.isFavourite!,
                                id: data.id,
                                createdBy: data.createdBy.toString(),
                              ),

                              //===============================================
                              // Main Data
                              Padding(
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.title == null ? "_" : data.title!,
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle(
                                          fontSize: 20,
                                          color: blackLight,
                                          fontFamily: satoshiMedium),
                                    ),
                                    SizedBox(height: setWidgetHeight(2)),
                                    Text(
                                      data.availability == null
                                          ? "_"
                                          : data.availability == "for_date"
                                              ? "${translate(context, language.languageCode, added)!}:  ${dateFormat(data.date!)}"
                                              : "${translate(context, language.languageCode, added)!}: ${data.availability!.toString()}",
                                      style: textStyle(
                                          fontSize: 14,
                                          color: greyLight,
                                          fontFamily: satoshiMedium),
                                    ),
                                    SizedBox(height: setWidgetHeight(11)),
                                    Text(
                                      '${translate(context, language.languageCode, price)!}:  ${data.price == null ? "_" : data.price!.toString()}',
                                      style: textStyle(
                                          fontSize: 22,
                                          color: bluePrimary,
                                          fontFamily: satoshiBold),
                                    ),
                                    SizedBox(
                                      height: setWidgetHeight(13),
                                    ),

                                    //===========================================================
                                    // Icons With data
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: setWidgetWidth(180),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
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
                                                          fontFamily:
                                                              satoshiRegular),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              marginHeight(20),
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
                                                              data.detail!
                                                                      .exterior ==
                                                                  null ||
                                                              data
                                                                      .detail!
                                                                      .exterior!
                                                                      .garage ==
                                                                  false
                                                          ? "_"
                                                          : translate(
                                                              context,
                                                              language
                                                                  .languageCode,
                                                              garage)!,
                                                      style: textStyle(
                                                          fontSize: 12,
                                                          color: blackPrimary,
                                                          fontFamily:
                                                              satoshiRegular),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                        fontFamily:
                                                            satoshiRegular),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            marginHeight(20),
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
                                                            data.detail!
                                                                    .interior ==
                                                                null ||
                                                            data
                                                                    .detail!
                                                                    .interior!
                                                                    .numberOfBathrooms ==
                                                                null
                                                        ? "_"
                                                        : '${data.detail!.interior!.numberOfBathrooms.toString()} ${translate(context, language.languageCode, bathrooms)!}',
                                                    style: textStyle(
                                                        fontSize: 12,
                                                        color: blackPrimary,
                                                        fontFamily:
                                                            satoshiRegular),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Wrap(
                                    //   spacing: setWidgetWidth(30),
                                    //   runSpacing: setWidgetHeight(20),
                                    //   alignment: WrapAlignment.start,
                                    //   direction: Axis.horizontal,
                                    //   children: [
                                    //     FittedBox(
                                    //       child:
                                    //     ),
                                    //   ],
                                    // ),

                                    //==============================================
                                    // Address

                                    DetailAddress(
                                        controller: controller,
                                        language: language),

                                    //==============================================
                                    // More information

                                    MoreInformation(
                                        controller: controller,
                                        language: language),

                                    //==============================================================
                                    //price

                                    DetailPrice(
                                        controller: controller,
                                        language: language),

                                    //==============================================================
                                    //description

                                    DetailDescription(
                                        controller: controller,
                                        language: language),
                                    //==============================================================
                                    //Dimension

                                    DetailDimension(
                                        controller: controller,
                                        language: language),

                                    //==============================================================
                                    //interior

                                    InteriorData(
                                        controller: controller,
                                        language: language),

                                    //====================================================
                                    // Technics
                                    TechnicsData(
                                        controller: controller,
                                        language: language),

                                    //====================================================
                                    // Exterior

                                    ExteriorData(
                                        controller: controller,
                                        language: language),
                                    //==============================================================
                                    //Other Features
                                    OtherFeatures(
                                        controller: controller,
                                        language: language),
                                    //==============================================================
                                    //Links
                                    DetailsLinks(
                                        controller: controller,
                                        language: language),
                                    //==============================================================
                                    //Surroundings
                                    SurroundingDetail(
                                        controller: controller,
                                        language: language),
                                    //==============================================================
                                    // Characteristics
                                    CharacteristicsWithIcon(
                                      controller: controller,
                                      language: language,
                                      slug: data.slug,
                                      id: data.id,
                                    ),

                                    //==============================================================
                                    // Report section
                                    controller.userId ==
                                            data.createdBy.toString()
                                        ? const SizedBox()
                                        : ReportSection(
                                            controller: controller,
                                            language: language,
                                            scaffoldKey: scaffoldKey,
                                            formKey: formKey,
                                          ),

                                    //=====================================================
                                    // Advisor
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        marginHeight(20),
                                        getHeading(translate(
                                            context,
                                            language.languageCode,
                                            advertiser)!),
                                        marginHeight(15),
                                        data.contact!.contactPerson != null
                                            ? Text(
                                                data.contact!.contactPerson!,
                                                style: textStyle(
                                                    fontSize: 14,
                                                    color: blackPrimary,
                                                    fontFamily: satoshiRegular),
                                              )
                                            : const SizedBox(),
                                        data.contact!.email != null
                                            ? Text(
                                                data.contact!.email!,
                                                style: textStyle(
                                                  fontSize: 14,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiRegular,
                                                ),
                                              )
                                            : const SizedBox(),
                                        data.contact!.telephoneNumber != null
                                            ? Text(
                                                data.contact!.telephoneNumber!,
                                                style: textStyle(
                                                  fontSize: 14,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiRegular,
                                                ),
                                              )
                                            : const SizedBox(),
                                        data.contact!.comment != null
                                            ? Text(
                                                data.contact!.comment!,
                                                style: textStyle(
                                                  fontSize: 14,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiRegular,
                                                ),
                                              )
                                            : const SizedBox(),
                                        data.publisher!.website != null
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  marginHeight(10),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${translate(context, language.languageCode, advertiser)!} ${translate(context, language.languageCode, website)!}",
                                                        style: textStyle(
                                                            fontSize: 16,
                                                            color: bluePrimary,
                                                            fontFamily:
                                                                satoshiRegular),
                                                      ),
                                                      marginWidth(5),
                                                      const ImageIcon(
                                                        AssetImage(
                                                          Images.iconOpenNewTab,
                                                        ),
                                                        color: bluePrimary,
                                                        size: 16,
                                                      ),
                                                    ],
                                                  ).onPress(() async {
                                                    final website = Uri.parse(
                                                        data.publisher!
                                                            .website!);
                                                    await launchUrl(website);
                                                  }),
                                                ],
                                              )
                                            : const SizedBox(),
                                        marginHeight(20),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),

                        //=====================================================
                        // Buttons
                        controller.userId == data.createdBy.toString()
                            ? const SizedBox()
                            : Container(
                                height: setWidgetHeight(75),
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    left: setWidgetWidth(30),
                                    right: setWidgetWidth(30),
                                    top: setWidgetHeight(10),
                                    bottom: setWidgetHeight(10)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: setWidgetWidth(133),
                                        child: ButtonWithIcon(
                                            translate(context,
                                                language.languageCode, call)!,
                                            Images.iconPhone,
                                            bgColor: orangePrimary,
                                            height: 50,
                                            iconSize: 20,
                                            fontSize: 16,
                                            borderRadius: 08, () {
                                          try {
                                            if (data.contact!.telephoneNumber !=
                                                null) {
                                              String callNumber =
                                                  'tel:${data.contact!.telephoneNumber}';
                                              launchInAppURL(callNumber);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                customSnackBar(context,
                                                    phoneNumberNotAvailable, 1),
                                              );
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              customSnackBar(context,
                                                  callDidNotForword, 1),
                                            );
                                          }
                                        })),
                                    SizedBox(
                                        width: setWidgetWidth(206),
                                        child: ButtonWithIcon(
                                            translate(
                                                context,
                                                language.languageCode,
                                                contactForm)!,
                                            Images.iconForm,
                                            height: 50,
                                            iconSize: 20,
                                            fontSize: 16,
                                            borderRadius: 08, () {
                                          controller.clearTextField();
                                          showModalBottomSheet(
                                            isScrollControlled: true,
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
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: ContactForm(
                                                    id: data.id!,
                                                    scaffoldKey: scaffoldKey,
                                                    controller: controller,
                                                    formKey: formKey,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }))
                                  ],
                                ),
                              )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
