import 'package:flutter/cupertino.dart';

abstract class DriverProfileEvent {}

class FetchDriverProfileEvent extends DriverProfileEvent {
  final BuildContext context;
  FetchDriverProfileEvent({required this.context});
}

class ResetDriverProfileEvent extends DriverProfileEvent {}
