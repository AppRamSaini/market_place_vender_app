import 'package:flutter/cupertino.dart';

abstract class FetchBusinessDetailsEvent {}

class FetchBusinessDetailsDetailsEvent extends FetchBusinessDetailsEvent {
  final BuildContext context;
  FetchBusinessDetailsDetailsEvent({required this.context});
}

class ResetOffersEvent extends FetchBusinessDetailsEvent {}
