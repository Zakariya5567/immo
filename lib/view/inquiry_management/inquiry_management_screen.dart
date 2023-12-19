import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/provider/contact_form_provider.dart';
import 'package:immo/utils/string.dart';
import 'package:immo/utils/theme.dart';
import 'package:immo/view/inquiry_management/components/inquiry_item.dart';
import 'package:immo/view/widgets/no_data_found.dart';
import 'package:provider/provider.dart';

import '../../helper/routes_helper.dart';
import '../../localization/app_localizations.dart';
import '../../provider/language_provider.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/style.dart';
import '../widgets/Shimmer/shimmer_inquiry.dart';
import '../widgets/delete_confirmation_view.dart';

class InquiryManagementScreen extends StatefulWidget {
  const InquiryManagementScreen({Key? key}) : super(key: key);

  @override
  State<InquiryManagementScreen> createState() =>
      _InquiryManagementScreenState();
}

class _InquiryManagementScreenState extends State<InquiryManagementScreen> {
  @override
  void initState() {
    super.initState();
    callingApi();
  }

  callingApi() {
    Future.delayed(Duration.zero, () {
      final contactFormProvider =
          Provider.of<ContactFormProvider>(context, listen: false);
      contactFormProvider.getInquiryList(
          context, RouterHelper.inquiryManagement);
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
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const ImageIcon(
                AssetImage(Images.arrowBackIcon),
                size: 23,
              ),
            ),
            title: Consumer<LanguageProvider>(
              builder: (context, language, child) {
                return Text(
                  translate(context, language.languageCode, inquiryManagement)!,
                  style: textStyle(
                      fontSize: 18,
                      color: whitePrimary,
                      fontFamily: satoshiMedium),
                );
              },
            ),
          ),
          body: Consumer<ContactFormProvider>(
              builder: (context, controller, child) {
            return controller.isLoading == true
                ? ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, position) {
                      return const InquiryShimmer();
                    })
                : controller.list.isEmpty
                    ? const NoDataFound()
                    : ListView.builder(
                        itemCount: controller.list.length,
                        itemBuilder: (context, position) {
                          return InquiryItem(controller.list[position], (id) {
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
                                    Images.iconDeleteWarning, () {
                                  controller.deleteInquiry(
                                      context,
                                      RouterHelper.inquiryManagement,
                                      id,
                                      position);
                                });
                              },
                            );
                          });
                        },
                      );
          }),
        ),
      ),
    );
  }
}
