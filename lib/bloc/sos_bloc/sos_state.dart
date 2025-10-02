import 'package:market_place_app/data/models/sos_history_model.dart';

abstract class SosState {}

class SosInitial extends SosState {}

class SosLoading extends SosState {}

class SosSuccess extends SosState {
  final String successMsg;
  SosSuccess({required this.successMsg});
}

/// sos history
class SosHistoryLoading extends SosState {}

class SosHistorySuccess extends SosState {
  final SosHistoryModel sosHistoryModel;
  SosHistorySuccess({required this.sosHistoryModel});
}

class SosFailure extends SosState {
  final String error;
  SosFailure({required this.error});
}

class InvalidSosResult extends SosState {}



/// sos cancel

abstract class CancelSosState {}

class CancelSosInitial extends CancelSosState {}

class CancelSosLoading extends CancelSosState {}

class CancelSosSuccess extends CancelSosState {
  final String  successMsg;
  CancelSosSuccess({required this.successMsg});
}

class CancelSosFailure extends CancelSosState {
  final String error;
  CancelSosFailure({required this.error});
}

class InvalidCancelSosResult extends CancelSosState {}
