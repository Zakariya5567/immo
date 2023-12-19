import 'package:flutter/material.dart';
import 'package:immo/data/api_models/inquiry_management/iquiry_list.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/extension/widget_extension.dart';
import 'package:immo/utils/images.dart';
import 'package:immo/utils/size.dart';
import 'package:immo/utils/style.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../provider/language_provider.dart';
import '../../../utils/string.dart';

// ignore: must_be_immutable
class InquiryItem extends StatelessWidget {
  Data data;
  ValueSetter<int> callbackAction;
  InquiryItem(this.data,this.callbackAction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(
              left: setWidgetWidth(25), right: setWidgetWidth(25), top: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: whitePrimary,
            border: Border.all(width: 1, color: greyShadow),
            boxShadow: const [
              BoxShadow(color: greyShadow, blurRadius: 5, offset: Offset(1, 1))
            ],
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title!,
                        style: textStyle(
                            fontSize: 16,
                            color: blackLight,
                            fontFamily: satoshiMedium),
                      ),
                      marginHeight(5),
                      Text(
                        translate(
                            context, language.languageCode, searchCriteria)!,
                        style: textStyle(
                            fontSize: 10,
                            color: greyLight,
                            fontFamily: satoshiRegular),
                      ),
                      marginHeight(12),
                      Text(
                        "${translate(context, language.languageCode, labelName)!}:",
                        style: textStyle(
                            fontSize: 10,
                            color: blackPrimary,
                            fontFamily: satoshiBold),
                      ),
                      marginHeight(5),
                      Text(
                        data.fullName!,
                        style: textStyle(
                            fontSize: 14,
                            color: blackLight,
                            fontFamily: satoshiRegular),
                      ),
                      marginHeight(12),
                      Text(
                        "${translate(context, language.languageCode, labelEmail)!}:",
                        style: textStyle(
                            fontSize: 10,
                            color: blackPrimary,
                            fontFamily: satoshiBold),
                      ),
                      marginHeight(5),
                      Text(
                        data.email!,
                        style: textStyle(
                            fontSize: 14,
                            color: blackLight,
                            fontFamily: satoshiRegular),
                      ),
                      marginHeight(12),
                      Text(
                        "${translate(context, language.languageCode, phoneNumber)!}:",
                        style: textStyle(
                            fontSize: 10,
                            color: blackPrimary,
                            fontFamily: satoshiBold),
                      ),
                      marginHeight(5),
                      Text(
                        data.phoneNumber!,
                        style: textStyle(
                            fontSize: 14,
                            color: blackLight,
                            fontFamily: satoshiRegular),
                      ),
                      marginHeight(12),
                      Text(
                        "${translate(context, language.languageCode, labelMessage)!}:",
                        style: textStyle(
                            fontSize: 10,
                            color: blackPrimary,
                            fontFamily: satoshiBold),
                      ),
                      marginHeight(5),
                      Text(
                        data.message!,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle(
                            fontSize: 12,
                            color: blackLight,
                            fontFamily: satoshiRegular),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image(
                    image: const AssetImage(Images.iconDeleteWithBg),
                    width: setWidgetWidth(36),
                    height: setWidgetHeight(36),
                  ).onPress(() {
                   callbackAction(data.id!);
                  }),
                )
              ]),
        );
      },
    );
  }
}
