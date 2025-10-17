import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:market_place_app/utils/exports.dart';
class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}
class _PickLocationPageState extends State<PickLocationPage> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  String currentAddress = "Loading address...";
  bool isAddressLoading = true;

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    selectedLatLng = LatLng(position.latitude, position.longitude);

    _updateAddress(selectedLatLng!);

    setState(() {});
  }

  Future<void> _updateAddress(LatLng latLng) async {
    final pickupLatLng = await getExactAddressFromLatLng(
        latLng.latitude,latLng.longitude);

    print('----Ad--------->>>>>$pickupLatLng');
  }

  void _confirmLocation() {
    if (selectedLatLng == null) return;
    Navigator.pop(context, {
      "lat": selectedLatLng!.latitude,
      "lng": selectedLatLng!.longitude,
      "address": currentAddress,
    });

    _updateAddress(selectedLatLng!);

    print('lat---------->>>>${selectedLatLng!.latitude}');

    _updateAddress(selectedLatLng!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: selectedLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: selectedLatLng!, zoom: 16),
            onMapCreated: (controller) => mapController = controller,
            onCameraMove: (position) {
              selectedLatLng = position.target;
              _updateAddress(position.target); // update address while moving
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ]),
              child: Text(
                isAddressLoading ? "Loading..." : currentAddress,
                style: AppStyle.normal_14(AppColors.themeColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Icon(Icons.location_pin, size: 50, color: Colors.red),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.themeColor,
        onPressed: _confirmLocation,
        label: Text("Confirm Location",
            style: AppStyle.medium_16(AppColors.whiteColor)),
        icon: const Icon(Icons.check, color: AppColors.whiteColor),
      ),
    );
  }
}





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
        snackBar(context, 'Location permission denied.', AppColors.themeColor);
        throw 'Location permission denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      snackBar(context, 'Location permissions are permanently denied.',
          AppColors.themeColor);
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
