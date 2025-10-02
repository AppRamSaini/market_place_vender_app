import 'package:flutter/cupertino.dart';
import 'package:market_place_app/bloc/business_registration/create_business/business_registration_event.dart';

/// Base Event
abstract class UpdateMerchantBusinessEvent {}

class UpdateMerchantRegistrationEvent extends UpdateMerchantBusinessEvent {
  final MerchantRegistrationModel merchant;
  final BuildContext context;

  UpdateMerchantRegistrationEvent(this.merchant, this.context);
}

