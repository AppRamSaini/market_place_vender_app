import 'package:dio/dio.dart';
import 'package:market_place_app/data/storage/sharedpreferenc.dart';
import 'package:market_place_app/utils/exports.dart';

class ApiManager {
  final Dio _dio = Dio();

  /// POST method: Supports optional token and image upload
  /// POST method: Supports optional token and image upload
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> data,
    bool useToken = true,
  }) async {
    try {
      final token = useToken ? LocalStorage.getString(Pref.token) : null;

      final headers = {
        if (useToken && token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      dynamic requestData;
      bool hasFile =
          data.values.any((value) => value is File || value is List<File>);

      if (hasFile) {
        // 🔹 If any file is present → use FormData
        final formMap = <String, dynamic>{};
        for (var entry in data.entries) {
          final value = entry.value;

          if (value is File) {
            formMap[entry.key] = await MultipartFile.fromFile(
              value.path,
              filename: value.path.split('/').last,
            );
          } else if (value is List<File>) {
            formMap[entry.key] = await Future.wait(value.map((file) async {
              return await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              );
            }).toList());
          } else {
            formMap[entry.key] = value;
          }
        }
        requestData = FormData.fromMap(formMap);

        headers['Content-Type'] = 'multipart/form-data';
      } else {
        requestData = jsonEncode(data);
      }

      final response = await _dio.post(
        url,
        data: requestData,
        options: Options(
          headers: headers,
          sendTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
        ),
      );

      print('---------${response.statusCode}');
      print('---------$token');
      return _handleStatusCode(response);
    } on DioException catch (e) {
      print("DioException: $e");
      return _handleDioError(e);
    } catch (e) {
      print("Unknown error: $e");
      return "Something went wrong. Please try again.";
    }
  }

  /// 🔹 GET method: With optional query params and token
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParams,
    bool useToken = true,
  }) async {
    final token = useToken ? LocalStorage.getString(Pref.token) : null;
    print(url);
    print('TOKEN--->>$token');
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            if (useToken && token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json'
          },
          sendTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
        ),
      );
      return _handleStatusCode(response);
    } on DioException catch (e) {
      print("DioException: $e");
      return _handleDioError(e);
    } catch (e) {
      print("Unknown error: $e");
      return "Something went wrong. Please try again.";
    }
  }

  /// 🔹 Handle response status codes
  dynamic _handleStatusCode(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        return "Bad Request: ${response.data['message'] ?? 'Invalid input.'}";
      case 401:
        return "Unauthorized: Login required";
      case 403:
        return "Forbidden: Access denied.";
      case 404:
        return "Not Found: ${response.requestOptions.path}";
      case 500:
        return "Internal Server Error: Please try again later.";
      default:
        return "Unhandled status code: ${response.statusCode}";
    }
  }

  /// 🔹 Handle Dio Errors
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return "Connection timeout. Please check your network.";
      case DioExceptionType.badResponse:
        final message = e.response?.data['message'] ?? "Server error occurred.";
        return "$message";
      case DioExceptionType.cancel:
        return "Request cancelled.";
      case DioExceptionType.unknown:
        return "Unexpected error: ${e.message}";
      default:
        return "Network error occurred.";
    }
  }
}
