import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/style.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/widgets/no_data_found.dart';
import 'package:provider/provider.dart';

import '../../data/api_models/detail_arguments.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../provider/notification_provider.dart';
import '../widgets/Shimmer/shimmer_notification.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
      final notificationProvider =
          Provider.of<HomePageProvider>(context, listen: false);
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
                scrollController.offset &&
            notificationProvider.isLoading == false) {
          callingApi(1);
        }
      });
    });
  }

  callingApi(int isPagination) {
    Future.delayed(Duration.zero, () {
      final profileProvider =
          Provider.of<HomePageProvider>(context, listen: false);
      profileProvider.setNotificationStatus(false);

      final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);
      if (isPagination == 0) {
        notificationProvider.setLoading(true);
        notificationProvider.resetPages();
        notificationProvider.getAllNotificationList(
            context, isPagination, notificationProvider.currentPage, RouterHelper.notificationScreen);
      } else {
        notificationProvider.setPageIncrement();
        notificationProvider.getAllNotificationList(context, isPagination,
            notificationProvider.currentPage, RouterHelper.notificationScreen);
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
          backgroundColor: whitePrimary,
          appBar: AppBar(
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
            title: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Text(
                  translate(context, language.languageCode, notification)!,
                  style: textStyle(
                    fontSize: 18,
                    color: whitePrimary,
                    fontFamily: satoshiMedium,
                  ),
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final notificationProvider =
                      Provider.of<NotificationProvider>(context, listen: false);
                  await notificationProvider
                      .clearAllNotificationList(
                          context, RouterHelper.notificationScreen)
                      .then((value) {
                    Future.delayed(Duration.zero, () {
                      notificationProvider.getAllNotificationList(
                          context, 0, 1, RouterHelper.notificationScreen);
                    });
                  });
                },
                child: Consumer<LanguageProvider>(
                  builder: (context, language, child) {
                    return Text(
                      translate(context, language.languageCode, clearAll)!,
                      style: textStyle(
                        fontSize: 12,
                        color: whitePrimary,
                        fontFamily: satoshiMedium,
                      ),
                    );
                  },
                ),
              ),
              marginWidth(24),
            ],
          ),
          body: Consumer<NotificationProvider>(
            builder: (context, controller, child) {
              if (controller.isLoading == true) {
                return const ShimmerNotification();
              }
              if (controller.notificationModel.data == null ||
                  controller.notificationModel.data!.isEmpty) {
                return const NoDataFound();
              } else {
                final listData = controller.notificationModel.data!;
                return RefreshIndicator(
                  onRefresh: onRefresh,
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: listData.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < listData.length) {
                        final data = controller.notificationModel.data![index];
                        return InkWell(
                          onTap: () async {
                            Navigator.pushNamed(
                                context, RouterHelper.adDetailsScreen,
                                arguments: DetailScreenArguments(
                                  data.data!.propertyId!,
                                ));

                            if (data.readAt == null) {
                              controller
                                  .markSingleReadNotification(context,
                                      RouterHelper.notificationScreen, data.id!)
                                  .then((value) {
                                controller.marKAsRead(data.id!);
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: index == 0 ? setWidgetHeight(15) : 1,
                                bottom: 1),
                            child: Container(
                              height: setWidgetHeight(82),
                              color: data.readAt == null
                                  ? blueLight
                                  : whitePrimary,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: setWidgetWidth(50),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    data.readAt == null
                                        ? Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image(
                                                image: const AssetImage(
                                                  Images.iconblueCircle,
                                                ),
                                                width: setWidgetWidth(54),
                                                height: setWidgetHeight(54),
                                              ),
                                              Image(
                                                image: const AssetImage(
                                                  Images.iconBlueBell,
                                                ),
                                                width: setWidgetWidth(23),
                                                height: setWidgetHeight(23),
                                              ),
                                            ],
                                          )
                                        : Image(
                                            image: const AssetImage(
                                              Images.iconNotificationGrey,
                                            ),
                                            width: setWidgetWidth(54),
                                            height: setWidgetHeight(54),
                                          ),
                                    marginWidth(10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.date!,
                                            style: textStyle(
                                              fontSize: 8,
                                              color: greyPrimary,
                                              fontFamily: satoshiRegular,
                                            ),
                                          ),
                                          marginHeight(1),
                                          Consumer<LanguageProvider>(
                                            builder:
                                                (context, language, child) {
                                              return Text(
                                                data.data!.title!,
                                                style: textStyle(
                                                  fontSize: 14,
                                                  color: blackPrimary,
                                                  fontFamily: satoshiMedium,
                                                ),
                                              );
                                            },
                                          ),
                                          marginHeight(2),
                                          Text(
                                            data.data!.message!,
                                            style: textStyle(
                                              fontSize: 8,
                                              color:
                                                  greyPrimary.withOpacity(0.4),
                                              fontFamily: satoshiMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return controller.isPagination == true
                            ? const ShimmerNotificationCard()
                            : const SizedBox();
                      }
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
