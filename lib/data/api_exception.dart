// ignore: implementation_imports
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:immo/utils/string.dart';

import '../helper/routes_helper.dart';
import 'connection_model.dart';

apiException(DioError exception, BuildContext context, String screen) {
  if (exception.type == DioErrorType.other) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(
        context,
        RouterHelper.noConnectionScreen,
        arguments: ConnectionModel(
          screen,
          connectionError,
        ),
      );
    });
    debugPrint("Internet connection error");
  } else if (exception.type == DioErrorType.cancel) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(
        context,
        RouterHelper.noConnectionScreen,
        arguments: ConnectionModel(
          screen,
          serverError,
        ),
      );
    });
    debugPrint("Request to API server was cancelled");
  } else if (exception.type == DioErrorType.receiveTimeout) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(
        context,
        RouterHelper.noConnectionScreen,
        arguments: ConnectionModel(
          screen,
          receiveTimeOutError,
        ),
      );
    });
    debugPrint("Receive timeout with API server");
  } else if (exception.type == DioErrorType.sendTimeout) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(
        context,
        RouterHelper.noConnectionScreen,
        arguments: ConnectionModel(
          screen,
          sendTimeOutError,
        ),
      );
    });
    debugPrint("Send timeout with API server");
  } else if (exception.type == DioErrorType.connectTimeout) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(
        context,
        RouterHelper.noConnectionScreen,
        arguments: ConnectionModel(
          screen,
          connectionTimeOutError,
        ),
      );
    });
    debugPrint("Connection timeout with API server");
  } else if (exception.type == DioErrorType.response) {
    switch (exception.response!.statusCode) {
      case 400:
        Future.delayed(Duration.zero, () {
          Navigator.pushNamed(
            context,
            RouterHelper.noConnectionScreen,
            arguments: ConnectionModel(
              screen,
              somethingWentWrong,
            ),
          );
        });
        break;
      case 404:
        Future.delayed(Duration.zero, () {
          Navigator.pushNamed(
            context,
            RouterHelper.noConnectionScreen,
            arguments: ConnectionModel(
              screen,
              error404,
            ),
          );
        });
        break;
      case 500:
        Future.delayed(Duration.zero, () {
          Navigator.pushNamed(
            context,
            RouterHelper.noConnectionScreen,
            arguments: ConnectionModel(
              screen,
              error500,
            ),
          );
        });
        break;
      case 422:
        Future.delayed(Duration.zero, () {
          Navigator.pushNamed(
            context,
            RouterHelper.noConnectionScreen,
            arguments: ConnectionModel(
              screen,
              error422,
            ),
          );
        });
        break;
      default:
        Future.delayed(Duration.zero, () {
          Navigator.pushNamed(
            context,
            RouterHelper.noConnectionScreen,
            arguments: ConnectionModel(
              screen,
              somethingWentWrong,
            ),
          );
        });
    }
  }
}
