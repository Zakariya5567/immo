import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/Shimmer/property_list/property_list_shimmer.dart';
import 'package:immo/view/widgets/no_data_found.dart';
import 'package:provider/provider.dart';
import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/home_page_provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/string.dart';
import '../../utils/style.dart';
import '../widgets/bottom_nevigation_bar.dart';
import 'components/active_list_card.dart';
import 'components/draft_list_card.dart';

class MyAdsList extends StatefulWidget {
  const MyAdsList({super.key});

  @override
  State<MyAdsList> createState() => _MyAdsListState();
}

class _MyAdsListState extends State<MyAdsList>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    callingListener();
    callingAPI(0, 0);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _tabController.dispose();
  }

  callingListener() {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      // SCroll controller Listner
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
                scrollController.offset &&
            homePageProvider.isLoading == false) {
          callingAPI(1, _tabController.index);
        }
      });
    });

    // Tab Bar Listner
    Future.delayed(Duration.zero, () {
      _tabController.addListener(() {
        callingAPI(0, _tabController.index);
      });
    });
  }

  callingAPI(int isPagination, int index) {
    final homeProvider = Provider.of<HomePageProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      if (isPagination == 0) {
        homeProvider.setLoading(true);
        homeProvider.resetPages();
        await homeProvider.getActivePropertyList(
            context, isPagination, homeProvider.currentPage, index, RouterHelper.myAdsListScreen);
      } else {
        homeProvider.setPageIncrement();
        await homeProvider.getActivePropertyList(context, isPagination,
            homeProvider.currentPage, index, RouterHelper.myAdsListScreen);
      }
    });
  }

  Future<void> onDraftRefresh() async {
    callingAPI(0, 0);
  }

  Future<void> onActiveRefresh() async {
    callingAPI(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Text(
                  translate(context, language.languageCode, myAds)!,
                  style: textStyle(
                    fontSize: 20,
                    color: whitePrimary,
                    fontFamily: satoshiMedium,
                  ),
                );
              },
            ),
          ),
          body: Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Consumer<HomePageProvider>(
                builder: (context, controller, child) {
                  return DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(kToolbarHeight),
                        child: TabBar(
                          controller: _tabController,
                          padding: EdgeInsets.only(
                            top: setWidgetHeight(5),
                            bottom: setWidgetHeight(5),
                          ),
                          overlayColor:
                              MaterialStateProperty.all<Color>(whitePrimary),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: bluePrimary,
                          labelStyle: textStyle(
                            fontSize: 18,
                            color: blackPrimary,
                            fontFamily: satoshiMedium,
                          ),
                          unselectedLabelColor: greyPrimary,
                          labelColor: bluePrimary,
                          tabs: [
                            Tab(
                              text: translate(context, language.languageCode,
                                  draftsFolder)!,
                            ),
                            Tab(
                              text: translate(
                                  context, language.languageCode, activeAds)!,
                            ),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          //Draft List
                          controller.isdraftListLoading == true
                              ? ListView.builder(
                                  itemCount: 6,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      color: whitePrimary,
                                      child: const PropertiesListShimmer(),
                                    );
                                  },
                                )
                              : controller.draftPropertiesList.isEmpty
                                  ? const NoDataFound()
                                  : RefreshIndicator(
                                      onRefresh: onDraftRefresh,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              controller: scrollController,
                                              scrollDirection: Axis.vertical,
                                              physics: const ScrollPhysics(),
                                              itemCount: controller
                                                      .draftPropertiesList
                                                      .length +
                                                  1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (index <
                                                    controller
                                                        .draftPropertiesList
                                                        .length) {
                                                  return Container(
                                                    color: whitePrimary,
                                                    child: DraftListCard(
                                                      draftProperty: controller
                                                              .draftPropertiesList[
                                                          index],
                                                      controller: controller,
                                                      index: index,
                                                    ),
                                                  );
                                                } else {
                                                  return controller
                                                              .isPagination ==
                                                          true
                                                      ? Container(
                                                          color: whitePrimary,
                                                          child:
                                                              const PropertiesListShimmer(),
                                                        )
                                                      : const SizedBox();
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          //Active Ads List
                          controller.isActiveListLoading == true
                              ? ListView.builder(
                                  itemCount: 6,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      color: whitePrimary,
                                      child: const PropertiesListShimmer(),
                                    );
                                  },
                                )
                              : controller.activePropertiesList.isEmpty
                                  ? const NoDataFound()
                                  : RefreshIndicator(
                                      onRefresh: onActiveRefresh,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              controller: scrollController,
                                              scrollDirection: Axis.vertical,
                                              physics: const ScrollPhysics(),
                                              itemCount: controller
                                                      .activePropertiesList
                                                      .length +
                                                  1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (index <
                                                    controller
                                                        .activePropertiesList
                                                        .length) {
                                                  return Container(
                                                    color: whitePrimary,
                                                    child: ActiveListCard(
                                                      activeProperty: controller
                                                              .activePropertiesList[
                                                          index],
                                                      controller: controller,
                                                      index: index,
                                                    ),
                                                  );
                                                } else {
                                                  return controller
                                                              .isPagination ==
                                                          true
                                                      ? Container(
                                                          color: whitePrimary,
                                                          child:
                                                              const PropertiesListShimmer(),
                                                        )
                                                      : const SizedBox();
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          //Post an Ad Button
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouterHelper.postAdMainDetailFirstScreen);
            },
            backgroundColor: orangePrimary,
            child: const Icon(Icons.add),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomBar(
            currentIndex: 1,
          ),
        ),
      ),
    );
  }
}
