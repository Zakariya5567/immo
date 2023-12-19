import 'package:flutter/material.dart';
import 'package:immo/provider/home_page_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/view/home_screen/components/property_card.dart';
import 'package:provider/provider.dart';

import '../../../helper/routes_helper.dart';
import '../../../utils/size.dart';
import '../../widgets/Shimmer/shimmar_home_page_list.dart';
import '../../widgets/no_data_found.dart';

// ignore: must_be_immutable
class PageViewList extends StatefulWidget {
  PageViewList({super.key, required this.controller});
  HomePageProvider controller = HomePageProvider();

  @override
  State<PageViewList> createState() => _PageViewListState();
}

class _PageViewListState extends State<PageViewList> {
  final PageController ctrl = PageController(
    viewportFraction: 0.55,
  );

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    callingListener();

    // callingApi(0);
  }

  @override
  void dispose() {
    super.dispose();
    ctrl.dispose();
  }

  callingListener() {
    Future.delayed(Duration.zero, () {
      final homePageProvider =
          Provider.of<HomePageProvider>(context, listen: false);
      ctrl.addListener(() {
        int pos = ctrl.page!.round();
        if (currentPage != pos) {
          {
            setState(() {
              currentPage = pos;
            });
          }
        }
        if (ctrl.position.maxScrollExtent == ctrl.offset &&
            homePageProvider.isLoading == false) {
          callingApi(1);
        }
      });
    });
  }

  callingApi(int isPagination) {
    Future.delayed(Duration.zero, () async {
      final homePageProvider =
          Provider.of<HomePageProvider>(context, listen: false);
      if (isPagination == 0) {
        homePageProvider.setLoading(true);
        homePageProvider.resetPages();
        widget.controller.clearData();
        widget.controller.clearLocation();
        await widget.controller.getPropertyList(context, isPagination,
            homePageProvider.currentPage, RouterHelper.homeScreen);
      } else {
        homePageProvider.setPageIncrement();
        await widget.controller.getPropertyList(context, isPagination,
            homePageProvider.currentPage, RouterHelper.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: setWidgetHeight(290),
      child: widget.controller.isPropertyLoading == true ||
              widget.controller.isPropertyLoading == null
          ? const ShimmarPageViewList()
          : widget.controller.propertiesListModel.data == null ||
                  widget.controller.propertiesListModel.data!.isEmpty
              ? const NoDataFound()
              : Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          controller: ctrl,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.controller.currentPage >
                                      widget.controller.lastPage &&
                                  widget.controller.isPagination == false
                              ? widget
                                  .controller.propertiesListModel.data!.length
                              : widget.controller.propertiesListModel.data!
                                      .length +
                                  1,
                          physics: const BouncingScrollPhysics(),
                          // ignore: body_might_complete_normally_nullable
                          itemBuilder: (context, int index) {
                            // Active page
                            if (widget.controller.isHomepageListReset == true) {
                              currentPage = 0;
                              widget.controller.resetHomePageList();
                            }
                            bool active = index == currentPage;
                            if (index <
                                widget.controller.propertiesListModel.data!
                                    .length) {
                              return _buildStoryPage(active, context, index);
                            } else if (widget.controller.isPagination == true &&
                                widget.controller.lastPage >=
                                    widget.controller.currentPage) {
                              return _buildShimmerStoryPage(
                                  active, context, index);
                            }
                          }),
                    ),
                  ],
                ),
    );
  }

  _buildStoryPage(bool active, BuildContext context, index) {
    // Animated Properties
    final double blur = active ? 10 : 5;
    final double offset = active ? 5 : 2;
    final double top = active ? 0 : setWidgetHeight(50);

    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(
          top: top,
          bottom: setWidgetHeight(5),
          right: setWidgetWidth(10),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: greyShadow,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: PropertyCard(
          active,
          controller: widget.controller,
          index: index,
        ));
  }

  _buildShimmerStoryPage(bool active, BuildContext context, index) {
    // Animated Properties
    final double blur = active ? 10 : 5;
    final double offset = active ? 5 : 2;
    final double top = active ? 0 : setWidgetHeight(50);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(
        top: top,
        bottom: setWidgetHeight(5),
        right: setWidgetWidth(10),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: greyShadow,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
      child: ShimmerPropertyCard(active),
    );
  }
}
