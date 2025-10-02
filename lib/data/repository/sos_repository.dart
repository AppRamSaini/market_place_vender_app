import 'package:dio/dio.dart';
import 'package:market_place_app/bloc/home_data_bloc/homepage_bloc/homepage_event.dart';
import 'package:market_place_app/bloc/sos_bloc/sos_event.dart';
import 'package:market_place_app/data/models/delivery_details_model.dart';
import 'package:market_place_app/data/models/delivery_listing_model.dart';
import 'package:market_place_app/data/models/home_data_model.dart';
import 'package:market_place_app/data/models/sos_history_model.dart';
import 'package:market_place_app/utils/exports.dart';

class SosRepository {
  final api = ApiManager();

  /// sos history
  Future fetchSosHistory(String type) async {
    final result = await api.get(url: "${ApiEndPoints.sosHistory}/$type");
    if (result is String) {
      return result;
    } else {
      return SosHistoryModel.fromJson(result);
    }
  }

  ///  create sos api
  Future createSos(SubmitSosEvent event) async {
    var data = {
      "reason": event.reason,
      "location": event.location,
      "latitude": event.lat,
      "longitude": event.lng
    };
    final result = await api.post(url: ApiEndPoints.sosCreate, data: data);
    if (result is String) {
      snackBar(event.context, result);
    } else {
      return result;
    }
  }
  /// sos cancel
  Future cancelSos(BuildContext context, String uuid) async {
    final result = await api.get(url: "${ApiEndPoints.cancelSos}/$uuid");
    if (result is String) {
      snackBar(context, result.toString(),AppColors.redColor);
      return null;
    } else {
      return result;
    }
  }
}
