import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/localization/app_localizations.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:provider/provider.dart';
import '../../provider/language_provider.dart';
import '../../utils/images.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key, required this.currentIndex})
      : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 8,
          selectedFontSize: 8,
          selectedItemColor: bluePrimary,
          unselectedItemColor: blackPrimary,
          backgroundColor: whitePrimary,
          elevation: 5,
          currentIndex: currentIndex,
          onTap: (index) {
            if (currentIndex != index) {
              switch (index) {
                case 0:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterHelper.homeScreen, (route) => false);
                  break;
                case 1:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterHelper.myAdsListScreen, (route) => false);
                  break;
                case 2:
                  break;
                case 3:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterHelper.favoritesListScreen, (route) => false);
                  break;
                case 4:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterHelper.moreOptions, (route) => false);
                  break;
              }
            }
          },
          items:
              // Home Page
              currentIndex == 0
                  ? <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(
                            bottom: setWidgetWidth(5),
                          ),
                          child: const ImageIcon(
                            AssetImage(Images.iconHomeFilled),
                            color: bluePrimary,
                          ),
                        ),
                        label: translate(context, language.languageCode, home)!,
                      ),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(
                              bottom: setWidgetWidth(5),
                            ),
                            child: const ImageIcon(
                              AssetImage(Images.iconAdOutline),
                            ),
                          ),
                          label: translate(
                              context, language.languageCode, myAds)!),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(
                              bottom: setWidgetHeight(5),
                            ),
                            child: const ImageIcon(
                              AssetImage(Images.iconAdd),
                              color: whitePrimary,
                            ),
                          ),
                          label: translate(
                              context, language.languageCode, postAnAd)!),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(
                              bottom: setWidgetHeight(5),
                            ),
                            child: const ImageIcon(
                              AssetImage(Images.iconFavUnfilled),
                            ),
                          ),
                          label: translate(
                              context, language.languageCode, favorites)!),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(
                              bottom: setWidgetHeight(5),
                            ),
                            child: const ImageIcon(
                              AssetImage(Images.iconMoreOutline),
                            ),
                          ),
                          label:
                              translate(context, language.languageCode, more)!),
                    ]
                  :
                  //My Ads Page
                  currentIndex == 1
                      ? <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(
                                bottom: setWidgetHeight(5),
                              ),
                              child: const ImageIcon(
                                AssetImage(Images.iconHomeOutline),
                              ),
                            ),
                            label: translate(
                                context, language.languageCode, home)!,
                          ),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: EdgeInsets.only(
                                  bottom: setWidgetHeight(5),
                                ),
                                child: const ImageIcon(
                                  AssetImage(Images.iconAdFilled),
                                  color: bluePrimary,
                                ),
                              ),
                              label: translate(
                                  context, language.languageCode, myAds)!),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: EdgeInsets.only(
                                  bottom: setWidgetHeight(5),
                                ),
                                child: const ImageIcon(
                                  AssetImage(Images.iconAdd),
                                  color: whitePrimary,
                                ),
                              ),
                              label: translate(
                                  context, language.languageCode, postAnAd)!),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(
                                bottom: setWidgetHeight(5),
                              ),
                              child: const ImageIcon(
                                AssetImage(Images.iconFavUnfilled),
                              ),
                            ),
                            label: translate(
                                context, language.languageCode, favorites)!,
                          ),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: EdgeInsets.only(
                                  bottom: setWidgetHeight(5),
                                ),
                                child: const ImageIcon(
                                  AssetImage(Images.iconMoreOutline),
                                ),
                              ),
                              label: translate(
                                  context, language.languageCode, more)!),
                        ]
                      :
                      //favorites page
                      currentIndex == 3
                          ? <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                icon: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: setWidgetHeight(5),
                                  ),
                                  child: const ImageIcon(
                                    AssetImage(Images.iconHomeOutline),
                                  ),
                                ),
                                label: translate(
                                    context, language.languageCode, home)!,
                              ),
                              BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: setWidgetHeight(5),
                                    ),
                                    child: const ImageIcon(
                                      AssetImage(Images.iconAdOutline),
                                    ),
                                  ),
                                  label: translate(
                                      context, language.languageCode, myAds)!),
                              BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: setWidgetHeight(5),
                                    ),
                                    child: const ImageIcon(
                                      AssetImage(Images.iconAdd),
                                      color: whitePrimary,
                                    ),
                                  ),
                                  label: translate(context,
                                      language.languageCode, postAnAd)!),
                              BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: setWidgetHeight(5),
                                    ),
                                    child: const ImageIcon(
                                      AssetImage(Images.iconFavFilledBlue),
                                      color: bluePrimary,
                                    ),
                                  ),
                                  label: translate(context,
                                      language.languageCode, favorites)!),
                              BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: setWidgetHeight(5),
                                    ),
                                    child: const ImageIcon(
                                      AssetImage(Images.iconMoreOutline),
                                    ),
                                  ),
                                  label: translate(
                                      context, language.languageCode, more)!),
                            ]
                          :
                          //More Options Page
                          currentIndex == 4
                              ? <BottomNavigationBarItem>[
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: setWidgetHeight(5),
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(Images.iconHomeOutline),
                                      ),
                                    ),
                                    label: translate(
                                        context, language.languageCode, home)!,
                                  ),
                                  BottomNavigationBarItem(
                                      icon: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: setWidgetHeight(5),
                                        ),
                                        child: const ImageIcon(
                                          AssetImage(Images.iconAdOutline),
                                        ),
                                      ),
                                      label: translate(context,
                                          language.languageCode, myAds)!),
                                  BottomNavigationBarItem(
                                      icon: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: setWidgetHeight(5),
                                        ),
                                        child: const ImageIcon(
                                          AssetImage(Images.iconAdd),
                                          color: whitePrimary,
                                        ),
                                      ),
                                      label: translate(context,
                                          language.languageCode, postAnAd)!),
                                  BottomNavigationBarItem(
                                      icon: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: setWidgetHeight(5),
                                        ),
                                        child: const ImageIcon(
                                          AssetImage(Images.iconFavUnfilled),
                                        ),
                                      ),
                                      label: translate(context,
                                          language.languageCode, favorites)!),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: setWidgetHeight(5),
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(Images.iconMoreFilled),
                                        color: bluePrimary,
                                      ),
                                    ),
                                    label: translate(
                                      context,
                                      language.languageCode,
                                      more,
                                    )!,
                                  ),
                                ]
                              :
                              // Post an Ad Page
                              <BottomNavigationBarItem>[
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: setWidgetHeight(5),
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(
                                          Images.iconHomeOutline,
                                        ),
                                      ),
                                    ),
                                    label: translate(
                                      context,
                                      language.languageCode,
                                      home,
                                    )!,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: setWidgetHeight(5),
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(
                                          Images.iconAdOutline,
                                        ),
                                      ),
                                    ),
                                    label: translate(
                                      context,
                                      language.languageCode,
                                      myAds,
                                    )!,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: setWidgetHeight(5),
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(Images.iconAdd),
                                        color: whitePrimary,
                                      ),
                                    ),
                                    label: translate(
                                      context,
                                      language.languageCode,
                                      postAnAd,
                                    )!,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: setWidgetHeight(5),
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(
                                          Images.iconFavUnfilled,
                                        ),
                                      ),
                                    ),
                                    label: translate(
                                      context,
                                      language.languageCode,
                                      favorites,
                                    )!,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: setWidgetHeight(5),
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(
                                          Images.iconMoreOutline,
                                        ),
                                      ),
                                    ),
                                    label: translate(
                                      context,
                                      language.languageCode,
                                      more,
                                    )!,
                                  ),
                                ],
        );
      },
    );
  }
}
