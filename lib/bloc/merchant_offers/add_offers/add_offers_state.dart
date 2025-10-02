import 'package:market_place_app/data/models/merchant_business_model.dart';
import 'package:market_place_app/data/models/user_model.dart';

import '../../../data/models/add_offers_model.dart';

abstract class AddOffersState {}

class AddOffersInitial extends AddOffersState {}

class AddOffersLoading extends AddOffersState {}

class AddOffersSuccess extends AddOffersState {
  final SubmitOffersModel offersModel;
  AddOffersSuccess({required this.offersModel});
}

class AddOffersFailure extends AddOffersState {
  final String error;
  AddOffersFailure({required this.error});
}


class AddOffersInvalidResult extends AddOffersState{}