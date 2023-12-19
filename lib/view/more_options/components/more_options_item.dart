import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/size.dart';
import '../../../utils/style.dart';

class MoreOptionsItem extends StatelessWidget {
  final String title;
  final String? leadingIcon;
  final VoidCallback callback;

  const MoreOptionsItem(this.title, this.callback, {super.key, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: setWidgetWidth(5)),
        child: leadingIcon != null
            ? ListTile(
                horizontalTitleGap: 0,
                onTap: callback,
                leading: Image.asset(leadingIcon!,
                    width: setWidgetWidth(24), height: setWidgetHeight(24)),
                title: Text(
                  title,
                  style: textStyle(
                      fontSize: 16,
                      color: blackLight,
                      fontFamily: satoshiMedium),
                ),
                trailing: Image.asset(
                  Images.iconNextBlack,
                  width: setWidgetWidth(15),
                  height: setWidgetHeight(15),
                ))
            : ListTile(
                onTap: callback,
                title: Text(
                  title,
                  style: textStyle(
                      fontSize: 16,
                      color: blackLight,
                      fontFamily: satoshiMedium),
                ),
                trailing: Image.asset(
                  Images.iconNextBlack,
                  width: setWidgetWidth(15),
                  height: setWidgetHeight(15),
                )));
  }
}
