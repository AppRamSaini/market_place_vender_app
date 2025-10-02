import 'package:flutter/cupertino.dart';

abstract class DisableOffersEvent {}

class DisableOffersSubmit extends DisableOffersEvent {
  final BuildContext context;
  final String? offersId;
  final String? status;
  DisableOffersSubmit({required this.context,this.offersId, this.status});
}

class ResetOffersEvent extends DisableOffersEvent {}
