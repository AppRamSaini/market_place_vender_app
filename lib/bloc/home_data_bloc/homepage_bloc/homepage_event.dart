import 'package:market_place_app/utils/exports.dart';

abstract class HomeDataEvent {}

class FetchHomeDataEvent extends HomeDataEvent {
  final BuildContext context;
  FetchHomeDataEvent({required this.context});
}

abstract class DeliveryDataEvent {}

class FetchDeliveryDataEvent extends DeliveryDataEvent {
  final String type;
  FetchDeliveryDataEvent({required this.type});
}

class FetchDeliveryDetailsEvent extends DeliveryDataEvent {
  final String uuid;
  FetchDeliveryDetailsEvent({required this.uuid});
}

/// start delivery
class StartDeliveryEvent extends DeliveryDataEvent {
  final String uuid;
  final BuildContext context;
  final String lat;
  final String long;
  StartDeliveryEvent(
      {required this.uuid, required this.context,
        required this.lat, required this.long});
}


/// complete delivery
class CompleteDeliveryEvent extends DeliveryDataEvent {
  final String uuid;
  final BuildContext context;
  final String lat;
  final String long;
  CompleteDeliveryEvent(
      {required this.uuid, required this.context,
        required this.lat, required this.long});
}

class UpdateLatLngEvent extends DeliveryDataEvent {
  final String uuid;
  final BuildContext context;
  final String lat;
  final String long;
  UpdateLatLngEvent(
      {required this.uuid, required this.context,
        required this.lat, required this.long});
}

