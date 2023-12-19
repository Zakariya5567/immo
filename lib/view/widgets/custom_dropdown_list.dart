import 'package:flutter/material.dart';
import 'package:immo/utils/size.dart';

import '../../utils/colors.dart';
import '../../utils/style.dart';
import '../post_an_ad/components/ads_border_view.dart';

// ignore: must_be_immutable
class CustomDropdown<T> extends StatelessWidget {
  CustomDropdown({
    super.key,
    required this.title,
    this.provider,
    required this.items,
  });
  // ignore: prefer_typing_uninitialized_variables
  var provider;
  final String title;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return BorderView(
      leftMargin: 0,
      rightMargin: 0,
      height: 50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: setWidgetWidth(15)),
        // Type of Property DropDown Button
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            menuMaxHeight: setWidgetHeight(300),
            borderRadius: BorderRadius.circular(20),
            isExpanded: true,
            value: items[provider.selectedIndex],
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 25,
            ),
            items: items.map<DropdownMenuItem<String>>((itemValue) {
              return DropdownMenuItem<String>(
                value: itemValue,
                child: Text(
                  itemValue,
                  style: textStyle(
                      fontSize: 14,
                      color: blackPrimary,
                      fontFamily: satoshiRegular),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              provider.setDropDownValue(
                  title: title,
                  value: newValue.toString(),
                  index: items.indexOf(newValue!));
            },
          ),
        ),
      ),
    );
  }
}
