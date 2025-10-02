import 'package:market_place_app/data/models/merchant_business_model.dart';
import 'package:market_place_app/data/models/user_model.dart';

abstract class BusinessRegistrationState {}

class BusinessRegistrationInitial extends BusinessRegistrationState {}

class BusinessRegistrationLoading extends BusinessRegistrationState {}

class BusinessRegistrationSuccess extends BusinessRegistrationState {
  final MerchantBusinessModel merchantBusinessModel;
  BusinessRegistrationSuccess({required this.merchantBusinessModel});
}

class BusinessRegistrationFailure extends BusinessRegistrationState {
  final String error;
  BusinessRegistrationFailure({required this.error});
}


class BusinessRegistrationInvalidResult extends BusinessRegistrationState{}