import 'package:market_place_app/bloc/home_data_bloc/homepage_bloc/homepage_event.dart';
import 'package:market_place_app/data/models/delivery_details_model.dart';
import 'package:market_place_app/data/models/delivery_listing_model.dart';
import 'package:market_place_app/utils/exports.dart';

class DeliveryDataBloc extends Bloc<DeliveryDataEvent, DeliveryDataState> {
  DeliveryListingModel? _deliveryListingModel;

  final homeRepo = HomeDataRepository();

  DeliveryDataBloc() : super(DeliveryDataInitial()) {
    on<FetchDeliveryDataEvent>((event, emit) async {
      emit(DeliveryDataLoading());
      try {
        final deliveryListing =
            await homeRepo.fetchDeliveryListingData(event.type);

        if (deliveryListing is String) {
          emit(DeliveryDataFailure(error: deliveryListing.toString()));
        } else if (deliveryListing == null) {
          emit(
              DeliveryDataFailure(error: deliveryListing ?? 'Data not found!'));
        } else {
          _deliveryListingModel = deliveryListing;
          emit(DeliveryDataSuccess(
              deliveryListingModel: _deliveryListingModel!));
        }
      } catch (e) {
        emit(DeliveryDataFailure(error: e.toString()));
      }
    });
  }
}

class DeliveryDetailsBloc extends Bloc<DeliveryDataEvent, DeliveryDetailState> {
  final homeRepo = HomeDataRepository();
  DeliveryDetailsModel? _deliveryDetailsModel;
  DeliveryDetailsBloc() : super(DeliveryDetailsInitial()) {
    on<FetchDeliveryDetailsEvent>((event, emit) async {
      emit(DeliveryDetailsLoading());
      try {
        final deliveryListing =
            await homeRepo.fetchDeliveryDetailsData(event.uuid);

        if (deliveryListing is String) {
          emit(DeliveryDetailsFailure(error: deliveryListing.toString()));
        } else if (deliveryListing == null) {
          emit(DeliveryDetailsFailure(
              error: deliveryListing ?? 'Data not found!'));
        } else {
          _deliveryDetailsModel = deliveryListing;
          emit(DeliveryDetailsSuccess(
              deliveryDetailsModel: _deliveryDetailsModel!));
        }
      } catch (e) {
        emit(DeliveryDetailsFailure(error: e.toString()));
      }
    });
  }
}

/// DELIVERY ACTION BLOC
class DeliveryActionsBloc
    extends Bloc<DeliveryDataEvent, DeliveryActionsState> {
  final homeRepo = HomeDataRepository();
  DeliveryActionsBloc() : super(DeliveryActionsInitial()) {
    on<StartDeliveryEvent>(_onStartDeliver);
    on<CompleteDeliveryEvent>(_onCompleteDelivery);
  }

  /// start delivery api
  Future _onStartDeliver(
      StartDeliveryEvent event, Emitter<DeliveryActionsState> state) async {
    emit(DeliveryStartLoading());
    try {
      final response = await homeRepo.startDeliveryApi(event);
      if (response is String) {
        emit(DeliveryActionsFailure(error: response.toString()));
      } else if (response == null) {
        emit(DeliveryActionsFailure(
            error: "Something went wrong. Please try again!"));
      } else {
        emit(DeliveryStartSuccess(successMsg: response['message'].toString()));
      }
    } catch (e) {
      emit(DeliveryActionsFailure(error: e.toString()));
    }
  }


  /// complete delivery api
  Future _onCompleteDelivery(
      CompleteDeliveryEvent event, Emitter<DeliveryActionsState> state) async {
    emit(CompleteDeliveryLoading());
    try {
      final response = await homeRepo.completeDeliveryApi(event);
      if (response is String) {
        emit(DeliveryActionsFailure(error: response.toString()));
      } else if (response == null) {
        emit(DeliveryActionsFailure(
            error: "Something went wrong. Please try again!"));
      } else {
        emit(CompleteDeliverySuccess(successMsg: response['message'].toString()));
      }
    } catch (e) {
      emit(DeliveryActionsFailure(error: e.toString()));
    }
  }


}

/// DELIVERY ACTION BLOC
class UpdateLatLngBloc extends Bloc<DeliveryDataEvent, UpdateLatLngState> {
  final homeRepo = HomeDataRepository();
  UpdateLatLngBloc() : super(UpdateLatLngInitial()) {
    on<UpdateLatLngEvent>(_onUpdateLatLngApi);
  }

  /// update lat lng  api
  Future _onUpdateLatLngApi(
      UpdateLatLngEvent event, Emitter<UpdateLatLngState> state) async {
    emit(UpdateLatLngLoading());
    try {
      final response = await homeRepo.updateLocationCoordinateApi(event);
      print("------>>>>>${ApiEndPoints.updateCordinete}/${event.uuid}");

      if (response is String) {
        emit(UpdateLatLngFailure(error: response.toString()));
      } else if (response == null) {
        emit(UpdateLatLngFailure(
            error: "Something went wrong. Please try again!"));
      } else {
        emit(UpdateLatLngSuccess(successMsg: response['message'].toString()));
      }
    } catch (e) {
      emit(UpdateLatLngFailure(error: e.toString()));
    }
  }
}
