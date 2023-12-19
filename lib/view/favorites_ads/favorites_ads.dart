import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/favorites_ads/components/favorites_ad_card.dart';
import 'package:immo/view/widgets/bottom_nevigation_bar.dart';
import 'package:provider/provider.dart';

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../widgets/Shimmer/shimmer_favourite.dart';
import '../widgets/no_data_found.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    callingListener();
    callingApi(0);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  callingListener() {
    Future.delayed(Duration.zero, () {
      final homePageProvider =
          Provider.of<HomePageProvider>(context, listen: false);
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
                scrollController.offset &&
            homePageProvider.isLoading == false) {
          callingApi(1);
        }
      });
    });
  }

  callingApi(int isPagination) {
    Future.delayed(Duration.zero, () {
      final homePageProvider =
          Provider.of<HomePageProvider>(context, listen: false);
      if (isPagination == 0) {
        homePageProvider.setLoading(true);
        homePageProvider.resetPages();
        homePageProvider.getFavouriteList(context, isPagination,
            homePageProvider.currentPage, RouterHelper.favoritesListScreen);
      } else {
        homePageProvider.setPageIncrement();
        homePageProvider.getFavouriteList(context, isPagination,
            homePageProvider.currentPage, RouterHelper.favoritesListScreen);
      }
    });
  }

  Future<void> onRefresh() async {
    // Your refresh logic goes here
    callingApi(0);
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
                  translate(context, language.languageCode, favorites)!,
                  style: textStyle(
                    fontSize: 20,
                    color: whitePrimary,
                    fontFamily: satoshiMedium,
                  ),
                );
              },
            ),
          ),
          body:
              Consumer<HomePageProvider>(builder: (context, controller, child) {
            if (controller.isLoading == true) {
              return const ShimmerFavourite();
            }
            if (controller.favouriteModel.data == null ||
                controller.favouriteModel.data!.isEmpty) {
              return const NoDataFound();
            } else {
              final listData = controller.favouriteModel.data!;
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: listData.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < listData.length) {
                            return FavoritesListCard(
                              controller: controller,
                              index: index,
                            );
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
            }
          }),
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
            currentIndex: 3,
          ),
        ),
      ),
    );
  }
}
