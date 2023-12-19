import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:immo/helper/routes_helper.dart';
import 'package:immo/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/widgets/custom_snackbar.dart';

void sessionExpired(Response<dynamic> response, BuildContext context) async {
  if (response.statusCode == 401) {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppConstant.isLogin, false);
    Future.delayed(Duration.zero, () {
      Navigator.pushNamedAndRemoveUntil(
          context, RouterHelper.emailSignInScreen, (route) => false);
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, response.data['message'], 1));
    });
  }
}
