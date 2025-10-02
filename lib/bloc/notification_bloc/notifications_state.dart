

import 'package:market_place_app/data/models/get_notification_model.dart';
import 'package:market_place_app/data/models/notification_types_model.dart';
import 'package:market_place_app/data/models/notification_update_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final GetNotificationModel getNotificationModel;
  NotificationsSuccess({required this.getNotificationModel});
}

class NotificationsTypesSuccess extends NotificationsState {
  final NotificationTypesModel notificationTypesModel;
  NotificationsTypesSuccess({required this.notificationTypesModel});
}

class NotificationsFailure extends NotificationsState {
  final String error;
  NotificationsFailure({required this.error});
}



class NotificationsInvalidResult extends NotificationsState {}

/// for update notification bloc
abstract class UpdateNotificationsState {}

class NotificationsUpdateInitial extends UpdateNotificationsState {}

class NotificationsUpdateLoading extends UpdateNotificationsState {}

class UpdateNotificationsSuccess extends UpdateNotificationsState {
  final NotificationUpdateModel notificationUpdateModel;
  UpdateNotificationsSuccess({required this.notificationUpdateModel});
}

class ReadNotificationLoading extends UpdateNotificationsState {}

class ReadNotificationSuccess extends UpdateNotificationsState {}
class UpdateNotificationsInvalidResult extends UpdateNotificationsState {}
class UpdateNotificationsFailure extends UpdateNotificationsState {
  final String error;
  UpdateNotificationsFailure({required this.error});
}