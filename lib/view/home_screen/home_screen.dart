// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
// import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/home_screen/components/services_item.dart';
import 'package:provider/provider.dart';

import '../../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/filter_screen_provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/images.dart';
import '../widgets/Shimmer/property_type_shimmer.dart';
import '../widgets/bottom_nevigation_bar.dart';
import '../widgets/property_type.dart';
import 'components/home_search_widget.dart';
import 'components/property_list_view_pager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    callingAPIs();
    super.initState();
  }

  callingAPIs() async {
    Future.delayed(Duration.zero, () {
      final filterScreenProvider =
          Provider.of<FilterScreenProvider>(context, listen: false);
      final homePageProvider =
          Provider.of<HomePageProvider>(context, listen: false);
      homePageProvider.setLoading(true);
      homePageProvider.setPropertyLoading(true);
      // Future.delayed(Duration.zero, () {
      homePageProvider.setUserId();
      // });
      fetchMultipleApis(homePageProvider, filterScreenProvider);
      // _makeApiRequest(homePageProvider,filterScreenProvider);
      // Future.delayed(Duration.zero, () async {
      //   await filterScreenProvider.getCategoryList(
      //       context, RouterHelper.homeScreen);
      // });
      // Future.delayed(Duration.zero, () async {
      //   await homePageProvider.getCategoryList(
      //       context, RouterHelper.homeScreen);
      // });
    });
  }

  Future<void> fetchMultipleApis(HomePageProvider homePageProvider,
      FilterScreenProvider filterScreenProvider) async {
    // Create a list of futures for each API call
    List<Future> apiFutures = [
      getHomeCategoryList(homePageProvider),
      getFilterCategoryList(filterScreenProvider),
      getHomePropertyList(homePageProvider),
    ];
    // Wait for all the API calls to complete
    await Future.wait(apiFutures);
  }

  Future<void> getHomeCategoryList(HomePageProvider homePageProvider) async {
    // API call 1 implementation
    homePageProvider.getCategoryList(context, RouterHelper.homeScreen);
  }

  Future<void> getFilterCategoryList(
      FilterScreenProvider filterScreenProvider) async {
    // API call 2 implementation
    filterScreenProvider.getCategoryList(context, RouterHelper.homeScreen);
  }

  Future<void> getHomePropertyList(HomePageProvider homePageProvider) async {
    homePageProvider.setLoading(true);
    homePageProvider.resetPages();
    homePageProvider.clearData();
    homePageProvider.clearLocation();
    homePageProvider.getPropertyList(
        context, 0, homePageProvider.currentPage, RouterHelper.homeScreen);
  }

  // void _makeApiRequest(HomePageProvider homePageProvider,
  //     FilterScreenProvider filterScreenProvider) async {
  //   final receivePort = ReceivePort();
  //   final isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort);

  //   final sendPort = await receivePort.first as SendPort;
  //   final responseReceivePort = ReceivePort();

  //   sendPort.send({
  //     'homeProvider': homePageProvider,
  //     'filterProvider': filterScreenProvider,
  //     'responsePort': responseReceivePort.sendPort,
  //     'context': context,
  //   });

  //   final response = await responseReceivePort.first;

  //   responseReceivePort.close();
  //   isolate.kill();
  // }

  // static void _isolateEntry(SendPort sendPort) {
  //   final receivePort = ReceivePort();
  //   receivePort.listen((message) async {
  //     final homeProvider = message['homeProvider'] as HomePageProvider;
  //     final filterProvider = message['filterProvider'] as FilterScreenProvider;
  //     final responsePort = message['responsePort'] as SendPort;
  //     final context = message['context'] as BuildContext;
  //     try {
  //       await homeProvider.getCategoryList(context, RouterHelper.homeScreen);
  //       await filterProvider.getCategoryList(context, RouterHelper.homeScreen);
  //     } catch (error) {
  //       responsePort.send('Error:========> $error');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    setMediaQuery(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: blueStatusBar(),
      child: SafeArea(
        top: Platform.isAndroid ? true : false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return FittedBox(
                  child: Text(
                    translate(context, language.languageCode, appBarTitle)!,
                    style: textStyle(
                        fontSize: 20,
                        color: whitePrimary,
                        fontFamily: satoshiMedium),
                  ),
                );
              },
            ),
            actions: [
              Consumer<HomePageProvider>(
                  builder: (context, homeController, child) {
                return IconButton(
                  icon: Image.asset(
                    homeController.isNotify == true
                        ? Images.iconBellWithDot
                        : Images.iconBell,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RouterHelper.notificationScreen,
                    );
                  },
                );
              }),
              marginWidth(24),
            ],
          ),
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
            currentIndex: 0,
          ),
          body: SingleChildScrollView(
            child: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Consumer<HomePageProvider>(
                  builder: (context, homePageProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeSearchWidget(
                          controller: homePageProvider,
                          scaffoldKey: scaffoldKey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: setWidgetHeight(36),
                            child: homePageProvider.isLoading == true ||
                                    homePageProvider
                                            .propertyCategoryModel.data ==
                                        null
                                ? const PropertyTypeShimmer()
                                : PropertyTypeWidget(
                                    list: homePageProvider
                                        .propertyCategoryModel.data!,
                                    isHome: 1,
                                  ),
                          ),
                        ),
                        PageViewList(
                          controller: homePageProvider,
                        ),
                        SizedBox(
                          height: setWidgetHeight(12),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: setWidgetWidth(20),
                              vertical: setWidgetHeight(12),
                            ),
                            child: Text(
                              translate(context, language.languageCode,
                                  servicesByImmo)!,
                              style: textStyle(
                                  fontSize: 16,
                                  color: blackLight,
                                  fontFamily: satoshiBold),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: setWidgetWidth(14),
                          ),
                          child: SizedBox(
                            height: setWidgetHeight(180),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: setWidgetHeight(10),
                                      horizontal: setWidgetWidth(5),
                                    ),
                                    child: ServicesItem(
                                      position: position,
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
