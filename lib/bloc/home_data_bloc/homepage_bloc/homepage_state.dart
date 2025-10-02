import 'package:market_place_app/data/models/delivery_details_model.dart';
import 'package:market_place_app/data/models/delivery_listing_model.dart';
import 'package:market_place_app/data/models/home_data_model.dart';
import 'package:market_place_app/data/models/user_profile_model.dart';

abstract class HomeDataState {}

class HomeDataInitial extends HomeDataState {}

class HomeDataLoading extends HomeDataState {}

class HomeDataSuccess extends HomeDataState {
  final HomeDataModel homeDataModel;
  HomeDataSuccess({required this.homeDataModel});
}

class HomeDataFailure extends HomeDataState {
  final String error;
  HomeDataFailure({required this.error});
}

class HomeDataInvalidResult extends HomeDataState {}

/// delivery data state
abstract class DeliveryDataState {}

class DeliveryDataInitial extends DeliveryDataState {}

class DeliveryDataLoading extends DeliveryDataState {}

class DeliveryDataSuccess extends DeliveryDataState {
  final DeliveryListingModel deliveryListingModel;
  DeliveryDataSuccess({required this.deliveryListingModel});
}

class DeliveryDataFailure extends DeliveryDataState {
  final String error;
  DeliveryDataFailure({required this.error});
}

class DeliveryDataInvalidResult extends DeliveryDataState {}


/// delivery details data
abstract class DeliveryDetailState {}
class DeliveryDetailsInitial extends DeliveryDetailState {}
class DeliveryDetailsLoading extends DeliveryDetailState {}
class DeliveryDetailsSuccess extends DeliveryDetailState {
  final DeliveryDetailsModel deliveryDetailsModel;
  DeliveryDetailsSuccess({required this.deliveryDetailsModel});
}
class DeliveryDetailsFailure extends DeliveryDetailState {
  final String error;
  DeliveryDetailsFailure({required this.error});
}
class DeliveryDetailsInvalidResult extends DeliveryDataState {}

/// DELIVERY ACTION STATES
abstract class DeliveryActionsState {}
class DeliveryActionsInitial extends DeliveryActionsState {}

/// start
class DeliveryStartLoading extends DeliveryActionsState {}
class DeliveryStartSuccess extends DeliveryActionsState {
  final String successMsg ;
  DeliveryStartSuccess({required this.successMsg});
}


/// complete
class CompleteDeliveryLoading extends DeliveryActionsState {}
class CompleteDeliverySuccess extends DeliveryActionsState {
  final String successMsg ;
  CompleteDeliverySuccess({required this.successMsg});
}
class DeliveryActionsFailure extends DeliveryActionsState {
  final String error;
  DeliveryActionsFailure({required this.error});
}
class DeliveryActionsInvalidResult extends DeliveryActionsState {}


/// UPDATE LAT LNG  STATES
abstract class UpdateLatLngState {}
class  UpdateLatLngInitial extends UpdateLatLngState {}
class  UpdateLatLngLoading extends UpdateLatLngState {}
class  UpdateLatLngSuccess extends UpdateLatLngState {
  final String successMsg ;
  UpdateLatLngSuccess({required this.successMsg});
}
class  UpdateLatLngFailure extends UpdateLatLngState {
  final String error;
  UpdateLatLngFailure({required this.error});
}
