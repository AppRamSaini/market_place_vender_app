import 'package:market_place_app/data/models/get_notification_model.dart';
import 'package:market_place_app/data/models/notification_types_model.dart';
import 'package:market_place_app/data/models/notification_update_model.dart';
import 'package:market_place_app/data/models/support_model.dart';
import 'package:market_place_app/utils/exports.dart';

class NotificationsRepository {
  final api = ApiManager();

  /// fetch notifications
  Future fetchNotifications() async {
    final result = await api.get(url: ApiEndPoints.notificationList);
    if (result is String) {
      return result;
    } else {
      return GetNotificationModel.fromJson(result);
    }
  }

  ///  read notification  counts api
  Future readNotificationCountsApi(BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.readNotification);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
    } else {
      return result;
    }
  }

  /// get notification types
  Future<NotificationTypesModel?> fetchNotificationsTypes(
      BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.notificationTypes);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return NotificationTypesModel.fromJson(result);
    }
  }

  ///  update notification api
  Future updateNotificationTypes(
      BuildContext context, var uuid, var data) async {
    final result = await api.post(
        url: "${ApiEndPoints.allowNotifications}/$uuid", data: data);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
    } else {
      return NotificationUpdateModel.fromJson(result);
    }
  }

  /// get support details
  Future fetchSupportDetails(BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.helpSupport);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return HelpSupportModel.fromJson(result);
    }
  }
}
