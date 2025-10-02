import 'package:flutter/cupertino.dart';

abstract class SosEvent {}

class FetchSosEvent extends SosEvent {
  final String type;
  FetchSosEvent({required this.type});
}

class CancelSosEvent extends SosEvent {
  final String uuid;
  final BuildContext context;
  CancelSosEvent({required this.uuid,required this.context});
}

class SubmitSosEvent extends SosEvent {
  final BuildContext context;
  final String reason;
  final String location;
  final String lat;
  final String lng;
  SubmitSosEvent(
      {required this.context,
      required this.reason,
      required this.location,
      required this.lat,
      required this.lng});
}
