import 'package:market_place_app/data/models/update_merchant_business_model.dart';

abstract class UpdateMerchantBusinessState {}

class UpdateMerchantBusinessInitial extends UpdateMerchantBusinessState {}

class UpdateMerchantBusinessLoading extends UpdateMerchantBusinessState {}

class UpdateMerchantBusinessSuccess extends UpdateMerchantBusinessState {
  final UpdateMerchantBusinessModel merchantBusinessModel;
  UpdateMerchantBusinessSuccess({required this.merchantBusinessModel});
}

class UpdateMerchantBusinessFailure extends UpdateMerchantBusinessState {
  final String error;
  UpdateMerchantBusinessFailure({required this.error});
}


class UpdateMerchantBusinessInvalidResult extends UpdateMerchantBusinessState{}