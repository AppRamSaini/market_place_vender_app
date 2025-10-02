import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:market_place_app/main.dart';
import 'package:market_place_app/screens/location/location_from_map.dart';
import 'package:market_place_app/utils/app_colors.dart';
import 'package:market_place_app/utils/app_router.dart';
import 'package:market_place_app/utils/app_styles.dart';
import 'package:market_place_app/utils/custom_appbar.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});


  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController controller = TextEditingController();
  List predictions = [];
  LatLng? selectedLatLng;
  Position? currentPosition;

  // Address details
  String countryCode = "IN";
  String street = "";
  String locality = "";
  String city = "";
  String stateName = "";
  String country = "";
  String postalCode = "";

  @override
  void initState() {
    super.initState();
    _getUserCountry();
  }

  /// Get current location & user country code
  Future<void> _getUserCountry() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentPosition!.latitude},${currentPosition!.longitude}&key=$GOOGLE_MAP_API_KEY";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['results'].isNotEmpty) {
          for (var comp in result['results'][0]['address_components']) {
            if ((comp['types'] as List).contains('country')) {
              setState(() => countryCode = comp['short_name']);
              break;
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error in _getUserCountry: $e");
    }
  }

  /// Get search predictions
  Future<void> getPlacePredictions(String input) async {
    if (input.isEmpty) {
      setState(() => predictions = []);
      return;
    }
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:$countryCode&key=$GOOGLE_MAP_API_KEY";
      final response = await http.get(Uri.parse(url));

      print('----->>>>${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() => predictions = result['predictions']);
      }
    } catch (e) {
      debugPrint("Error fetching predictions: $e");
      setState(() => predictions = []);
    }
  }

  /// Get Place Details by Place ID
  Future<void> getPlaceDetail(String placeId) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_MAP_API_KEY";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final location = result['result']['geometry']['location'];
        final components = result['result']['address_components'];

        String streetLocal = "";
        String localityLocal = "";
        String cityName = "";
        String stateArea = "";
        String countryName = "";
        String postal = "";

        for (var comp in components) {
          List types = comp['types'];
          if (types.contains('street_number')) streetLocal = comp['long_name'];
          if (types.contains('route')) streetLocal += " ${comp['long_name']}";
          if (types.contains('sublocality') || types.contains('neighborhood')) {
            localityLocal = comp['long_name'];
          }
          if (types.contains('locality')) cityName = comp['long_name'];
          if (types.contains('administrative_area_level_1')) {
            stateArea = comp['long_name'];
          }
          if (types.contains('country')) countryName = comp['long_name'];
          if (types.contains('postal_code')) postal = comp['long_name'];
        }

        setState(() {
          selectedLatLng = LatLng(location['lat'], location['lng']);
          controller.text = result['result']['name'];
          street = streetLocal;
          locality = localityLocal;
          city = cityName;
          stateName = stateArea;
          country = countryName;
          postalCode = postal;
          predictions = [];
        });
      }
    } catch (e) {
      debugPrint("Error fetching place detail: $e");
    }
  }

  /// Confirm & return selected location
  void confirmLocation() {
    if (selectedLatLng == null) return;
    Navigator.pop(context, {
      "name": controller.text,
      "lat": selectedLatLng!.latitude,
      "lng": selectedLatLng!.longitude,
      "street": street,
      "locality": locality,
      "city": city,
      "state": stateName,
      "country": country,
      "postal": postalCode,
    });
  }

  /// Calculate distance from current location to placeId
  Future<String> _calculateDistance(String placeId) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_MAP_API_KEY";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final location = result['result']['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];

        if (currentPosition != null) {
          final distanceInMeters = Geolocator.distanceBetween(
            currentPosition!.latitude,
            currentPosition!.longitude,
            lat,
            lng,
          );
          return (distanceInMeters / 1000).toStringAsFixed(1);
        }
      }
    } catch (e) {
      debugPrint("Error calculating distance: $e");
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context: context,
        title: "Search your business location"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search location",
                  prefixIcon: Icon(Icons.search, color: AppColors.themeColor),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      setState(() => predictions = []);
                    },
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: getPlacePredictions,
              ),
            ),
            const SizedBox(height: 12),

            // 🌍 Select on Map
            GestureDetector(
              onTap: ()=>AppRouter().navigateTo(context, PickLocationPage()),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.theme5,
                  border: Border.all(color: AppColors.theme20),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_searching_sharp,
                        color: AppColors.themeColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "Select on map",
                      style: AppStyle.normal_16(AppColors.themeColor),
                    ),
                  ],
                ),
              ),
            ),

            // 📍 Predictions List
            Expanded(
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  final prediction = predictions[index];
                  final mainText =
                  prediction['structured_formatting']['main_text'];
                  final secondaryText =
                  prediction['structured_formatting']['secondary_text'];

                  return ListTile(
                    leading: Icon(Icons.location_on,
                        color: AppColors.themeColor),
                    title: Text(
                      mainText ?? "",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    subtitle: FutureBuilder<String>(
                      future: _calculateDistance(prediction['place_id']),
                      builder: (context, snapshot) {
                        final distance =
                        snapshot.hasData && snapshot.data!.isNotEmpty
                            ? " • ${snapshot.data} km"
                            : "";
                        return Text(
                          "${secondaryText ?? ''}$distance",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[700]),
                        );
                      },
                    ),
                    trailing: const Icon(Icons.favorite_border,
                        size: 20, color: Colors.grey),
                    onTap: () => getPlaceDetail(prediction['place_id']),
                  );
                },
              ),
            ),

            // ✅ Selected Location Card
            if (selectedLatLng != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Selected Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor)),
                    const SizedBox(height: 6),
                    Text(controller.text,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500)),
                    Text(
                      [
                        if (street.isNotEmpty) street,
                        if (locality.isNotEmpty) locality,
                        if (city.isNotEmpty) city,
                        if (stateName.isNotEmpty) stateName,
                        if (country.isNotEmpty) country,
                        if (postalCode.isNotEmpty) postalCode
                      ].join(' '),
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: selectedLatLng != null
          ? FloatingActionButton.extended(
        onPressed: confirmLocation,
        backgroundColor: AppColors.themeColor,
        label: const Text("Confirm Location"),
        icon: const Icon(Icons.check),
      )
          : null,
    );
  }
}
