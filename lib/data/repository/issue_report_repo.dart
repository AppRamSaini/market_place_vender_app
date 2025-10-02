import 'package:http/http.dart' as http;
import 'package:market_place_app/data/models/issue_report_details_model.dart';
import 'package:market_place_app/data/models/issue_report_model.dart';
import 'package:market_place_app/data/storage/sharedpreferenc.dart';
import 'package:market_place_app/utils/exports.dart';

class IssueReportRepo {
  final api = ApiManager();

  /// fetch issue category apis
  Future fetchIssueCategory() async {
    final result = await api.get(url: ApiEndPoints.issueCategory);

    if (result is String) {
      return result;
    } else {
      return IssueCategoryModel.fromJson(result);
    }
  }

  /// create issue report api
  Future<dynamic> createIssueReport(
      BuildContext context, SubmitReportModel data) async {
    try {
      final token = LocalStorage.getString(Pref.token);

      final uri = Uri.parse(ApiEndPoints.createReport);

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..fields['action'] = data.action.toString()
        ..fields['description'] = data.description.toString()
        ..fields['issue_category_id'] = data.categoryUUID.toString()
        ..fields['delivery_uuid'] = data.deliveryUUID.toString()
        ..fields['priority'] = data.priority.toString();

      // ✅ Attach media files
      await _addFilesToRequest(request, 'photo[]', data.imageList!);
      await _addFilesToRequest(request, 'video[]', data.videoList!);
      await _addFilesToRequest(request, 'audio[]', data.audioList!);

      // ✅ Send the request
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);

      final rawResponse = utf8.decode(response.bodyBytes);
      print("Raw Response: $rawResponse");

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      print("Status: ${response.statusCode}");
      print("Response: $decodedData");

      print("ST--------------${response.statusCode}");

      if (response.statusCode == 200) {
        return decodedData;
      } else {
        snackBar(context, decodedData['message'].toString(), Colors.red);
        return null;
      }
    } on SocketException {
      snackBar(context, "No internet connection.", Colors.red);
      return null;
    } catch (e) {
      print("Exception: $e");
      snackBar(context, "Something went wrong: $e", Colors.red);
      return null;
    }
  }

  /// fetch issue report
  Future fetchIssueReportHistory(String type) async {
    final result =
        await api.get(url: "${ApiEndPoints.issueReportHistory}/$type");
    if (result is String) {
      return result;
    } else {
      return IssueReportHistoryModel.fromJson(result);
    }
  }

  /// fetch issue report details
  Future fetchIssueReportDetails(String uuid) async {
    final result =
        await api.get(url: "${ApiEndPoints.issueReportDetails}/$uuid");
    if (result is String) {
      return result;
    } else {
      return IssueReportDetailsModel.fromJson(result);
    }
  }
}

Future<void> _addFilesToRequest(
    http.MultipartRequest request, String fieldKey, List<File> files) async {
  for (File file in files) {
    final fileName = file.path.split('/').last;
    request.files.add(await http.MultipartFile.fromPath(fieldKey, file.path,
        filename: fileName));
  }
}
