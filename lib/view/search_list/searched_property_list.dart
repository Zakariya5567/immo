import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/provider/filter_screen_provider.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/search_list/components/beds_range_sheet.dart';
import 'package:immo/view/search_list/components/button_with_left_icon.dart';
import 'package:immo/view/search_list/components/price_range_sheet.dart';
import 'package:immo/view/search_list/components/search_list_card.dart';
import 'package:immo/view/widgets/button_with_icon.dart';
import 'package:immo/view/widgets/no_data_found.dart';
import 'package:provider/provider.dart';

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/size.dart';
import '../filter_screen/components/select_city_dialog.dart';
import '../widgets/Shimmer/shimmer_favourite.dart';
import 'components/area_range_sheet.dart';
import 'components/baths_range_sheet.dart';
import 'components/sort_radio_list.dart';

class SearchedList extends StatefulWidget {
  const SearchedList({super.key});

  @override
  State<SearchedList> createState() => _SearchedListState();
}

class _SearchedListState extends State<SearchedList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    callingListener();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  callingListener() {
    Future.delayed(Duration.zero, () {
      final filterProvider =
          Provider.of<FilterScreenProvider>(context, listen: false);
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
                scrollController.offset &&
            filterProvider.isLoading == false) {
          callingApi(1);
        }
      });
    });
  }

  callingApi(int isPagination) {
    Future.delayed(Duration.zero, () {
      final filterProvider =
          Provider.of<FilterScreenProvider>(context, listen: false);
      if (isPagination == 0) {
        filterProvider.setLoading(true);
        filterProvider.resetPages();
        filterProvider.getFilterData(context, isPagination,
            filterProvider.currentPage, RouterHelper.favoritesListScreen);
      } else {
        filterProvider.setPageIncrement();
        filterProvider.getFilterData(context, isPagination,
            filterProvider.currentPage, RouterHelper.favoritesListScreen);
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
        child: Consumer2<FilterScreenProvider, HomePageProvider>(
          builder: (context, controller, homeProvider, child) {
            return Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Scaffold(
                  key: scaffoldKey,
                  appBar: AppBar(
                    title: Consumer<LanguageProvider>(
                      builder: (context, language, child) {
                        return Text(
                          translate(
                              context, language.languageCode, houseForSale)!,
                          style: textStyle(
                              fontSize: 18,
                              color: whitePrimary,
                              fontFamily: satoshiMedium),
                        );
                      },
                    ),
                    // Back Button
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const ImageIcon(
                        AssetImage(Images.arrowBackIcon),
                        size: 23,
                      ),
                    ),
                    centerTitle: false,
                  ),
                  body: Column(
                    children: [
                      SizedBox(
                        height: setWidgetHeight(60),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: setWidgetWidth(25),
                              top: setWidgetHeight(10),
                              right: setWidgetWidth(25),
                            ),
                            child: Row(
                              children: [
                                ButtonWithIcon(
                                  translate(
                                      context, language.languageCode, sortBy)!,
                                  Images.iconLayer,
                                  //Stor by Button
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
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: setWidgetWidth(35),
                                            vertical: setWidgetHeight(35),
                                          ),
                                          child: Wrap(
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translate(
                                                            context,
                                                            language
                                                                .languageCode,
                                                            sortBy)!,
                                                        style: textStyle(
                                                          fontSize: 22,
                                                          color: blackPrimary,
                                                          fontFamily:
                                                              satoshiBold,
                                                        ),
                                                      ),
                                                      //Close Button
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const ImageIcon(
                                                          AssetImage(
                                                            Images.iconClose,
                                                          ),
                                                          size: 24,
                                                          color: blackPrimary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  marginHeight(18),
                                                  SortRadioList(
                                                      controller: controller,
                                                      list: controller
                                                          .searchSortRadioList,
                                                      scaffoldKey: scaffoldKey)
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  textColor: blackPrimary,
                                  bgColor: whitePrimary,
                                  height: 38,
                                ),
                                marginWidth(10),
                                ButtonWithLeftIcon(
                                  translate(context, language.languageCode,
                                      location)!,
                                  Images.iconDownFilledTriangle,
                                  //Location Button
                                  () {
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
                                        return SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .vertical,
                                            ),
                                            child: SelectCityDialog(
                                              isHome: 0,
                                              scaffoldKey: scaffoldKey,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  textColor: blackPrimary,
                                  bgColor: whitePrimary,
                                ),
                                marginWidth(10),
                                ButtonWithLeftIcon(
                                  translate(context, language.languageCode,
                                      priceRange)!,
                                  Images.iconDownFilledTriangle,
                                  //Price Range Button
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
                                        return SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                            ),
                                            child: PriceRangeSheet(
                                              scaffoldKey: scaffoldKey,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  textColor: blackPrimary,
                                  bgColor: whitePrimary,
                                ),
                                marginWidth(10),
                                ButtonWithLeftIcon(
                                  translate(context, language.languageCode,
                                      areaRange)!,
                                  Images.iconDownFilledTriangle,
                                  //Area Range Button
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
                                        return SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                            ),
                                            child: AreaRangeSheet(
                                              scaffoldKey: scaffoldKey,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  textColor: blackPrimary,
                                  bgColor: whitePrimary,
                                ),
                                marginWidth(10),
                                ButtonWithLeftIcon(
                                  translate(context, language.languageCode,
                                      bedrooms)!,
                                  Images.iconDownFilledTriangle,
                                  //Bedrooms Button
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
                                        return const BedRoomsSelectionRange();
                                      },
                                    );
                                  },
                                  textColor: blackPrimary,
                                  bgColor: whitePrimary,
                                ),
                                marginWidth(10),
                                ButtonWithLeftIcon(
                                  //Bathrooms Button
                                  translate(context, language.languageCode,
                                      bathrooms)!,
                                  Images.iconDownFilledTriangle,
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
                                        return const BathRoomsSelectionRange();
                                      },
                                    );
                                  },
                                  textColor: blackPrimary,
                                  bgColor: whitePrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      controller.propertiesListModel.data == null ||
                              controller.propertiesListModel.data!.isEmpty
                          ? const NoDataFound()
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                itemCount: controller
                                        .propertiesListModel.data!.length +
                                    1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      controller
                                          .propertiesListModel.data!.length) {
                                    return Container(
                                        color: whitePrimary,
                                        child: SearchListCard(
                                          controller: controller,
                                          index: index,
                                          createdBy: homeProvider.userId!,
                                        ));
                                  } else {
                                    return controller.isPagination == true
                                        ? const ShimmerFavoriteCard()
                                        : const SizedBox();
                                  }
                                },
                              ),
                            ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
