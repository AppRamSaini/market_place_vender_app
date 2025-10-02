import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:market_place_app/utils/exports.dart';



final String googleAPIKey = dotenv.env['GOOGLE_MAP_API_KEY'] ?? 'https://default.com';
///DECODE POLYLINE DATA
List<LatLng> decodePolyline(String encoded) {
  List<LatLng> polyline = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;

    polyline.add(LatLng(lat / 1E5, lng / 1E5));
  }
  return polyline;
}

/// FIND LAT LNG FROM ADDRESS
Future getExactLatLongFromAddress(String address) async {

  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$googleAPIKey';

  final response = await http.get(Uri.parse(url));
  final data = jsonDecode(response.body);

  if (data['status'] == 'OK') {
    final location = data['results'][0]['geometry']['location'];
    final lat = location['lat'];
    final lng = location['lng'];
    print("Latitude: $lat, Longitude: $lng");
    return LatLng(lat, lng);
  } else {
    print("Error: ${data['status']}");
    return null;
  }
}

/// FIND LOCATION FROM LAT LNG
Future<String> getExactAddressFromLatLng(double lat, double lng) async {
  final url =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleAPIKey";

  final response = await http.get(Uri.parse(url));
  final data = json.decode(response.body);

  if (data['status'] == 'OK') {
    final results = data['results'];
    if (results.isNotEmpty) {
      return results[0]['formatted_address'];
    } else {
      return 'No address found';
    }
  } else {
    return 'Geocoding failed: ${data['status']}';
  }
}

/// FETCH THE CURRENT LOCATION
Future<LatLng> getPreciseUserLocation(BuildContext context) async {
  try {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw 'Location services are disabled.';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        snackBar(context, 'Location permission denied.', AppColors.themeColor1);
        throw 'Location permission denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      snackBar(context, 'Location permissions are permanently denied.',
          AppColors.themeColor1);
      throw 'Location permissions are permanently denied.';
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      timeLimit: Duration(seconds: 59),
    );

    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    print('Error fetching location: $e');
    rethrow;
  }
}
