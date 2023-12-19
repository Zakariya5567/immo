// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:immo/data/api_models/session_expired.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/routes_helper.dart';
import '../utils/app_constant.dart';
import 'api_exception.dart';

class ApiRepo {
  //POST REQUEST
  postData(BuildContext context, String screen, String url,
      Map<String, dynamic> data) async {
    debugPrint("URL ===========>>> $url");
    debugPrint("POST Sending data  ===========>>> $data");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? bearerToken = sharedPreferences.getString(AppConstant.bearerToken);
    String? langCode = sharedPreferences.getString(AppConstant.langCode);
    debugPrint("Bearer token :$bearerToken");
    var formData = FormData.fromMap(data);
    final header = Options(
      sendTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
      headers: bearerToken == null
          ? {
              'accept': 'application/json',
              'locale': langCode,
            }
          : {
              'accept': 'application/json',
              'Authorization': 'Bearer $bearerToken',
              'locale': langCode,
            },
    );

    try {
      final response = await Dio().post(url,
          data: screen == RouterHelper.postAdDimensionScreen ? data : formData,
          options: header);
      return response;
    } on DioError catch (exception) {
      if (exception.response != null) {
        sessionExpired(exception.response!, context);
        debugPrint("NO");
        if (exception.response!.statusCode != 401) {
          if (exception.type == DioErrorType.response) {
            if (exception.response!.statusCode == 422 ||
                exception.response!.statusCode == 400) {
              return exception.response;
            } else {
              Future.delayed(Duration.zero, () {
                apiException(exception, context, screen);
              });
            }
          } else {
            debugPrint("IN ELSE");
            Future.delayed(Duration.zero, () {
              apiException(exception, context, screen);
            });
          }
        }
      }
      return exception;
    }
  }

