import 'package:dio/dio.dart';
import 'package:market_place_app/bloc/home_data_bloc/homepage_bloc/homepage_event.dart';
import 'package:market_place_app/data/models/delivery_details_model.dart';
import 'package:market_place_app/data/models/delivery_listing_model.dart';
import 'package:market_place_app/data/models/home_data_model.dart';
import 'package:market_place_app/utils/exports.dart';

class HomeDataRepository {
  final api = ApiManager();

  /// get home data
  Future fetchHomeData() async {
    final result = await api.get(url: ApiEndPoints.homeData);
    print('----homeData------>>>>>$result');
    if (result is String) {
      return result;
    } else {
      return HomeDataModel.fromJson(result);
    }
  }

  /// fetch delivery listing
  Future fetchDeliveryListingData(String type) async {
    print("${ApiEndPoints.deliveryListing}/$type");
    final result = await api.get(url: "${ApiEndPoints.deliveryListing}/$type");
    if (result is String) {
      return result;
    } else {
      return DeliveryListingModel.fromJson(result);
    }
  }

  /// fetch delivery listing  details
  Future fetchDeliveryDetailsData(var uuid) async {
    final result = await api.get(
      url: "${ApiEndPoints.deliveryDetails}/$uuid",
    );
    print('----delivery------>>>>>$result');
    if (result is String) {
      return result;
    } else {
      return DeliveryDetailsModel.fromJson(result);
    }
  }

  ///  start delivery api
  Future startDeliveryApi(StartDeliveryEvent event) async {
    var data = {
      "latitude": event.lat.toString(),
      "longitude": event.long.toString()
    };
    final result = await api.post(
        url: "${ApiEndPoints.startDeliver}/${event.uuid}", data: data);
    print('---------->>>>>$result');
    if (result is String) {
      snackBar(event.context, result, AppColors.redColor);
    } else {
      return result;
    }
  }

  ///  update location coordinates api
  Future updateLocationCoordinateApi(UpdateLatLngEvent event) async {
    var data = {
      "latitude": event.lat.toString(),
      "longitude": event.long.toString()
    };

    print("${ApiEndPoints.updateCordinete}/${event.uuid}");
    final result = await api.post(
        url: "${ApiEndPoints.updateCordinete}/${event.uuid}", data: data);
    if (result is String) {
      print('------>>>>$result');
    } else {
      return result;
    }
  }

  ///  complete delivery api
  Future completeDeliveryApi(CompleteDeliveryEvent event) async {
    var data = {
      "latitude": event.lat.toString(),
      "longitude": event.long.toString()
    };
    final result =
        await api.post(url: "${ApiEndPoints.completeDelivery}/${event.uuid}", data: data);
    print('---------->>>>>$result');
    if (result is String) {
      snackBar(event.context, result, AppColors.redColor);
    } else {
      return result;
    }
  }
}

