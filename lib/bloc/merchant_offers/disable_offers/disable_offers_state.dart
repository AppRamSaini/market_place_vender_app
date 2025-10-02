import 'package:market_place_app/data/models/disable_offers_model.dart';
import 'package:market_place_app/data/models/user_profile_model.dart';

abstract class DisableOffersState {}

class DisableOffersInitial extends DisableOffersState {}

class DisableOffersLoading extends DisableOffersState {}

class DisableOffersSuccess extends DisableOffersState {
  final DisableOffersModel disableOffersModel;
  DisableOffersSuccess({required this.disableOffersModel});
}
class DisableOffersFailure extends DisableOffersState {
  final String error;
  DisableOffersFailure({required this.error});
}


class DisableOffersInvalidResult extends DisableOffersState {}

