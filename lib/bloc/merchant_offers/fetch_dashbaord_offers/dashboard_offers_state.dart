import 'package:market_place_app/data/models/merchant_dashboard_model.dart';

abstract class FetchDashboardOffersState {}

class FetchDashboardOffersInitial extends FetchDashboardOffersState {}

class FetchDashboardOffersLoading extends FetchDashboardOffersState {}

class FetchDashboardOffersSuccess extends FetchDashboardOffersState {
  final MerchantDashboardModel merchantDashboardModel;
  FetchDashboardOffersSuccess({required this.merchantDashboardModel});
}

class FetchDashboardOffersFailure extends FetchDashboardOffersState {
  final String error;
  FetchDashboardOffersFailure({required this.error});
}

class FetchDashboardOffersInvalidResult extends FetchDashboardOffersState {}
