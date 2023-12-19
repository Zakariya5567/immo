// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';
import 'package:immo/utils/style.dart';

// ignore: must_be_immutable
class SearchTextField extends StatelessWidget {
  SearchTextField({super.key, 
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.borderColor,
    required this.backgroundColor,
  });

  TextEditingController controller = TextEditingController();
  String hintText;
  IconData icon;
  Color borderColor;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(fontSize: 14),
      obscureText: false,
      keyboardType: TextInputType.text,
      validator: (value) {},

      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        errorStyle: const TextStyle(fontSize: 12),
        fillColor: backgroundColor,
        filled: true,
        hintText: hintText,
        hintStyle: textStyle(
            fontSize: 14, color: greyPrimary, fontFamily: satoshiRegular),
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.00,
          horizontal: MediaQuery.of(context).size.width * 0.022,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
