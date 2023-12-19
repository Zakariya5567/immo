import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/provider/user_profile_provider.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/size.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/images.dart';
import '../../../utils/string.dart';
import '../../../utils/style.dart';
import '../../widgets/Shimmer/shimmer_user_list-tile.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    super.initState();
    callingProfileAPI();
  }

  callingProfileAPI() {
    final profileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((value) async {
      await profileProvider.getProfile(context, moreOptions, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Consumer<UserProfileProvider>(
          builder: (context, controller, child) {
            return controller.isLoading == true ||
                    controller.currentUserModel.data == null
                ? const ShimmerListTile()
                : ListTile(
                    leading: controller.currentUserModel.data!.avatar == null
                        ? Container(
                            width: setWidgetHeight(60),
                            height: setWidgetHeight(60),
                            decoration: const BoxDecoration(
                              color: blueShadow,
                              image: DecorationImage(
                                image: AssetImage(
                                  Images.userPlaceholder,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          )
                        : Container(
                            width: setWidgetHeight(60),
                            height: setWidgetHeight(60),
                            decoration: BoxDecoration(
                              color: blueShadow,
                              image: DecorationImage(
                                image: NetworkImage(
                                  controller.currentUserModel.data!.avatar!,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                    title: Text(
                      controller.currentUserModel.data!.isCompany == 0
                          ? controller.currentUserModel.data!.username == null
                              ? translate(context, language.languageCode,
                                  userNameValue)!
                              : controller.currentUserModel.data!.username!
                          : controller.currentUserModel.data!.companyName ==
                                  null
                              ? translate(
                                  context, language.languageCode, companyName)!
                              : controller.currentUserModel.data!.companyName!,
                      style: textStyle(
                          fontSize: 18,
                          color: blackLight,
                          fontFamily: satoshiMedium),
                    ),
                    subtitle: Text(
                      controller.currentUserModel.data!.isCompany == null
                          ? individualAccount
                          : controller.currentUserModel.data!.isCompany! == 0
                              ? translate(context, language.languageCode,
                                  individualAccount)!
                              : translate(context, language.languageCode,
                                  companyAccount)!,
                      style: textStyle(
                          fontSize: 16,
                          color: blackLight,
                          fontFamily: satoshiRegular),
                    ),
                    trailing: Image.asset(
                      Images.iconEdit,
                      width: setWidgetWidth(24),
                      height: setWidgetHeight(24),
                    ).onPress(() async {
                      Navigator.pushNamed(
                        context,
                        RouterHelper.setProfile,
                      ).then((value) {
                        controller.getProfile(
                            context, RouterHelper.moreOptions, 0);
                      });
                    }),
                  );
          },
        );
      },
    );
  }
}
