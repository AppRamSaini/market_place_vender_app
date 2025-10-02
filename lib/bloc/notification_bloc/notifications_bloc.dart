import 'package:market_place_app/bloc/notification_bloc/notifications_event.dart';
import 'package:market_place_app/bloc/notification_bloc/notifications_state.dart';
import 'package:market_place_app/data/models/get_notification_model.dart';
import 'package:market_place_app/data/models/notification_types_model.dart';
import 'package:market_place_app/data/repository/notification_repo.dart';
import 'package:market_place_app/utils/exports.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final notificationRepo = NotificationsRepository();
  NotificationTypesModel? _notificationTypesModel;
  NotificationsBloc() : super(NotificationsInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<FetchNotificationsTypesEvent>(_onFetchNotificationsTypes);
  }
  Future<void> _onFetchNotifications(
      FetchNotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationsLoading());
    try {
      final notifications = await notificationRepo.fetchNotifications();
      if (notifications != null) {

        emit(NotificationsSuccess(getNotificationModel: notifications!));
      }
    } catch (e) {
      emit(NotificationsFailure(error: e.toString()));
    }
  }

  Future<void> _onFetchNotificationsTypes(FetchNotificationsTypesEvent event,
      Emitter<NotificationsState> emit) async {
    emit(NotificationsLoading());
    try {
      final notificationTypes =
          await notificationRepo.fetchNotificationsTypes(event.context);

      if (notificationTypes != null) {
        _notificationTypesModel = notificationTypes;
        emit(NotificationsTypesSuccess(
            notificationTypesModel: _notificationTypesModel!));
      }
    } catch (e) {
      emit(NotificationsFailure(error: e.toString()));
    }
  }


}

class NotificationsUpdateBloc
    extends Bloc<NotificationsEvent, UpdateNotificationsState> {
  final notificationRepo = NotificationsRepository();

  NotificationsUpdateBloc() : super(NotificationsUpdateInitial()) {
    on<UpdateNotificationSubmitted>(_updateNotificationTypes);
    on<ReadNotificationEvent>(_onReadNotification);
  }

  Future _updateNotificationTypes(UpdateNotificationSubmitted event,
      Emitter<UpdateNotificationsState> emit) async {
    final data = {'status': event.status};

    emit(NotificationsUpdateLoading());
    try {
      final response = await notificationRepo.updateNotificationTypes(
          event.context, event.notificationId, data);
      if (response != null) {
        emit(UpdateNotificationsSuccess(notificationUpdateModel: response));
      } else {
        emit(UpdateNotificationsInvalidResult());
      }
    } catch (e) {
      emit(UpdateNotificationsFailure(error: e.toString()));
    }
  }

  Future _onReadNotification(ReadNotificationEvent event,
      Emitter<UpdateNotificationsState> emit) async {
    emit(ReadNotificationLoading());
    try {
      final notification =
          await notificationRepo.readNotificationCountsApi(event.context);
      if (notification != null) {
        emit(ReadNotificationSuccess());
      } else {
        emit(UpdateNotificationsInvalidResult());
      }
    } catch (e) {
      emit(UpdateNotificationsFailure(error: e.toString()));
    }
  }
}
