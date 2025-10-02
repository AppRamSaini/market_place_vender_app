import 'package:dio/dio.dart';
import 'package:market_place_app/bloc/home_data_bloc/homepage_bloc/homepage_event.dart';
import 'package:market_place_app/bloc/merchant_offers/add_offers/add_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/delete_offers/delete_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/disable_offers/disable_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/disable_offers/disable_offers_state.dart';
import 'package:market_place_app/bloc/merchant_offers/update_offers/update_offers_event.dart';
import 'package:market_place_app/data/models/add_offers_model.dart';
import 'package:market_place_app/data/models/delivery_details_model.dart';
import 'package:market_place_app/data/models/delivery_listing_model.dart';
import 'package:market_place_app/data/models/disable_offers_model.dart';
import 'package:market_place_app/data/models/fetchoffers_model.dart';
import 'package:market_place_app/data/models/home_data_model.dart';
import 'package:market_place_app/data/models/offers_detail_model.dart';
import 'package:market_place_app/utils/exports.dart';

class OffersRepository {
  final api = ApiManager();

  /// fetch offers list data
  Future fetchOffersListApi() async {
    final result = await api.get(url: ApiEndPoints.fetchOffers);
    print('----offers------>>>>>$result');
    if (result is String) {
      return result;
    } else {
      return FetchOffersListModel.fromJson(result);
    }
  }

  /// fetch offers list data
  Future fetchOffersDetailsApi(String offersId) async {
    final result = await api.get(url:"${ApiEndPoints.viewOffers}/$offersId");
    print('sdsdsfsdsdsds====$result');
    if (result is String) {
      return result;
    } else {
      return OffersDetailModel.fromJson(result);
    }
  }

  ///  create offers api
  Future createOffersApi(SubmitOffersEvent event) async {
    var data = {
      "title": event.merchant.title,
      "description": event.merchant.description,
      "expiryDate": event.merchant.expiryDate.toString(),
      "discountPercentage": event.merchant.discountPercentage,
      "maxDiscountCap": event.merchant.maxDiscountCap,
      "minBillAmount": event.merchant.minBillAmount,
      "amount": event.merchant.amount,
      // if (event.merchant.image != null) 'image': event.merchant.image!,
      "image":
          "https://i.insider.com/5357f96b6bb3f72d0ce151c9?width=800&format=jpeg"
    };
    final result = await api.post(url: ApiEndPoints.addOffers, data: data);
    if (result is String) {
      return result;
    } else {
      return SubmitOffersModel.fromJson(result);
    }
  }

  ///  create offers api
  Future updateOffersApi(SubmitUpdateOffersEvent event) async {
    var data = {
      "title": event.merchant.title,
      "description": event.merchant.description,
      "expiryDate": event.merchant.expiryDate.toString(),
      "discountPercentage": event.merchant.discountPercentage,
      "maxDiscountCap": event.merchant.maxDiscountCap,
      "minBillAmount": event.merchant.minBillAmount,
      "amount": event.merchant.amount,
      // if (event.merchant.image != null) 'image': event.merchant.image!,
      "image":
          "https://i.insider.com/5357f96b6bb3f72d0ce151c9?width=800&format=jpeg"
    };
    final result = await api.post(
        url: "${ApiEndPoints.updateOffers}/${event.offersId}", data: data);
    print('---------->>>>>$result');
    if (result is String) {
      return result;
    } else {
      return SubmitOffersModel.fromJson(result);
    }
  }

  ///  disable offers api
  Future disableOffersApi(DisableOffersSubmit event) async {
    final result = await api.get(
        url: "${ApiEndPoints.disableOffers}/${event.offersId}/${event.status}");
    print('---------->>>>>$result');
    if (result is String) {
      return result;
    } else {
      return DisableOffersModel.fromJson(result);
    }


  }

  ///  delete offers api
  Future deleteOffersApi(DeleteOffersSubmit event) async {
    print("${ApiEndPoints.deleteOffers}/${event.offersId}");
    final result = await api
        .post(url: "${ApiEndPoints.deleteOffers}/${event.offersId}", data: {});
    print('---------->>>>>$result');
    return result;
  }
}