  //GET REQUEST
  getData(BuildContext context, String screen, String url,
      Map<String, dynamic> data) async {
    debugPrint("URL ===========>>> $url");
    debugPrint("GET Param data  ===========>>> $data");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? bearerToken = sharedPreferences.getString(AppConstant.bearerToken);
    String? langCode = sharedPreferences.getString(AppConstant.langCode);
    debugPrint("Token==============================>>>>>>>>>> $bearerToken ");
    final header = Options(
      sendTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $bearerToken',
        'locale': langCode,
      },
    );
    try {
      final response =
          await Dio().get(url, options: header, queryParameters: data);
      return response;
    } on DioError catch (exception) {
      if (exception.response != null) {
        sessionExpired(exception.response!, context);

        debugPrint("NO");
        if (exception.response!.statusCode != 401) {
          if (exception.type == DioErrorType.response) {
            if (exception.response!.statusCode == 422) {
              return exception.response;
            } else {
              Future.delayed(Duration.zero, () {
                apiException(exception, context, screen);
              });
            }
          } else {
            debugPrint("IN ELSE");
            Future.delayed(Duration.zero, () {
              apiException(exception, context, screen);
            });
          }
        }
      }
      return exception;
    }
  }

  //PUT REQUEST

  putData(BuildContext context, String screen, String url,
      Map<String, dynamic> data) async {
    debugPrint("URL ===========>>> $url");
    debugPrint("sending data  ===========>>> $data");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? bearerToken = sharedPreferences.getString(AppConstant.bearerToken);
    String? langCode = sharedPreferences.getString(AppConstant.langCode);
    debugPrint("Bearer token :$bearerToken");
    final header = Options(
      sendTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
      headers: {
        'accept': 'application/json',
        'locale': langCode,
      },
    );

    try {
      final response =
          await Dio().put(url, queryParameters: data, options: header);
      return response;
    } on DioError catch (exception) {
      if (exception.response != null) {
        sessionExpired(exception.response!, context);

        debugPrint("NO");
        if (exception.response!.statusCode != 401) {
          if (exception.type == DioErrorType.response) {
            if (exception.response!.statusCode == 422) {
              return exception.response;
            } else {
              Future.delayed(Duration.zero, () {
                apiException(exception, context, screen);
              });
            }
          } else {
            debugPrint("IN ELSE");
            Future.delayed(Duration.zero, () {
              apiException(exception, context, screen);
            });
          }
        }
      }

      return exception;
    }
  }

  //DELETE REQUEST

  deleteData(BuildContext context, String screen, String url,
      Map<String, dynamic> data) async {
    debugPrint("URL ===========>>> $url");
    debugPrint("sending data  ===========>>> $data");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? bearerToken = sharedPreferences.getString(AppConstant.bearerToken);
    String? langCode = sharedPreferences.getString(AppConstant.langCode);
    debugPrint("Bearer token :$bearerToken");
    final header = Options(
      sendTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $bearerToken',
        'locale': langCode,
      },
    );

    try {
      final response = await Dio().delete(
        url,
        queryParameters: data,
        options: header,
      );
      return response;
    } on DioError catch (exception) {
      if (exception.response != null) {
        sessionExpired(exception.response!, context);

        debugPrint("NO");
        if (exception.response!.statusCode != 401) {
          if (exception.type == DioErrorType.response) {
            if (exception.response!.statusCode == 422) {
              return exception.response;
            } else {
              Future.delayed(Duration.zero, () {
                apiException(exception, context, screen);
              });
            }
          } else {
            debugPrint("IN ELSE");
            Future.delayed(Duration.zero, () {
              apiException(exception, context, screen);
            });
          }
        }
      }
      return exception;
    }
  }

  //POST MULTIPART REQUEST

  postMultipartData(BuildContext context, String screen, String url,
      Map<String, dynamic> data) async {
    debugPrint("URL ===========>>> $url");
    debugPrint("sending data  ===========>>> $data");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? bearerToken = sharedPreferences.getString(AppConstant.bearerToken);
    String? langCode = sharedPreferences.getString(AppConstant.langCode);
    debugPrint("Bearer token :$bearerToken");

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = "multipart/form-data";
    dio.options.headers["Authorization"] = "Bearer $bearerToken";
    dio.options.headers["accept"] = "application/json";
    dio.options.headers["locale"] = langCode;
    dio.options.receiveTimeout = 300000;

    FormData formData = FormData.fromMap(data);
    int? percentage;
    try {
      final response = await dio.post(
        url,
        data: formData,
        onSendProgress: (rec, total) {
          percentage = ((rec / total) * 100).floor();
          debugPrint("Percentage : $percentage");
        },
      );
      return response;
    } on DioError catch (exception) {
      if (exception.response != null) {
        sessionExpired(exception.response!, context);
      }
      Future.delayed(Duration.zero, () {
        apiException(exception, context, screen);
      });

      return exception;
    }
  }

  //Download
  downloadData(
      BuildContext context, String screen, String url, String savePath) async {
    debugPrint("URL ===========>>> $url");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? bearerToken = sharedPreferences.getString(AppConstant.bearerToken);
    String? langCode = sharedPreferences.getString(AppConstant.langCode);
    final header = Options(
      sendTimeout: 300000,
      receiveTimeout: 300000,
      receiveDataWhenStatusError: true,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'locale': langCode,
        HttpHeaders.acceptEncodingHeader: "*"
      },
    );

    int? percentage;
    try {
      final response = await Dio().download(
        url,
        savePath,
        options: header,
        onReceiveProgress: (rec, total) {
          percentage = ((rec / total) * 100).floor();
          debugPrint("Percentage : $percentage");
        },
      );
      debugPrint("Download Completed.");
      return response;
    } on DioError catch (exception) {
      if (exception.response != null) {
        sessionExpired(exception.response!, context);
        if (exception.response!.statusCode != 401) {
          if (exception.type == DioErrorType.response) {
            if (exception.response!.statusCode == 400) {
              return exception.response;
            } else {
              Future.delayed(Duration.zero, () {
                apiException(exception, context, screen);
              });
            }
          } else {
            Future.delayed(Duration.zero, () {
              apiException(exception, context, screen);
            });
          }
        }
      }
      return exception;
    }
  }
}
