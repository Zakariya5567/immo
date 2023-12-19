import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:immo/data/api_models/notification/all_notification_model.dart';
import 'package:immo/utils/size.dart';
import '../data/api_models/notification/delete_all_notification_model.dart';
import '../data/api_models/notification/mark_single_read_notification_model.dart';
import '../data/api_repo.dart';
import '../utils/api_url.dart';
import '../view/widgets/circular_progress.dart';

class NotificationProvider extends ChangeNotifier {
  bool isSecure = true;
  bool? isLoading;
  bool? isDialogLoading;

  // Authentication Models
  NotificationModel notificationModel = NotificationModel();
  DeleteAllNotificationModel deleteAllNotificationModel =
      DeleteAllNotificationModel();
  MarkSingleReadNotificationModel markSingleReadNotificationModel =
      MarkSingleReadNotificationModel();

  ApiRepo apiRepo = ApiRepo();

  bool? isPagination;
  int currentPage = 1;
  int lastPage = 0;

  // set Is Pagination
  setPagination(bool value) {
    isPagination = value;
    notifyListeners();
  }

  // loading
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setPageIncrement() {
    currentPage = currentPage + 1;
    notifyListeners();
  }

  resetPages() {
    currentPage = 1;
    lastPage = 0;
    notifyListeners();
  }

  marKAsRead(String id) {
    notificationModel.data!.asMap().forEach((index, value) {
      if (value.id == id) {
        value.readAt = "${DateTime.now()}";
      }
      notifyListeners();
    });
  }

  //DialogLoading
  setDialogLoading(BuildContext context, bool value) {
    isDialogLoading = value;
    if (value == true) {
      loaderDialog(context);
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

//===============================================================================
  // APIs calling section

  //GET ALL NOTIFICATION LIST
  getAllNotificationList(
      BuildContext context, int pagination, int page, String screen) async {
    if (pagination == 1) {
      setPagination(true);
    } else {
      setLoading(true);
    }
    debugPrint("isLoading: $isLoading");
    try {
      Response response =
          await apiRepo.getData(context, screen, ApiUrl.getAllNotificationUrl, {
        'page': page,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      if (page != 1) {
        for (var element in NotificationModel.fromJson(responseBody).data!) {
          if (!notificationModel.data!.contains(element)) {
            notificationModel.data!.add(element);
          }
        }
      } else {
        notificationModel = NotificationModel.fromJson(responseBody);
      }
      pagination == 1 ? setPagination(false) : setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
       pagination == 1 ? setPagination(false) : setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  //CLEAR ALL NOTIFICATION LIST
  Future<void> clearAllNotificationList(
      BuildContext context, String screen) async {
    setLoading(true);
    debugPrint("isLoading: $isLoading");
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.deleteAllNotificationUrl, {});
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      deleteAllNotificationModel =
          DeleteAllNotificationModel.fromJson(responseBody);
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      setLoading(false);
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  //MARK ALL READ NOTIFICATION LIST
  Future<void> markSingleReadNotification(
      BuildContext context, String screen, String id) async {
    debugPrint("isLoading: $isLoading");
    try {
      Response response = await apiRepo
          .getData(context, screen, ApiUrl.markSingleNotificationUrl, {
        "id": id,
      });
      final responseBody = response.data;
      debugPrint("response body ===============>>> $responseBody");
      markSingleReadNotificationModel =
          MarkSingleReadNotificationModel.fromJson(responseBody);
      debugPrint("isLoading: $isLoading");
    } catch (e) {
      debugPrint("isLoading: $isLoading");
    }
    notifyListeners();
  }

  // =========================================================================
  // loader dialog
  loaderDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(100),
          contentPadding: const EdgeInsets.all(25),
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            height: setWidgetHeight(80),
            width: setWidgetWidth(80),
            child: const CircularProgress(),
          ),
        );
      },
    );
  }
}
