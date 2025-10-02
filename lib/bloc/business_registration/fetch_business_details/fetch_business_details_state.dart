import 'package:market_place_app/data/models/merchant_business_profile_model.dart';

abstract class FetchBusinessDetailsState {}

class FetchBusinessDetailsInitial extends FetchBusinessDetailsState {}

class FetchBusinessDetailsLoading extends FetchBusinessDetailsState {}

class FetchBusinessDetailsSuccess extends FetchBusinessDetailsState {
  final MerchantBusinessProfileModel profileModel;
  FetchBusinessDetailsSuccess({required this.profileModel});
}
class FetchBusinessDetailsFailure extends FetchBusinessDetailsState {
  final String error;
  FetchBusinessDetailsFailure({required this.error});
}


class FetchBusinessDetailsInvalidResult extends FetchBusinessDetailsState {}

